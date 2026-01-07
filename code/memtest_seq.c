#include "types.h"
#include "user.h"
#include "param.h"

#define NPAGES   12        
#define STRIDE   4096     
#define NPROCS   2        
#define ROUNDS   200      

static void
touch_pages_seq(void)
{
  char *buf = sbrk(NPAGES * STRIDE);
  if(buf == (char*)-1){
    printf(1, "memetest_seq: sbrk failed\n");
    exit();
  }

  for(int r = 0; r < ROUNDS; r++){
    for(int i = 0; i < NPAGES; i++){
      uint va = (uint)(buf + i * STRIDE);

      if(newpt_write(va, i + r) < 0){
        printf(1, "memetest_seq: write failed at page %d\n", i);
        exit();
      }

      (void)newpt_read(va);
    }
  }

  exit();
}

int
main(void)
{
  printf(1, "\nmemetest_seq: sequential access\n");

  for(int pol = 0; pol <= 3; pol++){
    printf(1, "\n--- Policy %d ---\n", pol);

    if(newpt_setpolicy(pol) < 0){
      printf(1, "memetest_seq: setpolicy failed\n");
      exit();
    }

    int start = uptime();

    for(int p = 0; p < NPROCS; p++){
      int pid = fork();
      if(pid < 0){
        printf(1, "memetest_seq: fork failed\n");
        exit();
      }
      if(pid == 0){
        touch_pages_seq();
      }
    }

    for(int p = 0; p < NPROCS; p++)
      wait();

    newpt_report(start);
  }

  exit();
}
