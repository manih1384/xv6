#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define OUTPUT "result.txt"

static void reverse(char *s, int n) {
  int i = 0, j = n - 1;
  while (i < j) {
    char t = s[i]; s[i] = s[j]; s[j] = t;
    i++; j--;
  }
}

static int int_to_str(int num, char *buf) {
  int i = 0;


// base case
  if (num == 0) {
    buf[i++] = '0';
    buf[i] = '\0';
    return i;
  }


// check if final result in neg
  int neg = 0;
  if (num < 0) {
    neg = 1;
    num = -num;   
  }


  while (num > 0) {
    buf[i++] = '0' + (num % 10);
    num /= 10;
  }

//  add neg sign
  if (neg) buf[i++] = '-';


  reverse(buf, i);
  //end of line
  buf[i] = '\0';
  return i;
}



int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf(2, "Usage: find_sum <string>\n");
    exit();
  }

  int sum = 0;
  int in_num = 0;
  int cur = 0;

  for (int a = 1; a < argc; a++) {
    char *s = argv[a];
    for (int i = 0; s[i]; i++) {
      char c = s[i];
      if (c >= '0' && c <= '9') {
        in_num = 1;
        cur = cur * 10 + (c - '0');
      } else {
        if (in_num) {
          sum += cur;
          cur = 0;
          in_num = 0;
        }
      }
    }
    if (in_num) {
      sum += cur;
      cur = 0;
      in_num = 0;
    }
  }

  unlink(OUTPUT);
  int fd = open(OUTPUT, O_CREATE | O_WRONLY);
  if (fd < 0) {
    printf(2, "find_sum: cannot create %s\n", OUTPUT);
    exit();
  }

  char outbuf[32];
  int len = int_to_str(sum, outbuf);
  write(fd, outbuf, len);
  write(fd, "\n", 1);
  close(fd);

  exit();
}
