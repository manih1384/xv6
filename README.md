# Enhanced xv6 Operating System

## Overview & Concept
This repository contains a progressively enhanced version of the **xv6 operating system** (a simple, Unix-like teaching OS developed by MIT). Over the course of five development phases, we integrated modern operating system capabilities into the core, transforming the baseline xv6 into a more robust and feature-rich environment. Since each phase was built upon the previous one, this repository represents the final, cumulative codebase of our fully integrated operating system.

## Team Members
This project was successfully developed and maintained by our core OS team:
- Shayan Maleki
- Hamid Mahmoudi
- Mani Hosseini
- [Your Name]

## Development Phases
The evolution of this operating system was divided into five main phases. Below is a high-level summary of the challenges we tackled and the features we implemented in each step:

### Phase 1: Console & System Calls
- **Challenge:** Extending the basic OS interface to support advanced user interactions and foundational user-level applications.
- **Feature:** Implemented custom system calls and enhanced the kernel console with new shortcut capabilities and user programs.

### Phase 2: Custom Shell Implementation
- **Challenge:** Providing a functional command-line interpreter that handles complex command execution akin to standard Linux shells.
- **Feature:** Built a robust shell supporting command parsing, process execution, I/O redirection, and inter-process communication via pipes.

### Phase 3: Process Management & Transitions
- **Challenge:** Understanding and controlling how the OS kernel manages process lifecycles, states, and context switching.
- **Feature:** Modified process state transitions and improved the internal process management systems to handle advanced execution flows.

### Phase 4: Memory Management
- **Challenge:** Optimizing RAM usage and protecting process memory spaces using hardware paging mechanisms.
- **Feature:** Integrated advanced memory management techniques to efficiently handle page allocations and memory isolation.

### Phase 5: File System & Synchronization
- **Challenge:** Ensuring data persistence and safe concurrent access to shared kernel resources.
- **Feature:** Expanded file system capabilities and implemented concurrency controls (such as locks) for safe, multi-process executions.

## How to Run / Quick Start
Because this is a cumulative codebase, you only need to run the final version to experience all the added features. 

**Prerequisites:** 
You need to have `qemu` and the appropriate toolchain installed on your machine.

**Execution:**
Open your terminal in the root directory of this repository and simply run:
`make qemu`

This command will compile the modified kernel, build the user-level programs, and boot the enhanced xv6 operating system in the emulator.

## Documentation & Reports
*Note: This README serves as a high-level overview of the project's capabilities.* 

If you are interested in the deep technical details, implementation logic, internal data structures, and the debugging process for each specific phase, please refer to our comprehensive reports. Detailed documentation for each phase is available in the `Reports` directory of this repository.
