#include "types.h"
#include "user.h"

int
main(void)
{
  printf(1, "parent %d: acquiring lock\n", getpid());
  testlock_acquire();

  int pid = fork();
  if(pid == 0){
    printf(1, "child %d: trying to release lock\n", getpid());
    testlock_release();   // MUST panic
    printf(1, "ERROR: child released lock without panic!\n");
    exit();
  }

  wait();

  printf(1, "parent %d: releasing lock\n", getpid());
  testlock_release();
  exit();
}
