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
  int match_count = 0;
  char match_buf[100]; // Static buffer to hold the best match so far
  char *current_word = buf;
  int i;

  memset(match_buf, 0, sizeof(match_buf));
  
  // Find the start of the word we need to complete
  for(i = strlen(buf) - 1; i >= 0; i--){
    if(buf[i] == ' '){
      current_word = buf + i + 1;
      break;
    }
  }

  // Decide whether to complete a command name or a file/path name.
  if(current_word == buf) {
    // --- COMMAND COMPLETION LOGIC ---
    for (i = 0; i < num_known_commands; i++) {
      if (strncmp(knowncommands[i], current_word, strlen(current_word)) == 0) {
        if (match_count == 0) {
          // First match found. Copy it to our static buffer.
          strncpy(match_buf, knowncommands[i], sizeof(match_buf) - 1);
        } else {
          // More than one match. Update match_buf to be the common prefix.
          update_common_prefix(match_buf, knowncommands[i], sizeof(match_buf));
        }
        match_count++;
      }
    }
  } else {
    // --- FILE/DIRECTORY COMPLETION LOGIC (like 'ls') ---
    char path[512];
    int fd;
    struct dirent de;
    struct stat st;

    // Open the current directory for reading.
    if((fd = open(".", 0)) < 0){
      printf(2, "autocomplete: cannot open .\n");
      return;
    }
    
    // Read through all directory entries.
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0) // Skip empty entries.
        continue;
      
      // We must not try to complete "." or ".."
      if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
        continue;
        
      // Check if the file name starts with our current word.
      if (strncmp(de.name, current_word, strlen(current_word)) == 0) {
        if (match_count == 0) {
          // First match. Copy to our buffer.
          strncpy(match_buf, de.name, sizeof(match_buf) - 1);
        } else {
          // Multiple matches. Find common prefix.
          update_common_prefix(match_buf, de.name, sizeof(match_buf));
        }
        match_count++;
      }
    }
    close(fd);
    
    // This is a nice-to-have feature: if there's a single, unique match,
    // and it's a directory, add a '/' to the end.
    if(match_count == 1) {
        // We need to build the full path to stat() the file
        if(strlen(buf) + strlen(match_buf) < sizeof(path)) {
            strcpy(path, "."); // or the directory part of the path if you implement that
            strcpy(path + strlen(path), "/");
            strcpy(path + strlen(path), match_buf);
            if(stat(path, &st) >= 0 && st.type == T_DIR) {
                int len = strlen(match_buf);
                if(len + 1 < sizeof(match_buf)) {
                    match_buf[len] = '/';
                    match_buf[len+1] = '\0';
                }
            }
        }
    }
  }

  // --- SEND THE RESULT BACK TO THE KERNEL ---
  if (match_count > 0 && strlen(match_buf) > strlen(current_word)) {
    char* completion_text = match_buf + strlen(current_word);
    int completion_len = strlen(completion_text);
    
    // Use a static buffer for the result message to the kernel
    char result[128];
    if (completion_len + 3 < sizeof(result)) {
        memset(result, 0, sizeof(result));
        strcpy(result, "\t\t");
        strcpy(result + 2, completion_text);

        // This write() call sends the special message to consolewrite.
        write(1, result, strlen(result));
    }
  }
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




// void
// autocompletion(char *buf, int pos, int tab_count)
// {
//   int i;
//   char prefix[DIRSIZ+1];
//   int start = 0;

//   // Find where the last word starts (after last space)
//   for (i = pos - 1; i >= 0; i--) {
//     if (buf[i] == ' ' || buf[i] == '\n' || buf[i] == '\r') {
//       start = i + 1;
//       break;
//     }
//   }

//   // Copy that part into prefix[]
//   int j = 0;
//   while (start + j < pos && j < DIRSIZ) {
//     prefix[j] = buf[start + j];
//     j++;
//   }
//   prefix[j] = '\0';

//   // Debug print to test your extraction first:
  
// }



//   char*
//   gets_modified(char *buf, int max)
//   {
    
//     int i, cc;
//     char c;
//     int tab_count = 0;

//     for (i = 0; i + 1 < max; ) {
//       cc = read(0, &c, 1);
//       printf(2, "$ ");
//       if (cc < 1)
//         break;

//       if (c == '\t') {
//         tab_count++;
//         autocompletion(buf,i,tab_count);
//         continue;   // don’t put '\t' in buffer
//       } else {
//         tab_count = 0;
//       }

//       buf[i++] = c;

//       if (c == '\n' || c == '\r')
//         break;
//     }

//     buf[i] = '\0';
//     return buf;
//   }


// Returns the index of the first char of the incomplete command before tab
// buf: shell input buffer (null-terminated)
// Returns -1 if no tab found
int find_incomplete_command_start(char *buf) {
    int i, tab_pos = -1;

    // 1. Find first tab character
    for (i = 0; buf[i] != 0; i++) {
        if (buf[i] == '\t') {
            tab_pos = i;
            break;
        }
    }

    if (tab_pos == -1)
        return -1; // no tab found

    // 2. Go backwards from tab to find last newline
    int start = 0;
    for (i = tab_pos - 1; i >= 0; i--) {
        if (buf[i] == '\n') {
            start = i + 1; // first char after '\n'
            break;
        }
    }

    return start; // index of first char of incomplete command
}






  // int getcmd(char *buf, int nbuf)
  // {
  //     printf(2, "$ ");
  //     memset(buf, 0, nbuf);

  //     gets(buf, nbuf);

  //     int idx= find_incomplete_command_start(buf);
  //     for (int i = idx; i < 100; i++)
  //     {
  //       buf[i];
  //     }
      
  //     if(buf[0] == 0) // EOF
  //         return -1;



  //     return 0;
  // }



// In sh.c

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
            buf[i] = '\0';        // Null-terminate the string so far.
            autocompletion(buf);  // Call the logic to calculate the completion.
            
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
