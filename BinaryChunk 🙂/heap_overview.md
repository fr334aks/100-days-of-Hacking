## Heap Overview


- A heap this is a region in memory that is used to allocate variables
whose size is not deterministic during compile time.
- There are 3 basic functions that make up the foundation of the heap 
manipulation and they are:

> Malloc :

        - Prototype void malloc(size_t size)
        - The first time malloc is called the following take place:
                1. Allocates an amount of memory specified.
                2. It creates a heap segment
                3. It returns a pointer to the region of memory that was
                allocated.
        - If it is not the first call to malloc:
                1. Malloc will return a pointer to memory for the region 
                that was allocated.
            
>Calloc:

        - Prototype void calloc(size_t nmemb, size_t size)
        - Functionality:
                1. The function allocates memory for an array of nmemb elements
                of size_t bytes.
                - The region of memory is also initalized to zero and the 
                pointer returned is the region of memory allocated.
                
> Free:

        - Prototype void free(void *ptr)*;
        - Functionality:
                1. This function is used to free the region of memory that was
                previously returned by malloc


- The `heap segment` is a region of memory that contains the heap 
similiar to the data segment, stack etc..... has to be created at runtime by 
an algorithm.
- Algorithms that allocate memory dynamically and administrate it are called 
denominated `allocators`.

- There are differnt types of allocators and they include the following:

        1. Dlmalloc : This is the general purpose allocator
        2. Ptmalloc : (ptmalloc2) glibc
        3. Jemalloc : FreeBSD and Firefox
        4. Tcmalloc : Google Chrome
        5. Magazine Malloc : IOS/OSX
        
- These allocators they communicate with the kernel in order to receive memory
from the OS via syscalls

        1. brk() syscall:
                - The syscall intializes the following
                        1. end_data to the value specified in the addr (arg)
                        2. start_brk to the next value available segment after the data segment.
                        3. brk=start_brk
                  
        2. sbrk syscall:
                - This is used to increment the program break by incrementing bytes.
                - Therefore giving dimensions to the heap segment.
                - calling sbrk() with an arg of 0 can be used to find 
                the current position of the program break.

- Some definations:

        * End_data: A pointer that set the ends of the data segment
        * start_brk: A pointer that denotes the start of the heap segment
        * brk/program break: A pointer that denotes the end of the heap segment.


- During allocation by malloc, the memory that is returned this is higher that what was allocated.
- Therefore the formulae that is used to calculate the memory returned is.

        - Assume we requests a size of (n) bytes from malloc therefore:
                if (n < 0x20):
                        malloc == 0x20
                elif(n + 0x8 + 0xf) &~ 0xf will be the new size =)

*When a call is made to malloc, the size should be aligned to the SZ_SIZE value that is 0x4 in 32-bit systems and 0x8 in 64-bit systems
Malloc will allocate that size plus the size of the chunk metadata that is 0x8 in 32-bit systems and 0x10 in 64-bit systems =)*
