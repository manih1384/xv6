#include "types.h"
#include "defs.h"
#include "spinlock.h"
#include "rwlock.h"

void
rwlock_init(struct rwlock *rw, char *name)
{
  initlock(&rw->lk, "rwlock");
  rw->name = name;
  rw->readers = 0;
  rw->writer = 0;
}



void
rwlock_acquire_read(struct rwlock *rw)
{
  acquire(&rw->lk);

  while(rw->writer){
    sleep(rw, &rw->lk);
  }

  rw->readers++;

  release(&rw->lk);
}

void
rwlock_release_read(struct rwlock *rw)
{
  acquire(&rw->lk);

  rw->readers--;

  if(rw->readers == 0){
    wakeup(rw);
  }

  release(&rw->lk);
}


void
rwlock_acquire_write(struct rwlock *rw)
{
  acquire(&rw->lk);

  while(rw->writer || rw->readers > 0){
    sleep(rw, &rw->lk);
  }

  rw->writer = 1;

  release(&rw->lk);
}


void
rwlock_release_write(struct rwlock *rw)
{
  acquire(&rw->lk);

  rw->writer = 0;

  wakeup(rw);

  release(&rw->lk);
}
