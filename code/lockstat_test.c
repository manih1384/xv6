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
    getpid();
    sleep(1);
  }
}

int
main(void)
{
  uint64 scores_initial[NCPU];
  uint64 scores_final[NCPU];
  int i, pid;
  int numOfChildren = 8;

  printf(1, "Starting Lock Contention Test on ptable.lock...\n");

  getlockstat(scores_initial);

  printf(1, "\n[WORKLOAD REPORT] Initial\n");
  for(i=0; i<NCPU; i++) {
    if (scores_initial[i]>0) {
      printf(1, "CPU %d: Workload Score = %d\n", i, scores_initial[i]);
    }
  }

  printf(1, "\nRunning workload with %d children...\n", numOfChildren);

  for(i = 0; i < numOfChildren; i++){
    pid = fork();
    if(pid == 0){
      workload(1000);
      exit();
    }
  }
  for(i = 0; i < numOfChildren; i++){
    wait();
  }

  getlockstat(scores_final);

  printf(1, "\n[WORKLOAD REPORT] Initial\n");
  for(i=0; i<NCPU; i++) {
    if (scores_initial[i]>0) {
      printf(1, "CPU %d: Workload Score = %d\n", i, scores_initial[i]);
    }
  }

  printf(1, "\n[WORKLOAD REPORT] (Final - Initial)\n");
  for(i=0; i<NCPU; i++) {
      if(scores_initial[i] > 0) {
          int score_delta = (int)scores_final[i] - (int)scores_initial[i];
          printf(1, "CPU %d: Workload Score = %d\n", i, score_delta);
      }
  }
  
  exit();
}