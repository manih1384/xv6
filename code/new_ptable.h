
#ifndef NEW_PTABLE_H
#define NEW_PTABLE_H

#include "types.h"
#include "spinlock.h"

#define NEW_PT_NFRAMES 4

// One cache slot (one "frame" in our new_ptable)
struct new_pt_entry {
  char *frame_kva;   // kernel virtual address of the allocated  frame
  uint  vpn;         // virtual page number (va / PGSIZE)
  int   pid;        
  int   valid;       // valid bit

  // Replacement related stuff
  uint  load_time;      // FIFO
  uint  last_used_time; // LRU
  uint  use_count;      // LFU
  uint  refbit;         // Clock
};

struct new_ptable {
  struct spinlock lock;
  struct new_pt_entry e[NEW_PT_NFRAMES];


  uint time;     // keep track of time for replacement 
  int  hand;     // clock hand index [0..3]
};

extern struct new_ptable new_pt;

void new_ptable_init(void);
void new_ptable_dump(void);

#endif
