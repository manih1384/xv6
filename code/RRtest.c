
#include "types.h"
#include "stat.h"
#include "user.h"

void
spin_forever(void)
{
  volatile int i;
  while(1){
    for(i = 0; i < 100000000; i++){
      // vola so we dont get optimzed by compiler
    }
  }
}

int
main(int argc, char *argv[])
{
  int n = 3; 
  int i;

  printf(1, "rrloop: starting %d children\n", n);

  for(i = 0; i < n; i++){
    int pid = fork();
    if(pid < 0){
      printf(1, "rrloop: fork failed\n");
      exit();
    }
    if(pid == 0){
      spin_forever();
      exit();
    }
  }

  while(1)
    sleep(100);
}
