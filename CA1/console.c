// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
int left_key_pressed=0;
int left_key_pressed_count=0;
int tab_pressed=0; // note i havent add the part where you make tab pressed zero again yet you can only set it to 1 once andd dont change it 
static void consputc(int);

static int panicked = 0;

static struct {
  struct spinlock lock;
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
    consputc(buf[i]);
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    for (int i = pos - 1 ; i < pos + left_key_pressed_count ; i++)
      crt[i] = crt[i + 1];

    if(pos > 0) --pos;
  }
  else{
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
      crt[i] = crt[i - 1];
    crt[pos++] = (c&0xff) | 0x0700; // black on white
  }

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos+left_key_pressed_count] = ' ' | 0x0700;
}

void
consputc(int c)
{
  if(panicked){
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}

#define INPUT_BUF 128
struct {
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
} input;


void print_array(char *buffer){
      for (int i = 0; i < input.e; i++)
    {
      cgaputc(buffer[i]);
    }
}




#define C(x)  ((x)-'@')  // Control-x
#define LEFT_ARROW   0xE4    
#define RIGHT_ARROW 0xE5 



static void shift_buffer_left(void)
{
  int cursor= input.e-left_key_pressed_count;
  for (int i = cursor - 1; i < input.e; i++)
  {
    input.buf[(i) % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF]; // Shift elements to left
  }
  input.buf[input.e] = ' ';
}

static void shift_buffer_right(void)
{
   int cursor= input.e-left_key_pressed_count;
  for (int i = input.e; i > cursor; i--)
  {
    input.buf[(i) % INPUT_BUF] = input.buf[(i-1) % INPUT_BUF]; // Shift elements to right
  }
}


#define INPUT_BUF 128
#define MAX_COMMANDS 64

// static int tab_press_count = 0;
// static char last_prefix[INPUT_BUF] = {0};



// void
// get_current_input(char *dest)
// {
//   int len = input.e - input.w;               
//   int i;


//   // edge cases
//   if (len < 0) len = 0;                 
//   if (len > INPUT_BUF - 1) len = INPUT_BUF - 1; 

//   for (i = 0; i < len; i++) {
//     dest[i] = input.buf[(input.w + i) % INPUT_BUF];
//   }
//   dest[i] = '\0';
// }




// // match two strings to check if they are exactly the same.
// int streq(const char *a, const char *b) {
//     while (*a && *b) {
//         if (*a != *b) return 0;
//         a++; b++;
//     }
//     return *a == *b;
// }

// int find_all_matches(const char *prefix, char matches[][INPUT_BUF]) {
//     int match_count = 0;
//     int prefix_len = strlen(prefix);

//     // 1. Match builtin commands
//     const char *builtin_cmds[] = {"cd"};
//     int num_builtin = sizeof(builtin_cmds)/sizeof(builtin_cmds[0]);
//     for (int i = 0; i < num_builtin; i++) {
//         if (strncmp(prefix, builtin_cmds[i], prefix_len) == 0) {
//             safestrcpy(matches[match_count++], builtin_cmds[i], INPUT_BUF);
//         }
//     }

//     // 2. Match user programs in root directory (kernel-side)
//     struct inode *dp;
//     struct dirent de;
//     if ((dp = namei("/")) == 0)
//         return match_count; // root not found
//     ilock(dp);

//     for (uint off = 0; off < dp->size; off += sizeof(de)) {
//         if (readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
//             break;
//         if (de.inum == 0) 
//             continue;
//         if (streq(de.name, ".") || streq(de.name, ".."))
//             continue;
//         if (strncmp(prefix, de.name, prefix_len) == 0) {
//             safestrcpy(matches[match_count++], de.name, INPUT_BUF);
//             if (match_count >= MAX_COMMANDS)
//                 break;
//         }
//     }

//     iunlockput(dp);
//     return match_count;
// }




// void
// auto_completion(void) {
//     char current_input[INPUT_BUF];
//     char prefix[INPUT_BUF];
//     char matches[MAX_COMMANDS][INPUT_BUF];
//     int match_count = 0;
//     int i, start = 0;


//     memset(current_input, 0, sizeof(current_input));
//     memset(prefix, 0, sizeof(prefix));
    
//     // get current input line from buffer
//     get_current_input(current_input);

//     // extract the prefix of the current word being typed
//     for (i = strlen(current_input) - 1; i >= 0; i--) {
//         if (current_input[i] == ' ') {
//             start = i + 1;
//             break;
//         }
//     }

//     safestrcpy(prefix, &current_input[start], sizeof(prefix));

//     // reset tab press count if prefix changed
//     if (strncmp(prefix, last_prefix, sizeof(prefix)) != 0) {
//         tab_press_count = 0;
//         safestrcpy(last_prefix, prefix, sizeof(last_prefix));
//     }


//     // find all matching commands/programs
//     match_count = find_all_matches(prefix, matches);
//     // if (match_count == 1) {
//     //     complete_command(matches[0]);
//     //     tab_press_count = 0;
//     // } 
//     // else if (match_count > 1) {
//     //     tab_press_count++;
//     //     if (tab_press_count >= 2) {
//     //         show_all_matches(matches, match_count);
//     //         tab_press_count = 0;
//     //     }
//     // } 
//     // else {
//     //     tab_press_count = 0;
//     // }
// }




void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
      
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
        input.e--;
        consputc(BACKSPACE);
      }

      break;
      
    case C('D'):

        
        int pos = input.e-left_key_pressed_count;


        // here we go to end of the world
        while ((input.buf[pos % INPUT_BUF] != ' ') && pos<input.e)
            pos++;


        // here we skip extra spaces
            while (input.buf[pos % INPUT_BUF] == ' '){
            pos++;
            }
        int distance = pos - (input.e-left_key_pressed_count);
                // cgaputc('0' + distance);
        for (int i = 0; i < distance; i++)
            move_cursor_right();


        left_key_pressed_count = input.e-pos;
        break;
    

    case C('A'):

         int posA = input.e-left_key_pressed_count;



        while (input.buf[(posA % INPUT_BUF)-1] == ' ' && posA>input.w){
            posA--;
            }



        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
        {
          posA--;
        }    
        while ((input.buf[posA % INPUT_BUF] != ' ') && posA>input.w)
            posA--;

        if ((input.buf[posA % INPUT_BUF] == ' ') && posA>input.w)
        {
          posA++;
        }   
        


        int distanceA = input.e-left_key_pressed_count-posA;
        for (int i = distanceA; i > 0; i--)
            move_cursor_left();


        left_key_pressed_count = input.e-posA;     

      break;


    case C('E'):
    // i added it here to help debugging.
      cgaputc('0' + input.e);
      cgaputc('0' + input.w);
      break;

    case LEFT_ARROW:


        int cursor = input.e-left_key_pressed_count;

        if (input.w < cursor)
        {
          if (left_key_pressed==0)
          {
            left_key_pressed=1;
          }
          
      
          left_key_pressed_count++;
          move_cursor_left();
        }
        

      break;
      
    case RIGHT_ARROW:

      int cursor1 = input.e-left_key_pressed_count;

      if(input.e>cursor1){
        left_key_pressed_count--;
        move_cursor_right();
      }
      else{
        left_key_pressed=0;
        }
      break;



    case '\t':
        tab_pressed = 1;         
        input.buf[input.e++] = '\t'; // put TAB in input buffer for shell to see

        
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;

        input.buf[input.e++ % INPUT_BUF] = c;


    
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          left_key_pressed=0;
          left_key_pressed_count=0;
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  ilock(ip);

  return n;
}

void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
}







void move_cursor_left(void){
  int pos;

  // get cursor position
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  if(pos>0)
    pos--;

  // reset cursor
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
}

void move_cursor_right(void) {
    int pos;

    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);

    pos++;

    outb(CRTPORT, 14);
    outb(CRTPORT+1, pos >> 8);
    outb(CRTPORT, 15);
    outb(CRTPORT+1, pos);
}
