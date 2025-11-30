#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define PRI_HIGH   0
#define PRI_NORMAL 1
#define PRI_LOW    2

void cpu_intensive_task(int priority_level, int pid) {
char* priority_str = "";
if (priority_level == PRI_HIGH) priority_str = "High";
if (priority_level == PRI_LOW) priority_str = "Low";

volatile unsigned long long i;
for (i = 0; i < 500000000; i++);

printf(1, "--> Child PID %d (Set to %s Priority) finished.\n", pid, priority_str);
}

int main(void) {
int pid1, pid2;


pid1 = fork();
if (pid1 == 0) {
    cpu_intensive_task(PRI_HIGH, getpid());
    exit();
}

pid2 = fork();
if (pid2 == 0) {
    cpu_intensive_task(PRI_LOW, getpid());
    exit();
}

set_priority_syscall(pid2, PRI_LOW);
set_priority_syscall(pid1, PRI_HIGH);


wait();
wait();

printf(1, "Priority scheduler test finished.\n");
exit();
}