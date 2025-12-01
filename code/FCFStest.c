
#include "types.h"
#include "stat.h"
#include "user.h"

void
spin(long long n)
{
  volatile long long i;
  for(i = 0; i < n; i++){
    // vola so we dont get optimzed by compiler
  }
}

int
main(int argc, char *argv[])
{
  int pid1, pid2, pid3;

  pid1 = fork();
  if(pid1 < 0){
    printf(1, "fcfstest: fork1 failed\n");
    exit();
  }
  if(pid1 == 0){
    printf(1, "child1 (pid %d) starting long work\n", getpid());
    spin(4000000);
    printf(1, "child1 (pid %d) finished\n", getpid());
    exit();
  }




  pid2 = fork();
  if(pid2 < 0){
    printf(1, "fcfstest: fork2 failed\n");
    exit();
  }
  if(pid2 == 0){
    printf(1, "child2 (pid %d) starting long work\n", getpid());
    spin(400000000);
    printf(1, "child2 (pid %d) finished\n", getpid());
    exit();
  }




  pid3 = fork();
  if(pid3 < 0){
    printf(1, "fcfstest: fork3 failed\n");
    exit();
  }
  if(pid3 == 0){
    printf(1, "child3 (pid %d) starting long work\n", getpid());
    spin(4000000);
    printf(1, "child3 (pid %d) finished\n", getpid());
    exit();
  }

  wait();
  wait();
  wait();

  printf(1, "fcfstest: all children finished, exiting\n");
  exit();
}
