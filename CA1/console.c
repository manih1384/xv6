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
static void consputc(int);

static int panicked = 0;
#define INPUT_BUF 128

int select_start=0;
int select_end=0;
int select_mode = 0; // Add this and two previous ones for select part
int select_length=0;
// char selected_text[INPUT_BUF];
char copied_text[INPUT_BUF];
int copied_length = 0;
// select mode is as followed:
// 0: No ctrl S pressed
// 1: A single ctrl was pressed only right and left arrows will not reset this, any other key will bring us back to mode 0
// 2: The second ctrl S was pressed now we have many cases:
// If right or left arrows get pressed ?
// If backspace is pressed we delete the area
// If ctrl C is pressed we save the selected area and go back to mode,
// If any other key is used we show it and replace the area with that key and return to mode 0
// in mode 2 we should highlight the section which has been selected

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

#define UNDO_BS 0x101


struct {
    int pos_data[INPUT_BUF];
    int size;
    int cap;
} cga_pos_sequence = { {0}, 0, INPUT_BUF };

// Append a new position to the end.
void append_cga_pos(int pos) {
    if (cga_pos_sequence.size >= cga_pos_sequence.cap) {
        return; // Safety: ignore if full
    }
    cga_pos_sequence.pos_data[cga_pos_sequence.size++] = pos;
}

// Get the last recorded position.
int last_cga_pos(void) {
    if (cga_pos_sequence.size == 0) return -1;
    return cga_pos_sequence.pos_data[cga_pos_sequence.size - 1];
}

// Delete the last recorded position.
void delete_last_cga_pos(void) {
    if (cga_pos_sequence.size > 0) {
        cga_pos_sequence.size--;
    }
}

// Clear the entire sequence history.
void clear_cga_pos_sequence(void) {
    cga_pos_sequence.size = 0;
}

void delete_from_cga_pos_sequence(int pos) {
    int idx = -1;
    // Find the index of the position we want to remove.
    for (int i = 0; i < cga_pos_sequence.size; i++) {
        if (cga_pos_sequence.pos_data[i] == pos) {
            idx = i;
            break;
        }
    }
    if (idx == -1) return; // Position not found in history, nothing to do.

    // Shift all elements after the found index to the left.
    for (int i = idx; i < cga_pos_sequence.size - 1; i++) {
        cga_pos_sequence.pos_data[i] = cga_pos_sequence.pos_data[i + 1];
    }
    cga_pos_sequence.size--;

    // CRITICAL FIX: All characters that were drawn *after* the deleted
    // character have now shifted one position to the left on the screen.
    // We must update their recorded positions in our history to reflect this.
    for (int i = 0; i < cga_pos_sequence.size; i++) {
        if (cga_pos_sequence.pos_data[i] > pos) {
            cga_pos_sequence.pos_data[i]--;
        }
    }
}



static void
cgaputc(int c)
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n'){
    pos += 80 - pos%80;
    clear_cga_pos_sequence();
  }
 

    else if(c == BACKSPACE){
    // This is the position of the character being deleted.
    int deleted_pos = pos - 1;
    // Visually shift all characters on the screen starting from the deleted position.
    for (int i = deleted_pos; i < pos + left_key_pressed_count; i++)
      crt[i] = crt[i + 1];

    // CRITICAL FIX: The characters to the right of the deleted one have shifted left.
    // We must update their recorded positions in our history.
    // The entry for 'deleted_pos' itself was already removed by consoleintr,
    // so this loop corrects the remaining entries.
    // for (int i = 0; i < cga_pos_sequence.size; i++) {
    //     if (cga_pos_sequence.pos_data[i] > deleted_pos) {
    //         cga_pos_sequence.pos_data[i]--;
    //     }
    // }
    delete_from_cga_pos_sequence(deleted_pos);

    if(pos > 0) --pos;
  }
else if (c == UNDO_BS) {
    int undo_pos = last_cga_pos();
    if (undo_pos == -1) return;
    
    delete_last_cga_pos();

    for (int i = undo_pos; i < pos + left_key_pressed_count; i++) {
        crt[i] = crt[i + 1];
    }

    // MODIFIED: After an undo, we must also update the history for any
    // characters that were on the right of the undone character.
    for (int i = 0; i < cga_pos_sequence.size; i++) {
        if (cga_pos_sequence.pos_data[i] > undo_pos) {
            cga_pos_sequence.pos_data[i]--;
        }
    }
    
    if(pos > pos + left_key_pressed_count-1) --pos;
    else
      left_key_pressed_count--;
  } 


  else {
    // A normal character is typed.
    // append its position BEFORE shifting other character positions.
    append_cga_pos(pos);

    // MODIFIED: When inserting a char, all chars to the right are shifted.
    // We must update their recorded positions in the history.
    for (int i = 0; i < cga_pos_sequence.size - 1; i++) { // size-1 because we just added the new one
        if (cga_pos_sequence.pos_data[i] >= pos) {
            cga_pos_sequence.pos_data[i]++;
        }
    }
    
    // Visually shift chars on screen
    for (int i = pos + left_key_pressed_count; i > pos ; i--)
      crt[i] = crt[i - 1];
    crt[pos++] = (c&0xff) | 0x0700;
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

  if(c == BACKSPACE || c==UNDO_BS){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}

struct {
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
  uint tabr; // tab read index
} input;






struct {
    int data[INPUT_BUF];
    int size;
    int cap;
} input_sequence = { {0}, 0, INPUT_BUF };


// Append a new element at end
void append_sequence(int value) {
    if (input_sequence.size >= input_sequence.cap) {
        // memory is fixed, cannot expand
        return;  // safely ignore when full
    }
    input_sequence.data[input_sequence.size++] = value;
}


// Delete the element that has value `value`
void delete_from_sequence(int value) {
    int idx = -1;
    for (int i = 0; i < input_sequence.size; i++) {
        if (input_sequence.data[i] == value) {
            idx = i;
            break;
        }
    }
    if (idx == -1) return;  // not found

    for (int i = idx; i < input_sequence.size - 1; i++)
        input_sequence.data[i] = input_sequence.data[i + 1];

    input_sequence.size--;
}


// Return last element, or -1 if empty
int last_sequence(void) {
    if (input_sequence.size == 0) return -1;
    return input_sequence.data[input_sequence.size - 1];
}


// Clear all elements (does not free memory in static version)
void clear_sequence(void) {
    input_sequence.size = 0;
}

#define C(x)  ((x)-'@')  // Control-x
#define LEFT_ARROW   0xE4    
#define RIGHT_ARROW 0xE5 
#define  CTL1 0x1D
#define  SHIFT1 0x2A
#define  SHIFT2 0x36
#define  ALT1 0x38
#define  CTL2 0x9D
#define  ALT2 0xB8



static void shift_buffer_left(int shift_from_seq)
{
  int shift_idx= shift_from_seq ? last_sequence(): input.e-left_key_pressed_count;
  if (shift_from_seq)
    (delete_from_sequence(input_sequence.size-1));
  for (int i = shift_idx - 1; i < input.e; i++)
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



void print_array(char *buffer){
      for (int i = 0; i < input.e; i++)
    {
      cgaputc(buffer[i]);
    }
}

void highlight_from_buffer_positions(void) {
  if (select_mode != 2) return;
  
  // Get current cursor screen position
  int cursor_screen_pos;
  outb(CRTPORT, 14);
  cursor_screen_pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  cursor_screen_pos |= inb(CRTPORT+1);
  
  // Calculate where buffer position 0 is on screen
  // cursor_screen_pos = line_start + prompt_length + (input.e - left_key_pressed_count)
  // So: line_start = cursor_screen_pos - prompt_length - (input.e - left_key_pressed_count)
  int prompt_length = 2; // Since we have  "$ " or "> " at the start of the line we need to skip those
  int line_start = cursor_screen_pos - prompt_length - (input.e - left_key_pressed_count);
  
  // Now we can directly map buffer indices to screen positions!
  for (int buf_pos = select_start; buf_pos < select_end && buf_pos < input.e; buf_pos++) {
      int screen_pos = line_start + prompt_length + buf_pos;
      
      if (screen_pos >= 0 && screen_pos < 80*25) {
          crt[screen_pos] = (crt[screen_pos] & 0x00FF) | 0x7000;
      }
  }
}

void clear_highlight_from_buffer(void) {
  if (select_mode != 2) return;
  
  // Same calculation
  int cursor_screen_pos;
  outb(CRTPORT, 14);
  cursor_screen_pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  cursor_screen_pos |= inb(CRTPORT+1);
  
  int prompt_length = 2;
  int line_start = cursor_screen_pos - prompt_length - (input.e - left_key_pressed_count);
  
  for (int buf_pos = select_start; buf_pos < select_end && buf_pos < input.e; buf_pos++) {
      int screen_pos = line_start + prompt_length + buf_pos;
      
      if (screen_pos >= 0 && screen_pos < 80*25) {
          // Restore normal color
          crt[screen_pos] = (crt[screen_pos] & 0x00FF) | 0x0700;
      }
  }
}

void delete_selected_area(void) {
  if (select_start == select_end) return;
  
  int select_length = select_end - select_start;
  
  int current_pos = input.e - left_key_pressed_count;
  int move_distance = select_end - current_pos;
  
  if (move_distance > 0) {
      for (int i = 0; i < move_distance; i++) {
          if(input.e > current_pos) {
              left_key_pressed_count--;
              move_cursor_right();
              current_pos++;
          }
      }
  } else if (move_distance < 0) {
      for (int i = 0; i < -move_distance; i++) {
          if(input.w < current_pos) {
              left_key_pressed_count++;
              move_cursor_left();
              current_pos--;
          }
      }
  }
  
  for (int i = 0; i < select_length; i++) {
      if(input.e != input.w){
          shift_buffer_left(0);
          delete_from_sequence(input.e - left_key_pressed_count);
          for(int j = 0; j < input_sequence.size; j++) {
              if(input_sequence.data[j] > (input.e - left_key_pressed_count) % INPUT_BUF)
                  input_sequence.data[j]--;
          }
          input.e--;
          consputc(BACKSPACE);
      }
  }
}

void copy_selected_text(void) {
  copied_length = 0;
  for (int i = select_start; i < select_end && copied_length < INPUT_BUF - 1; i++) {
    copied_text[copied_length] = input.buf[i % INPUT_BUF];
    copied_length++;
  }
  copied_text[copied_length] = '\0';
}
void paste_text(void) {
  if (copied_length == 0) return;
  if (select_mode == 2) {
      delete_selected_area();
  }
  
  if (input.e + copied_length >= INPUT_BUF) {
      return;
  }
  
  for (int i = 0; i < copied_length; i++) {
    char c = copied_text[i];
    
    shift_buffer_right();
    
    input.buf[(input.e - left_key_pressed_count) % INPUT_BUF] = c;
    input.e++;
    consputc(c);
  }
}




int tab_flag=0;
int tab_flag2=0;
void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    if (c!=0) {
      if (c != C('S') && select_mode != 0) {
        if (select_mode == 1) {
          if (
            c != RIGHT_ARROW && c != LEFT_ARROW &&
            c != C('A') && c != C('D') 
          ) {
            select_mode = 0;
          }
        }
        else if (select_mode == 2) {
          if (c == RIGHT_ARROW) {
            clear_highlight_from_buffer();
            select_mode = 0;
          }
          else if (c == LEFT_ARROW) {
            clear_highlight_from_buffer();
            select_mode = 0;
          }
          else if (c == C('A')) {
            clear_highlight_from_buffer();
            select_mode = 0;
          }
          else if (c == C('D')) {
            clear_highlight_from_buffer();
            select_mode = 0;
          }
          else if (c == C('Z')) {
            clear_highlight_from_buffer();
            select_mode = 0;
          }
          else if (c == C('H') || c == '\x7f') {// nothing
          }
          else if (c == C('C')) {//nothing
          }
          else if(
            c != RIGHT_ARROW && c != LEFT_ARROW &&
            c != C('A') && c != C('D') 
          ) {
            // Any other key (except arrows and modifiers) means delete selection
            delete_selected_area();
            select_mode = 0;
          }
        }
      }
    }

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
        clear_sequence();
        clear_cga_pos_sequence();
      }
      break;
      
    case C('H'): case '\x7f':  // Backspace
      if (select_mode == 2 && select_end != select_start) {
        clear_highlight_from_buffer();
        delete_selected_area();
        select_mode = 0;
      } 
      else if(input.e != input.w && input.e - input.w > left_key_pressed_count){
        shift_buffer_left(0);
        delete_from_sequence(input.e-left_key_pressed_count);
        for(int i=0;i<input_sequence.size;i++) {
          if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
            input_sequence.data[i]--;
        }
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
        // cgaputc("0"+input.r);
        // cgaputc("0"+input.w);
        cgaputc("0"+select_start);
        cgaputc("0"+select_end);
        cgaputc("0"+select_mode);
        // cgaputc("0"+input.e);
        // cgaputc(cga_pos_sequence.pos_data[cga_pos_sequence.size-1]);

      break;
    case LEFT_ARROW:


        int cursor = input.e-left_key_pressed_count;

        if (input.w < cursor)
        {
          if (left_key_pressed==0)
          {
            left_key_pressed=1;
          }
          
          move_cursor_left();
          left_key_pressed_count++;

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

    case C('Z'):  
      if(input.e != input.w){
        shift_buffer_left(1);
        input.e--;
        consputc(UNDO_BS);
      }
      break;
      
    case C('S'): // Select
      if (select_mode == 0) {
        select_start = input.e - left_key_pressed_count;
        select_mode = 1;
      }
      else if (select_mode == 1) {
        select_end = input.e - left_key_pressed_count;
        if (select_start > select_end) {
          int temp = select_start;
          select_start = select_end;
          select_end = temp; 
        }
        select_mode = 2;
        highlight_from_buffer_positions();
      }
      else if (select_mode == 2) {
        clear_highlight_from_buffer();
        select_mode = 0;
      }
      break;

    case C('C'): // Copy
      if (select_mode == 2) {
        copy_selected_text();
      }
      break;

    case C('V'): // Paste
      if (select_mode == 2){
        clear_highlight_from_buffer();
      }
      if (copied_length > 0) {
        paste_text();
        select_mode = 0;
      }
      break;

       break;  




    case '\t': //tab
    if (input.tabr<input.e)
    {
      input.tabr=input.r;
    }
      
      tab_flag=1;
      input.buf[(input.e++) % INPUT_BUF] = '\t';
      wakeup(&input.r);
      break;




         
    default:
      
      if(c != 0 && input.e-input.r < INPUT_BUF){
        if (select_mode == 2) {
          // Replace selection with typed character
          clear_highlight_from_buffer(); // Remove highlight first
          delete_selected_area();
          select_mode = 0;
          // Continue to process the key normally below
        }
        c = (c == '\r') ? '\n' : c;
    
        if (c=='\n')
        {
          input.buf[(input.e++) % INPUT_BUF] = c;
          clear_sequence();
        }
        else{
          shift_buffer_right();
          append_sequence((input.e-left_key_pressed_count) % INPUT_BUF);
          for(int i=0;i<input_sequence.size;i++)
          {
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
              input_sequence.data[i]++;
          }
          input.buf[(input.e++-left_key_pressed_count) % INPUT_BUF] = c;
        }
    
        consputc(c);
        if(c == '\n' )
          clear_sequence();
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
  // cgaputc('0'+input.e);
  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while ((!tab_flag && input.r == input.w) || (tab_flag && input.tabr == input.e)) {
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }

    if (tab_flag==0)
    {
          c = input.buf[input.r++ % INPUT_BUF];
          if(c == C('D')){  // EOF
          if(n < target){
            // Save ^D for next time, to make sure
            // caller gets a 0-byte result.
            input.r--;
          }
          break;
        }
        *dst++ =c;
    }
    else
    {
      c = input.buf[input.tabr++ % INPUT_BUF];
      *dst++ =c;
    
    }
    

    if (input.tabr==input.e)
    {
      tab_flag=0;
    }
    
 
    
    --n;
    if(c == '\n' || c=='\t')
      break;
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}


int autocomplete_w=0; //flag for writing to console buffer
int doubletab_detected=0;

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);


  if (buf[0] == '\t' && autocomplete_w) {
    autocomplete_w=0;
    input.tabr=input.r;
  }
  else if (buf[0]=='@'&&doubletab_detected){
    doubletab_detected=0;
    input.tabr=input.r;
  }
  else if (buf[0]!='@'&&buf[0]!='\t'&&doubletab_detected){
    char c = buf[0];
    consputc(c);
    input.buf[input.e++ % INPUT_BUF] = c;
  }
  else if (buf[0]=='@'&&!doubletab_detected){
    while (input.e > input.r) {
        delete_from_sequence(input.e-left_key_pressed_count);
        for(int i=0;i<input_sequence.size;i++)
          {
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
              input_sequence.data[i]--;
          }
      shift_buffer_left(0);
      consputc(BACKSPACE);
      input.e--;
    }
    cgaputc(' '); // an extra space for logic to match screen
    doubletab_detected=1;
    cgaputc('$'); cgaputc(' ');
  }
  else if (buf[0]!='\t' && autocomplete_w)
  {
    
    // this is like default case in consoleintr shayan
    char c = buf[0];
          //     append_sequence((input.e-left_key_pressed_count) % INPUT_BUF);
          for(int i=0;i<input_sequence.size;i++)
          {
            if(input_sequence.data[i]>(input.e-left_key_pressed_count) % INPUT_BUF)
              input_sequence.data[i]++;
          }
    consputc(c);
    input.buf[input.e++ % INPUT_BUF] = c;


  }

  else if (buf[0]=='\t' && !autocomplete_w)
  {
    // first tab seen turn on auto complete
    //erase what we wrote at first
    while (input.e > input.r) {
      shift_buffer_left(0);
      consputc(BACKSPACE);
      input.e--;
    }
    cgaputc(' '); // an extra space for logic to match screen
    autocomplete_w=1;
  }
  else  if(buf[0]!='\t' && !autocomplete_w)
  {
    // write normaly
    for (i = 0; i < n; i++)
      consputc(buf[i] & 0xff);


  }
  
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




  if(crt[pos - 2] != ('$' | 0x0700))
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
