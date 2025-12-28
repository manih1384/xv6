
#ifndef _SPINLOCK_H_
#define _SPINLOCK_H_

#include "param.h"

// Mutual exclusion lock.
struct spinlock {
  uint locked;       // Is the lock held?

  // For debugging:
  char *name;        // Name of lock.
  struct cpu *cpu;   // The cpu holding the lock.
  uint pcs[10];      // The call stack (an array of program counters)
                     // that locked the lock.
  uint64 acq_count[NCPU];   // Number of times lock was acquired by each CPU
  uint64 total_spins[NCPU]; // Total spin loops by each CPU
};


#endif // _SLEEPLOCK_H_
