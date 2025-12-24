#include "types.h"
#include "user.h"

void
reader(int id, int hold)
{
  rwlock_acquire_read();
  printf(1, "Reader %d: entered\n", id);
  sleep(hold);
  printf(1, "Reader %d: leaving\n", id);
  rwlock_release_read();
  exit();
}

void
writer(int id, int hold)
{
  rwlock_acquire_write();
  printf(1, "Writer %d: ENTERED\n", id);
  sleep(hold);
  printf(1, "Writer %d: LEAVING\n", id);
  rwlock_release_write();
  exit();
}

int
main(void)
{
  printf(1, "\n Scenario 1: concurrent readers \n");
  if(fork() == 0) reader(0, 100);
  if(fork() == 0) reader(1, 100);
  if(fork() == 0) reader(2, 100);

  sleep(20);

  printf(1, "\n Scenario 2: writer waits for readers \n");
  if(fork() == 0) writer(0, 100);

  sleep(200);   

  printf(1, "\n Scenario 3: readers blocked by writer \n");
  if(fork() == 0) writer(1, 150);
  sleep(20);
  if(fork() == 0) reader(3, 80);
  if(fork() == 0) reader(4, 80);

  sleep(200);

  printf(1, "\n Scenario 4: alternating access \n");
  if(fork() == 0) reader(5, 60);
  sleep(10);
  if(fork() == 0) writer(2, 80);
  sleep(10);
  if(fork() == 0) reader(6, 60);


  for(int i = 0; i < 10; i++)
    wait();

  printf(1, "\nScenario test finished\n");
  exit();
}
