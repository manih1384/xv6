#include "types.h"
#include "user.h"
#include "param.h"

#define PAGES     5
#define STRIDE    4096  

#define ITERS     100   
#define ROUNDS    300   
#define NPROCS    2

static void
do_p4_workload(void)
{
  char *buf = sbrk(PAGES * STRIDE);
  if(buf == (char*)-1){
    printf(1, "memetest_mix: sbrk failed\n");
    exit();
  }

  uint page[PAGES];
  for(int i = 0; i < PAGES; i++)
    page[i] = (uint)(buf + i * STRIDE);

  for(int i = 0; i < PAGES; i++)
    if(newpt_write(page[i], i) < 0)
      exit();


  for(int r = 0; r < ROUNDS; r++){
    for(int t = 0; t < ITERS; t++){
      (void)newpt_read(page[0]);
      (void)newpt_read(page[1]);
      (void)newpt_read(page[2]);
      (void)newpt_read(page[3]);

      (void)newpt_read(page[0]);
      (void)newpt_read(page[1]);

      (void)newpt_read(page[4]);
    }
  }

  exit();
}

int
main(void)
{
  printf(1, "\nmemetest_mix (Program 4)\n");

  for(int pol = 0; pol <= 3; pol++){
    printf(1, "\n--- Policy %d ---\n", pol);

    if(newpt_setpolicy(pol) < 0){
      printf(1, "memetest_mix: setpolicy failed\n");
      exit();
    }

    int start = uptime();

    for(int p = 0; p < NPROCS; p++){
      int pid = fork();
      if(pid < 0){
        printf(1, "memetest_mix: fork failed\n");
        exit();
      }
      if(pid == 0){
        do_p4_workload();
      }
    }

    for(int p = 0; p < NPROCS; p++)
      wait();

    newpt_report(start);
  }

  exit();
}
