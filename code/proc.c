#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "sleeplock.h"

#define SCHED_DEBUG 0
#define READYQ_DEBUG 0
#define BALANCE_DEBUG 0
#define PRI_HIGH 0
#define PRI_NORMAL 1
#define PRI_LOW 2
extern uint ticks;
extern int ncpu;
static int next_core = 0; // next CPU index to assign new procs

struct spinlock eval_lock;
int measurement_active = 0;
uint start_tick = 0;
int finished_processes = 0; // Variables for algorithm scheduling test

#define BALANCE_TICKS 5         // load balancing ticks
static int balance_ticks[NCPU]; // per-CPU counters, zero-initialized

struct
{
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int cpuid()
{
  return mycpu() - cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu *
mycpu(void)
{
  int apicid, i;

  if (readeflags() & FL_IF)
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i)
  {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// WARNING: these assume ptable.lock is already held.
static void
rq_push(struct cpu *c, struct proc *p)
{
  struct readyqueue *rq = &c->rq;

  if (rq->count >= NPROC)
  {
    panic("rq_push: runqueue full");
  }

  rq->procs[rq->count++] = p;
}

static void
rq_remove(struct cpu *c, struct proc *p)
{
  struct readyqueue *rq = &c->rq;
  int i;

  for (i = 0; i < rq->count; i++)
  {
    if (rq->procs[i] == p)
    {
      rq->procs[i] = rq->procs[rq->count - 1];
      rq->count--;
      return;
    }
  }
  // panic("rq_remove: proc not found in runqueue");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

static int
find_least_loaded_ecore(void)
{
  int best_core = 0;
  int best_load = cpus[0].rq.count;

  for (int i = 1; i < ncpu; i++)
  {
    if (i % 2 != 0)
      continue;

    if (cpus[i].rq.count < best_load)
    {
      best_core = i;
      best_load = cpus[i].rq.count;
    }
  }

  return best_core;
}

static int
find_least_loaded_pcore(void)
{
  int best_core = -1;
  int best_load = 0;

  for (int i = 0; i < ncpu; i++)
  {
    if (i % 2 == 0)
      continue;

    int load = cpus[i].rq.count;

    if (best_core < 0 || load < best_load)
    {
      best_core = i;
      best_load = load;
    }
  }

  return best_core;
}

static int
ecore_is_overloaded(int e_core, int p_core)
{
  if (p_core < 0)
    return 0;

  int E_load = cpus[e_core].rq.count;
  int P_load = cpus[p_core].rq.count;

  return (E_load >= P_load + 3);
}

static struct proc *
select_ecore_proc(int e_core)
{
  struct readyqueue *rq = &cpus[e_core].rq;

  for (int i = 0; i < rq->count; i++)
  {
    struct proc *p = rq->procs[i];

    if (p->pid == 1)
      continue;
    if (strncmp(p->name, "sh", 2) == 0)
      continue;

    return p;
  }

  return 0;
}

// Called from timer interrupt on every CPU with its cpu_id.
void load_balance_on_timer(int cpu_id)
{
  if (cpu_id % 2 != 0)
    return;

  balance_ticks[cpu_id]++;
  if (balance_ticks[cpu_id] < BALANCE_TICKS)
    return;

  balance_ticks[cpu_id] = 0;

  acquire(&ptable.lock);

  int p_core = find_least_loaded_pcore();
  if (!ecore_is_overloaded(cpu_id, p_core))
  {
    release(&ptable.lock);
    return;
  }

  struct proc *proc_to_move = select_ecore_proc(cpu_id);
  if (proc_to_move == 0)
  {
    // nothing we can push
    release(&ptable.lock);
    return;
  }

  rq_remove(&cpus[cpu_id], proc_to_move);

  proc_to_move->home_core = p_core;

  rq_push(&cpus[p_core], proc_to_move);

  if (BALANCE_DEBUG)
  {
    cprintf("BALANCE: moved pid %d from E%d to P%d (new Eload=%d, new Pload=%d)\n",
            proc_to_move->pid,
            cpu_id, p_core,
            cpus[cpu_id].rq.count,
            cpus[p_core].rq.count);
  }

  release(&ptable.lock);
}

// PAGEBREAK: 32
//  Look in the process table for an UNUSED proc.
//  If found, change state to EMBRYO and initialize
//  state required to run in the kernel.
//  Otherwise return 0.
static struct proc *
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if (p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  p->priority = PRI_NORMAL;

  p->creation_time = ticks;

  p->qticks = 0; // no ticks used yet in its timeslice

  // 4.2: Assign this process a "home" core similiar to round-robin.
  // p->home_core = next_core;
  // next_core = (next_core + 1) % ncpu;
  // 4.4 load balancing: assign to least loaded E-core
  p->home_core = find_least_loaded_ecore();

  release(&ptable.lock);

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
  {
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe *)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

// PAGEBREAK: 32
//  Set up first user process.
void userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();

  initproc = p;
  if ((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0; // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;
  p->priority = PRI_NORMAL;
  rq_push(&cpus[p->home_core], p);
  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if (n > 0)
  {
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  else if (n < 0)
  {
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if ((np = allocproc()) == 0)
  {
    return -1;
  }

  // Copy process state from proc.
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
  {
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for (i = 0; i < NOFILE; i++)
    if (curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;
  rq_push(&cpus[np->home_core], np);
  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if (curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for (fd = 0; fd < NOFILE; fd++)
  {
    if (curproc->ofile[fd])
    {
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  if (measurement_active)
  {
    finished_processes++;
  } // For testing we need to know how many tasks have finished so once they are done we increase the number by one
    // ONLY when we are measuring using measurement active.

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->parent == curproc)
    {
      p->parent = initproc;
      if (p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
  for (;;)
  {
    // Scan through table looking for exited children.
    havekids = 0;
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    {
      if (p->parent != curproc)
        continue;
      havekids = 1;
      if (p->state == ZOMBIE)
      {
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if (!havekids || curproc->killed)
    {
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); // DOC: wait-sleep
  }
}

// PAGEBREAK: 42
//  Per-CPU process scheduler.
//  Each CPU calls scheduler() after setting itself up.
//  Scheduler never returns.  It loops, doing:
//   - choose a process to run
//   - swtch to start running that process
//   - eventually that process transfers control
//       via swtch back to the scheduler.

// THIS IS THE SCHEDULER PRE MULTI READY QUEUEUES (4.3)
// void scheduler(void)
// {
//   struct cpu *c = mycpu();
//   c->proc = 0;

//   int id = c - cpus;
//   c->core_type = (id % 2 == 0) ? CORE_E : CORE_P;

//   static int last[NCPU] = {0};

//   for (;;)
//   {
//     // Enable interrupts on this processor.
//     sti();

//     // Loop over process table looking for process to run.
//     // To implement round-robin we start from last[id],
//     // not from the beginning of the table every time.
//     acquire(&ptable.lock);

//     struct proc *p = 0;

//     if (c->core_type == CORE_E)
//     {
//       int i;
//       int start = last[id];
//       for (i = 0; i < NPROC; i++)
//       {
//         int idx = (start + i) % NPROC;
//         if (ptable.proc[idx].state == RUNNABLE)
//         {
//           p = &ptable.proc[idx];
//           // Next time this CPU will start scanning after this process.
//           last[id] = (idx + 1) % NPROC;
//           break;
//         }
//       }
//     }
//     else
//     // P cores use FCFS
//     {
//       for (int i = 0; i < NPROC; i++)
//       {
//         // find the first RUNNABLE process
//         if (ptable.proc[i].state == RUNNABLE)
//         {
//           p = &ptable.proc[i];
//           break;
//         }
//       }
//       for (int i = 0; i < NPROC; i++)
//       {
//         // compare creation_time to implement FCFS among RUNNABLE processes
//         if (ptable.proc[i].state == RUNNABLE)
//         {
//           if (p->creation_time > ptable.proc[i].creation_time)
//           {
//             p = &ptable.proc[i];
//           }
//         }
//       }
//     }

//     if (p)
//     {
//       // Switch to chosen process. It is the process's job
//       // to release ptable.lock and then reacquire it
//       // before jumping back to us.
//       c->proc = p;
//       switchuvm(p);
//       p->qticks = 0;
//       p->state = RUNNING;
//       if (SCHED_DEBUG)
//       {
//         cprintf("SCHED: cpu %d core_type %s running pid %d (ct=%d)\n",
//                 id,
//                 (c->core_type == CORE_E ? "E" : "P"),
//                 p->pid,
//                 p->creation_time);
//       }

//       swtch(&c->scheduler, p->context);
//       switchkvm();

//       // Process is done running for now.
//       // It should have changed its p->state before coming back.
//       c->proc = 0;
//     }

//     release(&ptable.lock);
//   }
// }

static void
check_runqueue_invariants(void)
{

#if READYQ_DEBUG
  // every ready process can be in one ready queue only.
  for (struct proc *p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state != RUNNABLE)
      continue;

    int found = 0;
    for (int cid = 0; cid < ncpu; cid++)
    {
      struct readyqueue *rq = &cpus[cid].rq;
      for (int i = 0; i < rq->count; i++)
      {
        if (rq->procs[i] == p)
        {
          found++;
        }
      }
    }
    if (found != 1)
    {
      cprintf("PROBLEM: pid %d RUNNABLE but in %d queues\n",
              p->pid, found);
    }
  }

  // Every process in any readyqueue must be RUNNABLE.
  for (int cid = 0; cid < ncpu; cid++)
  {
    struct readyqueue *rq = &cpus[cid].rq;
    for (int i = 0; i < rq->count; i++)
    {
      struct proc *p = rq->procs[i];
      if (p->state != RUNNABLE)
      {
        cprintf("PROBLEM: cpu %d queue has pid %d with state %d\n",
                cid, p->pid, p->state);
      }
    }
  }
#endif
}

void scheduler(void)
{
  struct cpu *c = mycpu();
  c->proc = 0;

  int id = c - cpus;
  c->core_type = (id % 2 == 0) ? CORE_E : CORE_P;

  static int last[NCPU] = {0};

  for (;;)
  {
    // Enable interrupts on this processor.
    sti();

    acquire(&ptable.lock);
    check_runqueue_invariants();
    struct proc *p = 0;
    struct readyqueue *rq = &c->rq;

    if (rq->count > 0)
    {
      if (c->core_type == CORE_E)
      {
        p = rq->procs[0];
        rq_remove(c, p);
      }
      else
      {

        struct proc *best = 0;

        for (int i = 0; i < rq->count; i++)
        {
          struct proc *cand = rq->procs[i];
          if (cand->state != RUNNABLE)
            continue;

          if (best == 0 || cand->creation_time < best->creation_time)
            best = cand;
        }

        if (best)
        {
          p = best;
          rq_remove(c, p);
        }
      }
    }

    // If no process found in runqueue, scan entire ptable as fallback
    // if (p == 0)
    // {

    //   if (c->core_type == CORE_E)
    //   {
    //     int start = last[id];

    //     for (int i = 0; i < NPROC; i++)
    //     {
    //       int idx = (start + i) % NPROC;
    //       if (ptable.proc[idx].state != RUNNABLE)
    //         continue;
    //       if (ptable.proc[idx].home_core != id)
    //         continue;

    //       p = &ptable.proc[idx];
    //       last[id] = (idx + 1) % NPROC;
    //       break;
    //     }
    //   }
    //   else
    //   {
    //     // P cores use FCFS among this core's RUNNABLE procs
    //     struct proc *best = 0;

    //     for (int i = 0; i < NPROC; i++)
    //     {
    //       if (ptable.proc[i].state != RUNNABLE)
    //         continue;
    //       if (ptable.proc[i].home_core != id)
    //         continue;

    //       if (best == 0 || ptable.proc[i].creation_time < best->creation_time)
    //         best = &ptable.proc[i];
    //     }

    //     p = best;
    //   }
    // }

    if (p)
    {
      c->proc = p;
      switchuvm(p);
      p->qticks = 0;
      p->state = RUNNING;

      if (SCHED_DEBUG)
      {
        cprintf("SCHED: cpu %d core_type %s running pid %d (ct=%d, home=%d)\n",
                id,
                (c->core_type == CORE_E ? "E" : "P"),
                p->pid,
                p->creation_time,
                p->home_core);
      }

      swtch(&c->scheduler, p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }

    release(&ptable.lock);
  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void sched(void)
{
  int intena;
  struct proc *p = myproc();

  if (!holding(&ptable.lock))
    panic("sched ptable.lock");
  if (mycpu()->ncli != 1)
    panic("sched locks");
  if (p->state == RUNNING)
    panic("sched running");
  if (readeflags() & FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.

void yield(void)
{
  struct proc *p = myproc();

  acquire(&ptable.lock); // DOC: yieldlock

  p->state = RUNNABLE;
  // put it back into its home core's ready queue
  rq_push(&cpus[p->home_core], p);

  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first)
  {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if (p == 0)
    panic("sleep");

  if (lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if (lk != &ptable.lock)
  {                        // DOC: sleeplock0
    acquire(&ptable.lock); // DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if (lk != &ptable.lock)
  { // DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

// PAGEBREAK!
//  Wake up all processes sleeping on chan.
//  The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == SLEEPING && p->chan == chan)
    {
      p->state = RUNNABLE;
      // enqueue on its home core's ready queue
      rq_push(&cpus[p->home_core], p);
    }
  }
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == pid)
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
      {
        p->state = RUNNABLE;
        rq_push(&cpus[p->home_core], p);
      }
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
  static char *states[] = {
      [UNUSED] "unused",
      [EMBRYO] "embryo",
      [SLEEPING] "sleep ",
      [RUNNABLE] "runble",
      [RUNNING] "run   ",
      [ZOMBIE] "zombie"};
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == UNUSED)
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if (p->state == SLEEPING)
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

int sys_show_process_family(void)
{
  struct proc *p;
  struct proc *target_proc = 0;
  struct proc *parent_proc = 0;
  int pid;
  int has_children = 0;
  int has_siblings = 0;

  if (argint(0, &pid) < 0)
    return -1;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == pid)
    {
      target_proc = p;
      break;
    }
  }

  if (target_proc == 0)
  {
    release(&ptable.lock);
    cprintf("Process with pid %d not found.\n", pid);
    return -1;
  }

  parent_proc = target_proc->parent;

  if (parent_proc)
  {
    cprintf("My id: %d, My parent id: %d\n", target_proc->pid, parent_proc->pid);
  }
  else
  {
    cprintf("My id: %d, My parent id: (none)\n", target_proc->pid);
  }

  cprintf("Children of process %d:\n", pid);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->parent == target_proc)
    {
      cprintf("Child pid: %d\n", p->pid);
      has_children = 1;
    }
  }
  if (!has_children)
  {
    cprintf("(No children)\n");
  }

  cprintf("Siblings of process %d:\n", pid);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (parent_proc && p->parent == parent_proc && p->pid != pid)
    {
      cprintf("Sibling pid: %d\n", p->pid);
      has_siblings = 1;
    }
  }
  if (!has_siblings)
  {
    cprintf("(No siblings)\n");
  }

  release(&ptable.lock);
  return 0;
}

int sys_set_priority_syscall(void)
{
  int pid, priority;
  struct proc *p;
  int found = 0;

  if (argint(0, &pid) < 0 || argint(1, &priority) < 0)
    return -1;

  if (priority < PRI_HIGH || priority > PRI_LOW)
    return -1;

  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == pid)
    {
      p->priority = priority;
      found = 1;
      break;
    }
  }
  release(&ptable.lock);

  if (found)
    return 0;
  else
    return -1;
}

// We will add functions fot the three systems calls, one for start measuring, one to stop and one to print its info
int start_measuring_impl(void)
// In this function we just need to set the variables to a start mode so setting them to
// their start values, finished process should be zero and start tick is required for measuring the time
// We also set measuring to active to we know we actually have started a test and can print it
{
  acquire(&ptable.lock);
  measurement_active = 1;
  finished_processes = 0;
  start_tick = ticks;
  release(&ptable.lock);
  return 0;
}

// Next we add stop measuring
int stop_measuring_impl(void)
{
  acquire(&ptable.lock);
  if (!measurement_active)
  {
    release(&ptable.lock);
    return -1;
  }

  uint end_tick = ticks;
  int count = finished_processes;
  measurement_active = 0; // Stop by setting this variable to zero meaning false and inactive
  release(&ptable.lock);

  uint duration = end_tick - start_tick;
  if (duration == 0)
    duration = 1;

  int throughput = (count * 1000) / duration;

  cprintf("\n[EVALUATION RESULT]\n");
  cprintf("Finished Processes: %d\n", count);
  cprintf("Total Time: %d ticks\n", duration);
  cprintf("Throughput: %d.%d processes/tick\n", throughput / 1000, throughput % 1000);
  cprintf("---------------------\n");

  return 0;
}

// And at last we need to print info of the measurement
int print_info_impl(void)
{
  struct proc *p;
  int core;
  int home;
  int creation;
  int pid;
  char *name;

  // 1. DISABLE INTERRUPTS to safely read CPU and Process data
  pushcli();

  if (myproc() == 0)
  {
    // Safety check: If called from scheduler when no process is running
    popcli();
    return -1;
  }

  p = myproc();
  core = cpuid(); // Now safe because interrupts are off

  // Copy data to local variables so we can print safely later
  pid = p->pid;
  name = p->name;
  home = p->home_core;
  creation = p->creation_time;

  popcli(); // 2. RE-ENABLE INTERRUPTS

  // 3. Logic
  char *algo = (core % 2 == 0) ? "Round Robin" : "FCFS (Modified)";

  // 4. Print (It is safer to print with interrupts enabled,
  //    so we do this after popcli)
  cprintf("[INFO] PID: %d | Name: %s | Core: %d (%s) | Home: %d | Created: %d\n",
          pid, name, core, algo, home, creation);

  return 0;
}