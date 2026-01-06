#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "sleeplock.h"
#include "rwlock.h"
#include "plock.h"
int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}



// it is void because we need to fetch them manually in a system call, from registers or stack
int sys_simple_arithmetic(void)
{
  int a, b, result;

  a = myproc()->tf->ebx;
  b = myproc()->tf->ecx;

  result = (a + b) * (a - b);

  cprintf("Calc: (%d+%d)*(%d-%d) = %d\n", a, b, a, b, result);

  return result;
}

int sys_start_measuring(void) {
  return start_measuring_impl();
}

int sys_stop_measuring(void) {
  return stop_measuring_impl();
}

int sys_print_info(void) {
  return print_info_impl();
}


// static struct sleeplock testlock;
// static int testlock_initialized = 0;

// int
// sys_testsleeplock(void)
// {
//   int pid;

//   if(!testlock_initialized){
//     initsleeplock(&testlock, "testlock");
//     testlock_initialized = 1;
//   }

//   acquiresleep(&testlock);
//   cprintf("testsleeplock: parenddddt acquired lock (pid=%d)\n", myproc()->pid);

//   pid = sys_fork();


//   if(pid < 0){
//     releasesleep(&testlock);
//     return -1;
//   }
//   if(pid == 0){
//     cprintf("testsleeplock: child attempting to release lock (pid=%d)\n", myproc()->pid);
     
//     // This SHOULD panic:
//     releasesleep(&testlock);

//     // If no panic, force failure visibility:
//     cprintf("testsleeplock: ERROR - child released without panic\n");
//     exit();     // never return to user main
//   }

//   // Parent: wait so output is clean
//   wait();

//   // If the child panicked, we never reach here.
//   releasesleep(&testlock);
//   return 0;
// }


static struct sleeplock testlock;
static int testlock_initialized = 0;

static void
init_testlock(void)
{
  if(!testlock_initialized){
    initsleeplock(&testlock, "testlock");
    testlock_initialized = 1;
  }
}

int
sys_testlock_acquire(void)
{
  init_testlock();
  acquiresleep(&testlock);
  cprintf("testlock: acquired by pid=%d\n", myproc()->pid);
  return 0;
}

int
sys_testlock_release(void)
{
  init_testlock();
  cprintf("testlock: release attempt by pid=%d\n", myproc()->pid);
  releasesleep(&testlock);   // CHILD SHOULD PANIC HERE
  return 0;
}



static struct rwlock testrw;
static int testrw_initialized = 0;

static void
init_rwlock_if_needed(void)
{
  if(!testrw_initialized){
    rwlock_init(&testrw, "testrw");
    testrw_initialized = 1;
  }
}

int
sys_rwlock_acquire_read(void)
{
  init_rwlock_if_needed();
  rwlock_acquire_read(&testrw);
  return 0;
}

int
sys_rwlock_release_read(void)
{
  rwlock_release_read(&testrw);
  return 0;
}

int
sys_rwlock_acquire_write(void)
{
  init_rwlock_if_needed();
  rwlock_acquire_write(&testrw);
  return 0;
}

int
sys_rwlock_release_write(void)
{
  rwlock_release_write(&testrw);
  return 0;
}

int
sys_getlockstat(void)
{
  uint64 *score;

  // Retrieve argument (pointer)
  if(argptr(0, (void*)&score, sizeof(uint64)*NCPU) < 0)
    return -1;

  // Call the helper in proc.c
  return get_ptable_stats(score);
}


extern struct plock p_lock;
void plock_acquire(struct plock*, int);
void plock_release(struct plock*);

int
sys_plock_acquire(void)
{
  int priority;
  if(argint(0, &priority) < 0)
    return -1;

  plock_acquire(&p_lock, priority);
  return 0;
}

int
sys_plock_release(void)
{
  plock_release(&p_lock);
  return 0;
}