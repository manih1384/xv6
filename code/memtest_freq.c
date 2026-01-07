#include "types.h"
#include "user.h"
#include "param.h"

#define HOTPAGES   3
#define COLDPAGES  5
#define STRIDE     4096    

#define OUTER      50
#define INNER      100

#define NPROCS     2

static void
do_p3_workload(void)
{
  char *buf = sbrk((HOTPAGES + COLDPAGES) * STRIDE);
  if(buf == (char*)-1){
    printf(1, "memetest_freq: sbrk failed\n");
    exit();
  }

  uint hot[HOTPAGES];
  uint cold[COLDPAGES];

  for(int i = 0; i < HOTPAGES; i++)
    hot[i] = (uint)(buf + i * STRIDE);

  for(int j = 0; j < COLDPAGES; j++)
    cold[j] = (uint)(buf + (HOTPAGES + j) * STRIDE);

  for(int i = 0; i < HOTPAGES; i++)
    if(newpt_write(hot[i], i) < 0) exit();
  for(int j = 0; j < COLDPAGES; j++)
    if(newpt_write(cold[j], j) < 0) exit();

  for(int rep = 0; rep < OUTER; rep++){

    for(int i = 0; i < INNER; i++){
      (void)newpt_read(hot[0]);
      (void)newpt_read(hot[1]);
      (void)newpt_read(hot[2]);
    }

    for(int j = 0; j < COLDPAGES; j++){
      (void)newpt_read(cold[j]);
    }
  }

  exit();
}

int
main(void)
{
  printf(1, "\nmemetest_freq (Program 3)\n");

  for(int pol = 0; pol <= 3; pol++){
    printf(1, "\n--- Policy %d ---\n", pol);

    if(newpt_setpolicy(pol) < 0){
      printf(1, "memetest_freq: setpolicy failed\n");
      exit();
    }

    int start = uptime();

    for(int p = 0; p < NPROCS; p++){
      int pid = fork();
      if(pid < 0){
        printf(1, "memetest_freq: fork failed\n");
        exit();
      }
      if(pid == 0){
        do_p3_workload();
      }
    }

    for(int p = 0; p < NPROCS; p++)
      wait();

    newpt_report(start);
  }

  exit();
}
