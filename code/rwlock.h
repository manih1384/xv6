#ifndef _RWLOCK_H_
#define _RWLOCK_H_

#include "types.h"
#include "spinlock.h"

struct rwlock {
  struct spinlock lk;     
  char *name;

  int readers;           
  int writer;                
};

void rwlock_init(struct rwlock *rw, char *name);

void rwlock_acquire_read(struct rwlock *rw);
void rwlock_release_read(struct rwlock *rw);

void rwlock_acquire_write(struct rwlock *rw);
void rwlock_release_write(struct rwlock *rw);

#endif
