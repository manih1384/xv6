#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  int a = 5, b = 3;
  if (argc == 3) {
    a = atoi(argv[1]);
    b = atoi(argv[2]);
  }
  int r = simple_arithmetic_syscall(a, b);
  printf(1, "user: (%d+%d)*(%d-%d) = %d\n", a, b, a, b, r);
  exit();
}
