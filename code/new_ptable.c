#include "types.h"
#include "defs.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"
#include "new_ptable.h"

struct new_ptable new_pt;

void
new_ptable_init(void)
{
  initlock(&new_pt.lock, "new_ptable");
  new_pt.time = 0;
  new_pt.hand = 0;

  for(int i = 0; i < NEW_PT_NFRAMES; i++){
    new_pt.e[i].frame_kva = kalloc();   // alloc 4KB
    if(new_pt.e[i].frame_kva == 0)
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
void
new_ptable_dump(void)
{
  acquire(&new_pt.lock);
  cprintf("new_ptable dump:\n");
  for(int i = 0; i < NEW_PT_NFRAMES; i++){
    struct new_pt_entry *x = &new_pt.e[i];
    if(x->valid)
      cprintf("  slot %d: pid=%d vpn=%d frame=%p\n", i, x->pid, x->vpn, x->frame_kva);
    else
      cprintf("  slot %d: INVALID frame=%p\n", i, x->frame_kva);
  }
  release(&new_pt.lock);
}
