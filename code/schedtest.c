#include "types.h"
#include "stat.h"
#include "user.h"

void stress_cpu(long iterations) {
    volatile long x = 0;
    volatile long i;
    for(i = 0; i < iterations; i++) {
        x = x + 1;
        x = x * 2;
        x = x / 2;
    }
}

int main(int argc, char *argv[]) 
{
    int num_children = 8; 
    int i;
    int pid;

    printf(1, "SCHEDTEST: Starting with 3 System Calls...\n");

    start_measuring();

    for(i = 0; i < num_children; i++) {
        pid = fork();
        
        if(pid == 0){
            // --- CHILD ---
            printf(1, "SCHEDTEST: start of process\n");
            print_info(); 
            stress_cpu(50000000); 
            printf(1, "SCHEDTEST: end of process\n");
            print_info(); 
            exit();
        }
    }

    for(i = 0; i < num_children; i++) {
        wait();
    }

    stop_measuring();

    exit();
}