#include "types.h"
#include "user.h"
#include "param.h"

#define NPAGES   5
#define NLOOPS   4
#define STRIDE   4096
#define NPROCS   2
#define ROUNDS   300

static void
touch_pages_loop_readonly(void)
{
  char *buf = sbrk(NPAGES * STRIDE);
  if(buf == (char*)-1){
    printf(1, "memetest_loop: sbrk failed\n");
    exit();
  }

  for(int i = 0; i < NPAGES; i++){
    uint va = (uint)(buf + i * STRIDE);
    if(newpt_write(va, i) < 0){
      printf(1, "memetest_loop: warm-up write failed\n");
      exit();
    }
  }
  for(int r = 0; r < ROUNDS; r++){
    for(int j = 0; j < NLOOPS; j++){
      for(int i = 0; i < NPAGES; i++){
        uint va = (uint)(buf + i * STRIDE);
        (void)newpt_read(va);
      }
    }
  }

  exit();
}

int
main(void)
{
  printf(1, "\nmemetest_loop: circular working set READS (5 pages x 4 loops)\n");

  for(int pol = 0; pol <= 3; pol++){
    printf(1, "\n--- Policy %d ---\n", pol);

    if(newpt_setpolicy(pol) < 0){
      printf(1, "memetest_loop: setpolicy failed\n");
      exit();
    }

    int start = uptime();

    for(int p = 0; p < NPROCS; p++){
      int pid = fork();
      if(pid < 0){
        printf(1, "memetest_loop: fork failed\n");
        exit();
      }
      if(pid == 0){
        touch_pages_loop_readonly();
      }
    }

    for(int p = 0; p < NPROCS; p++)
      wait();

    newpt_report(start);
  }

  exit();
}
