#ifndef _SLEEPLOCK_H_
#define _SLEEPLOCK_H_

#include "spinlock.h" 
// Long-term locks for processes
struct proc;   


struct sleeplock {
  uint locked;       // Is the lock held?
  struct spinlock lk; // spinlock protecting this sleep lock
  
  char *name;        // Name of lock.
  int pid;           // Process ID holding lock
  struct proc *owner; // Process holding lock
};

#endif // _SLEEPLOCK_H_