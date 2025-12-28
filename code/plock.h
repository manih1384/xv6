#ifndef _PLOCK_H_
#define _PLOCK_H_

#include "spinlock.h"

// Forward declaration of struct proc to avoid include loops
struct proc;


struct plock_node {
  struct proc *proc;      
  int priority;          
  struct plock_node *next; 
};

struct plock {
  struct spinlock lk;     
  uint locked;             
  char *name;              
  
  struct plock_node *head; 
};

#endif // _PLOCK_H_
