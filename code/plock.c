#include "types.h"
#include "defs.h"
#include "param.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"
#include "plock.h"
struct plock p_lock;
void
plock_init(struct plock *pl)
{
  initlock(&pl->lk, "plock");
  pl->locked = 0;
  pl->head = 0;
  pl->name = "plock";
}

void
plock_acquire(struct plock *pl)
{
  acquire(&pl->lk);
  if(pl->locked == 0){
    pl->locked = 1;
    release(&pl->lk);
    return;
  }

  struct plock_node *node = (struct plock_node*)kalloc();
  node->proc = myproc();
  node->priority = myproc()-> priority;
  node->next = pl->head;
  pl->head = node;

  sleep(node, &pl->lk);

  kfree((char*)node);
  release(&pl->lk);
}

void
plock_release(struct plock *pl)
{
  acquire(&pl->lk);
  if(pl->head == 0){
    pl->locked = 0;
    release(&pl->lk);
    return;
  }

  struct plock_node *max_node = pl->head;
  struct plock_node *max_prev = 0;
  struct plock_node *curr = pl->head;
  struct plock_node *prev = 0;

  while(curr != 0){
    if(curr->priority > max_node->priority){
      max_node = curr;
      max_prev = prev;
    }
    prev = curr;
    curr = curr->next;
  }

  if(max_prev == 0){
    pl->head = max_node->next;
  } else {
    max_prev->next = max_node->next;
  }

  wakeup(max_node);
  release(&pl->lk);
}
