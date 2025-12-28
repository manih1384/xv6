#include "types.h"
#include "user.h"
#include "stat.h"
#include "param.h"


void
workload(int load)
{
  int i;
  for(i = 0; i < load; i++){
    uptime();
    sleep(0.5);
  }
}

int
main(void)
{
  uint64 scores[NCPU];
  int i, pid;
  int numOfChildren = 8;

  printf(1, "Starting Lock Contention Test on ptable.lock...\n");

  // Print Initial Stats
  getlockstat(scores);
  printf(1, "Initial Scores (Spins/Acquire):\n");
  for(i=0; i<NCPU; i++) printf(1, "CPU %d: %d\n", i, (int)scores[i]);

  printf(1, "\nRunning workload with %d children...\n", numOfChildren);

  // Create Contention (Fork children)
  for(i = 0; i < numOfChildren; i++){
    pid = fork();
    if(pid == 0){
      workload(10000);
      exit();
    }
  }

  // Wait for all to finish
  for(i = 0; i < numOfChildren; i++){
    wait();
  }

  // Print Final Stats
  getlockstat(scores);
  printf(1, "\nFinal Scores (Spins/Acquire):\n");
  for(i=0; i<NCPU; i++) printf(1, "CPU %d: %d\n", i, (int)scores[i]);

  exit();
}