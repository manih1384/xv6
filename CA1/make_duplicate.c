#include "types.h"
#include "user.h"

int main(int argc, char *argv[]) {
  if(argc < 2){
    printf(1, "usage: make_duplicate filename\n");
    exit();
  }

  int r = make_duplicate(argv[1]);
  exit();
}
