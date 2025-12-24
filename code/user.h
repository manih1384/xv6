struct stat;
struct rtcdate;

// system calls
int fork(void);
int exit(void) __attribute__((noreturn));
int wait(void);
int pipe(int*);
int write(int, const void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(const char*, int);
int mknod(const char*, short, short);
int unlink(const char*);
int fstat(int fd, struct stat*);
int link(const char*, const char*);
int mkdir(const char*);
int chdir(const char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
int simple_arithmetic_syscall(int a, int b);
int make_duplicate(const char *src_file);
int show_process_family(int); 
int grep_syscall(const char*, const char*, char*, int);
int set_priority_syscall(int pid, int priority);
int start_measuring(void);
int stop_measuring(void);
int print_info(void);
int testlock_acquire(void);
int testlock_release(void);
int rwlock_acquire_read(void);
int rwlock_release_read(void);
int rwlock_acquire_write(void);
int rwlock_release_write(void);


// ulib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void printf(int, const char*, ...);
char* gets(char*, int max);
uint strlen(const char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
