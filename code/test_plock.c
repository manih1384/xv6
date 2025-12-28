#include "types.h"
#include "stat.h"
#include "user.h"

#define P_LOW 0     
#define P_MID 1
#define P_HIGH 2    

void
worker(int p)
{
  set_priority(p);
  printf(1, "[ARRIVED] PID %d (Prio %d) requesting lock...\n", getpid(), p);
  
  plock_acquire();
  
  printf(1, "!!! [ACQUIRED] PID %d (Prio %d) HAS THE LOCK !!!\n", getpid(), p);
  sleep(100); 
  printf(1, "[RELEASED] PID %d (Prio %d) releasing lock.\n", getpid(), p);
  
  plock_release();
  exit();
}

int
main(void)
{
  int pid;
  
  printf(1, "\n--- Priority Lock Test (Using 0, 1, 2) ---\n");


  pid = fork();
  if(pid == 0){
    set_priority(P_LOW);
    printf(1, "[START] PID %d (Prio %d - LOW) starting first.\n", getpid(), P_LOW);
    
    plock_acquire();
    
    printf(1, "[HOLDING] PID %d holding lock. Sleeping 3s to block others...\n", getpid());
    sleep(300); 
    
    printf(1, "[WAKEUP] PID %d releasing lock now.\n", getpid());
    plock_release();
    exit();
  }

  sleep(20); 

  pid = fork();
  if(pid == 0){
    worker(P_MID); 
  }
  sleep(20); 

  pid = fork();
  if(pid == 0){
    worker(P_HIGH); 
  }

  wait();
  wait();
  wait();

  printf(1, "\n--- Test Finished ---\n");
  exit();
}
