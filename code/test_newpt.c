#include "types.h"
#include "user.h"

int
main(void)
{
  int x = 0;

  newpt_write((uint)&x, 42);
  int y = newpt_read((uint)&x);

  printf(1, "value = %d\n", y);
  exit();
}
