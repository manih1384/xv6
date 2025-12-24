#include "syscall.h"
#include "traps.h"

#define SYSCALL(name) \
  .globl name; \
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(pipe)
SYSCALL(read)
SYSCALL(write)
SYSCALL(close)
SYSCALL(kill)
SYSCALL(exec)
SYSCALL(open)
SYSCALL(mknod)
SYSCALL(unlink)
SYSCALL(fstat)
SYSCALL(link)
SYSCALL(mkdir)
SYSCALL(chdir)
SYSCALL(dup)
SYSCALL(getpid)
SYSCALL(sbrk)
SYSCALL(sleep)
SYSCALL(uptime)
SYSCALL(make_duplicate)
SYSCALL(show_process_family)
SYSCALL(grep_syscall)
SYSCALL(set_priority_syscall) 
SYSCALL(start_measuring)
SYSCALL(stop_measuring)
SYSCALL(print_info)
SYSCALL(testlock_acquire)
SYSCALL(testlock_release)




#include "syscall.h"
#include "traps.h"

.globl simple_arithmetic_syscall
simple_arithmetic_syscall:
    pushl %ebx              # preserve callee-saved register
    movl 8(%esp), %ebx      # a  (after pushl, first arg is at 8(%esp))
    movl 12(%esp), %ecx     # b
    movl $SYS_simple_arithmetic, %eax
    int $T_SYSCALL          
    popl %ebx
    ret

