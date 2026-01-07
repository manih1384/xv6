#include "types.h"
#include "defs.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"
#include "new_ptable.h"
#include "proc.h"
// Declare ptable here (ONLY in this .c file)
extern struct
{
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

struct new_ptable new_pt;

enum new_pt_policy new_pt_policy = NEWPT_CLOCK;

uint new_pt_hits = 0;
uint new_pt_misses = 0;

void new_ptable_init(void)
{
  initlock(&new_pt.lock, "new_ptable");
  new_pt.time = 0;
  new_pt.hand = 0;

  for (int i = 0; i < NEW_PT_NFRAMES; i++)
  {
    new_pt.e[i].frame_kva = kalloc(); // alloc 4KB
    if (new_pt.e[i].frame_kva == 0)
      panic("new_ptable_init: kalloc failed");

    new_pt.e[i].valid = 0;
    new_pt.e[i].vpn = 0;
    new_pt.e[i].pid = -1;
    new_pt.e[i].load_time = 0;
    new_pt.e[i].last_used_time = 0;
    new_pt.e[i].use_count = 0;
    new_pt.e[i].refbit = 0;

    memset(new_pt.e[i].frame_kva, 0, PGSIZE); // zero the frame just in case
  }

  cprintf("new_ptable: initialized %d frames\n", NEW_PT_NFRAMES);
}

// helper function for later
void new_ptable_dump(void)
{
  // acquire(&new_pt.lock);
  cprintf("new_ptable dump:\n");
  for (int i = 0; i < NEW_PT_NFRAMES; i++)
  {
    struct new_pt_entry *x = &new_pt.e[i];
    if (x->valid)
      cprintf("  slot %d: pid=%d vpn=%d frame=%p\n", i, x->pid, x->vpn, x->frame_kva);
    else
      cprintf("  slot %d: INVALID frame=%p\n", i, x->frame_kva);
  }
  // release(&new_pt.lock);
}

uint vpn_from_va(uint va)
{
  return va / PGSIZE; // lower 12 bit are offset, we dont need them
}

// important note:  we dont need to grab lock here , the syscall later will do it , if we do it here we double lock.
int new_pt_lookup(int pid, uint vpn)
{
  for (int i = 0; i < NEW_PT_NFRAMES; i++)
  {
    struct new_pt_entry *e = &new_pt.e[i];
    if (e->valid && e->pid == pid && e->vpn == vpn)
    {
      return i;
    }
  }
  return -1;
}

int new_pt_find_free(void)
{
  for (int i = 0; i < NEW_PT_NFRAMES; i++)
  {
    if (new_pt.e[i].valid == 0)
      return i;
  }
  return -1;
}

// // bugged since you cant call walkpgdir it is static
// static char *
// userva_page_to_kva(struct proc *p, uint va_page)
// {
//   pte_t *pte = walkpgdir(p->pgdir, (char *)va_page, 0);
//   if (pte == 0)
//     return 0;
//   if ((*pte & PTE_P) == 0) // not present
//     return 0;

//   uint pa = PTE_ADDR(*pte); // physical address of that user page
//   return (char *)P2V(pa);
// }

static int writeback_victim(struct new_pt_entry *v);

static char *
newpt_uva2ka(pde_t *pgdir, uint uva)
{
  pde_t pde = pgdir[PDX(uva)];
  if ((pde & PTE_P) == 0)
    return 0;

  pte_t *pgtab = (pte_t *)P2V(PTE_ADDR(pde));
  pte_t pte = pgtab[PTX(uva)];
  if ((pte & PTE_P) == 0)
    return 0;
  if ((pte & PTE_U) == 0)
    return 0;

  return (char *)P2V(PTE_ADDR(pte));
}

int new_pt_check_page(struct proc *p, uint va)
{
  // must be user address
  if (va >= KERNBASE)
    return -1;

  // this line like rips off the offset leaving the base of page so we dont start copy from middle of the page.
  uint va_page = PGROUNDDOWN(va);

  uint vpn = vpn_from_va(va);

  // check1:  do we have the page already?
  int idx = new_pt_lookup(p->pid, vpn);
  if (idx >= 0)
  {
    new_pt.time++;
    new_pt_hits++;
    new_pt.e[idx].last_used_time = new_pt.time;
    new_pt.e[idx].use_count++;
    new_pt.e[idx].refbit = 1;
    return idx;
  }

  new_pt_misses++;

  // check2: if we dont have the page , are there free space or we need eviction
  int freei = new_pt_find_free();
  if (freei < 0)
  {
    int victim = new_pt_pick_victim();
    if (victim < 0)
      return -1;
    if (writeback_victim(&new_pt.e[victim]) < 0)
      return -1;

    freei = victim;
  }

  // Copy the real user page into our cached frame
  char *src = newpt_uva2ka(p->pgdir, va_page);
  if (src == 0)
    return -1;
  memmove(new_pt.e[freei].frame_kva, src, PGSIZE);

  new_pt.time++;
  new_pt.e[freei].pid = p->pid;
  new_pt.e[freei].vpn = vpn;
  new_pt.e[freei].valid = 1;
  new_pt.e[freei].load_time = new_pt.time;
  new_pt.e[freei].last_used_time = new_pt.time;
  new_pt.e[freei].use_count = 1;
  new_pt.e[freei].refbit = 1;

  new_ptable_dump();

  return freei;
}

int new_pt_pick_victim(void)
{
  int victim = -1;

  if (new_pt_policy == NEWPT_FIFO)
  {
    uint min = 0xFFFFFFFF;
    for (int i = 0; i < NEW_PT_NFRAMES; i++)
    {
      if (new_pt.e[i].load_time < min)
      {
        min = new_pt.e[i].load_time;
        victim = i;
      }
    }
  }

  else if (new_pt_policy == NEWPT_LRU)
  {
    uint min = 0xFFFFFFFF;
    for (int i = 0; i < NEW_PT_NFRAMES; i++)
    {
      if (new_pt.e[i].last_used_time < min)
      {
        min = new_pt.e[i].last_used_time;
        victim = i;
      }
    }
  }

  else if (new_pt_policy == NEWPT_LFU)
  {
    uint min = 0xFFFFFFFF;
    for (int i = 0; i < NEW_PT_NFRAMES; i++)
    {
      if (new_pt.e[i].use_count < min)
      {
        min = new_pt.e[i].use_count;
        victim = i;
      }
    }
  }

  else if (new_pt_policy == NEWPT_CLOCK)
  {
    while (1)
    {
      int i = new_pt.hand;
      if (new_pt.e[i].refbit == 0)
      {
        victim = i;
        new_pt.hand = (i + 1) % NEW_PT_NFRAMES;
        break;
      }
      new_pt.e[i].refbit = 0;
      new_pt.hand = (i + 1) % NEW_PT_NFRAMES;
    }
  }

  return victim;
}

static int
writeback_victim(struct new_pt_entry *v)
{
  struct proc *p = 0;

  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == v->pid)
    {
      break;
    }
  }
  release(&ptable.lock);

  if (p >= &ptable.proc[NPROC] || p->pid != v->pid)
    return -1;
  if(p->state == UNUSED || p->pgdir == 0)
  return -1;


  uint va_page = v->vpn * PGSIZE;
  char *dst = newpt_uva2ka(p->pgdir, va_page);
  // char *dst = userva_page_to_kva(p, va_page);
  if (dst == 0)
    return -1;
  memmove(dst, v->frame_kva, PGSIZE);
  return 0;
}
