#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

#define SCHED_DEBUG 0

#define QUANTUM_TICKS 3

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[]; // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;
extern struct
{
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

void tvinit(void)
{
  int i;

  for (i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE << 3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
}

void idtinit(void)
{
  lidt(idt, sizeof(idt));
}

// PAGEBREAK: 41
void trap(struct trapframe *tf)
{
  if (tf->trapno == T_SYSCALL)
  {
    if (myproc() && myproc()->killed)
      exit();
    if (myproc())
      myproc()->tf = tf;
    syscall();
    if (myproc() && myproc()->killed)
      exit();
    return;
  }

  switch (tf->trapno)
  {
  case T_IRQ0 + IRQ_TIMER:
    if (cpuid() == 0)
    {
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
    break;

  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;

  case T_IRQ0 + IRQ_IDE + 1:
    // Bochs generates spurious IDE1 interrupts.
    break;

  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;

  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;

  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;

  // PAGEBREAK: 13
  default:
    if (myproc() == 0 || (tf->cs & 3) == 0)
    {
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
  }
  // Force process exit if it has been killed and is in user space.
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
    exit();

  // periodic load balancing on timer interrupts
  if (tf->trapno == T_IRQ0 + IRQ_TIMER)
  {
    load_balance_on_timer(cpuid());
  }

  // Preempt if timer interrupt
  if (myproc() && myproc()->state == RUNNING && tf->trapno == T_IRQ0 + IRQ_TIMER)
  {

    struct proc *p = myproc();
    int id = cpuid();

    if (id % 2 == 0)
    {
      // E-core: 30 ms quantum (3 ticks)
      p->qticks++;

      if (SCHED_DEBUG)
        cprintf("TIMER: ticks %d cpu %d pid %d qticks %d\n",
                ticks, id, p->pid, p->qticks);

      if (p->qticks >= QUANTUM_TICKS)
      {
        // don't strictly need to zero here (scheduler does it),
        p->qticks = 0;
        yield();
      }
    }
    else
    {
      // P-core: check for preemption every tick
      int should_yield = 0;

      acquire(&ptable.lock);
      for (int i = 0; i < NPROC; i++)
      {
        if (ptable.proc[i].state == RUNNABLE)
        {
          if (p->creation_time > ptable.proc[i].creation_time)
          {
            should_yield = 1;
            if (SCHED_DEBUG)
            {
              cprintf("P-CORE PREEMPT: cpu %d curpid %d(ct=%d), better pid %d(ct=%d)\n",
                      id, p->pid, p->creation_time,
                      ptable.proc[i].pid, ptable.proc[i].creation_time);
            }
            break;
          }
        }
      }
      release(&ptable.lock);

      if (should_yield)
      {
        yield();
      }
    }
  }

  // Check if the process has been killed since we yielded.
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
    exit();
}
