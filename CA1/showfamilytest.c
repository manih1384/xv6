#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    int parent_pid = getpid();
    int child1_pid = -1;

    if(fork() == 0) {
        child1_pid = getpid();

        if (fork() == 0) {
            sleep(60);
            exit();
        }
        
        sleep(60);
        exit();
    }
    
    if(fork() == 0) {
        
        sleep(10);
        
        
        show_process_family(parent_pid);
        
        sleep(60);
        exit();
    }

    wait();
    wait();
    wait();
    exit();
}
    