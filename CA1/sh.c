// Shell.

#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "fs.h"
#include "stat.h" // added thattt
// Parsed command representation
#define EXEC  1
#define REDIR 2
#define PIPE  3
#define LIST  4
#define BACK  5

#define MAXARGS 10


// In string.c, add this code at the end of the file.

char*
strncpy(char *s, const char *t, int n)
{
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}





char* knowncommands[] = {
    "ls", "cat", "echo", "cd", "wait", "sh", "rm", "mkdir",
    "ln", "kill", "init", "grep", "zombie", "grind",
    // Add any other commands you have created here
}; //newwwwwwwwwwwwww

int num_known_commands = sizeof(knowncommands) / sizeof(knowncommands[0]);// newwwwwwwwwww


// Helper function to update a buffer with the common prefix of itself and another string.
// `prefix_buf` is the buffer holding the current longest common prefix.
// `new_word` is the new word to compare against.
// `max_len` is the size of prefix_buf.
void update_common_prefix(char *prefix_buf, const char *new_word, int max_len) {
    int len = 0;
    // Find length of common prefix
    while (len < max_len - 1 && prefix_buf[len] && new_word[len] && prefix_buf[len] == new_word[len]) {
        len++;
    }
    // Null-terminate the prefix buffer at the end of the common part.
    prefix_buf[len] = '\0';
}




void autocompletion(char *buf)
{
  printf(2,"aaaa");
}

// Forward declaration for getcmd
int getcmd(char *buf, int nbuf);

struct cmd {
  int type;
};

struct execcmd {
  int type;
  char *argv[MAXARGS];
  char *eargv[MAXARGS];
};

struct redircmd {
  int type;
  struct cmd *cmd;
  char *file;
  char *efile;
  int mode;
  int fd;
};

struct pipecmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct listcmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct backcmd {
  int type;
  struct cmd *cmd;
};

int fork1(void);  // Fork but panics on failure.
void panic(char*);
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
  int p[2];
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();

  switch(cmd->type){
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
      exit();
    exec(ecmd->argv[0], ecmd->argv);
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
      exit();
    }
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
      runcmd(lcmd->left);
    wait();
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
    close(p[1]);
    wait();
    wait();
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
}





// Returns the index of the first char of the incomplete command before tab
// buf: shell input buffer (null-terminated)
// Returns -1 if no tab found
// int find_incomplete_command_start(char *buf) {
//     int i, tab_pos = -1;

//     // 1. Find first tab character
//     for (i = 0; buf[i] != 0; i++) {
//         if (buf[i] == '\t') {
//             tab_pos = i;
//             break;
//         }
//     }

//     if (tab_pos == -1)
//         return -1; // no tab found

//     // 2. Go backwards from tab to find last newline
//     int start = 0;
//     for (i = tab_pos - 1; i >= 0; i--) {
//         if (buf[i] == '\n') {
//             start = i + 1; // first char after '\n'
//             break;
//         }
//     }

//     return start; // index of first char of incomplete command
// }



char *builtins[] = {"cd",0}; // test shayan

void getprefix(char *buf, char *prefix) {
    int len = strlen(buf);
    int i;

    // Copy all characters up to the first '\t'
    for(i = 0; i < len; i++) {
      if (buf[i] != '\t')
      {
        prefix[i] = buf[i];
      }
      else
      {
        // memset(buf, 0, strlen(buf));
        break;
      }
      
      
        
    }
    
    prefix[i] = '\0';  // null-terminate the prefix
}


void completecmd(char *buf) {
    static char last_prefix[100] = "";
    static int tab_count = 0;
    

// reset last prefix shayan
void completecmd(char *buf) {
    static char last_prefix[100] = "";
    static int tab_count = 0;
    char prefix[100];
    getprefix(buf, prefix);

    if (strlen(prefix) == 0)
        return;

    if (strcmp(prefix, last_prefix) != 0) {
        tab_count = 1;
        strcpy(last_prefix, prefix);
    } else {
        tab_count++;
    }
    
    // Prepare match list
    char matches[100][DIRSIZ+1]; // 100 matches, each max DIRSIZ chars
    int match_count = 0;

    // Check built-ins
    for (int i = 0; builtins[i]; i++) {
        if (strncmp(prefix, builtins[i], strlen(prefix)) == 0) {
            strncpy(matches[match_count], builtins[i], DIRSIZ);
            matches[match_count][DIRSIZ] = '\0';
            match_count++;
        }
    }

    // Check files in current directory
    int fd;
    struct dirent de;
    struct stat st;
    if ((fd = open(".", 0)) >= 0) {
        while (read(fd, &de, sizeof(de)) == sizeof(de)) {
            if (de.inum == 0) continue;
            if (strncmp(prefix, de.name, strlen(prefix)) == 0) {
                strncpy(matches[match_count], de.name, DIRSIZ);
                matches[match_count][DIRSIZ] = '\0';
                match_count++;
            }
        }
        close(fd);
    }
    
    

    

    // Decide what to do based on match_count and tab_count
    if (match_count == 0) { 
        // nothing matches → do nothing
        
        // test reset last prefix shayan
    } 
    else if (match_count == 1) { 
      //shayan

      for (int i = 0; i < strlen(buf); i++)
      {
        buf[i]=' ';
      }
      
      // this is my own format shayan 
      printf(2,"\t%s\t", matches[0]);
      tab_count=0;
      match_count=0;

    } 

    else if (tab_count == 1 && match_count > 1) { 
        // first tab with multiple matches → do nothing
    } 

    else if (tab_count > 1 && match_count > 1) { 
        // second tab or more → show all matches
        printf(2, "\nMatches:\n");
        for (int i = 0; i < match_count; i++) {
            printf(2, "%s  ", matches[i]);
        }
        printf(2,"%s", "\n$ "); ;printf(2,"@%s@" ,buf);
      for (int i = 0; i < strlen(buf); i++)
      {
        buf[i]=' ';
      }
      tab_count=0;
      match_count=0;
    }
// if (tab_count==2)
//       tab_count=0;
    // printf(2, "Prefix: %s, tab_count: %d\n", prefix, tab_count);
}



// test old gets, shayan
  // int getcmd(char *buf, int nbuf)
  // {
  //     printf(2, "$ ");
  //     memset(buf, 0, nbuf);

  //     gets(buf, nbuf);

  //     completecmd(buf);
      
  //     if(buf[0] == 0) // EOF
  //         return -1;



  //     return 0;
  // }
// Add this function to your console.c or wherever you need it







int
getcmd(char *buf, int nbuf)
{
    printf(2, "$ ");
    memset(buf, 0, nbuf);
    int i = 0;
    char c;

    // Loop to read one character at a time.
    for(i = 0; i+1 < nbuf; ){
        if(read(0, &c, 1) < 1)
            return -1; // EOF

        // If the user presses Tab:
        if (c == '\t') {
            completecmd(buf);  // Call the logic to calculate the completion.
            // After autocompletion, the shell sends the completion to the kernel.
            // The kernel stuffs it in the input buffer and wakes us up.
            // Now, we loop again to read the newly completed line from the start.
            // The read() call above will now receive the characters we just sent.
            continue; // Continue the for loop to read the completed text
        }
        
        // If the user presses Enter, the command is done.
        if(c == '\n' || c == '\r'){
            buf[i++] = c;
            break;
        }

        // Add the character to our buffer.
        buf[i++] = c;

    }
    buf[i] = '\0';
    if(buf[0] == 0) // EOF
        return -1;
    return 0;
}




int
main(void)
{
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
}

void
panic(char *s)
{
  printf(2, "%s\n", s);
  exit();
}

int
fork1(void)
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
  return pid;
}

//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
  cmd->cmd = subcmd;
  cmd->file = file;
  cmd->efile = efile;
  cmd->mode = mode;
  cmd->fd = fd;
  return (struct cmd*)cmd;
}

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
  cmd->cmd = subcmd;
  return (struct cmd*)cmd;
}
//PAGEBREAK!
// Parsing

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
  case '|':
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
}

struct cmd *parseline(char**, char*);
struct cmd *parsepipe(char**, char*);
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
  cmd = parseredirs(cmd, ps, es);
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
  int i;
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    nulterminate(pcmd->left);
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
