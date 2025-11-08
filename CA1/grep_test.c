#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  char buf[256];

  if(argc != 3){
    printf(2, "Usage: manual_grep keyword filename\n");
    exit();
  }

  char* keyword = argv[1];
  char* filename = argv[2];

  printf(1, "Searching for '%s' in file '%s'...\n", keyword, filename);

  int ret = grep_syscall(keyword, filename, buf, sizeof(buf));

  if (ret == 0) {
    printf(1, "Success! Found line: %s", buf);
  } else {
    printf(2, "Failure. Syscall returned %d.\n", ret);
  }

  exit();
}
