#### `Introduction`
- Assembly language is processor specific.
#### `Architecture Overview`
- x86_64 bit architecture supports the following sizes
| Storage        | Size(bits)     | Size(bytes)    |
| :------------- | :------------- | :------------- |
| Bytes          |       8        |       1        |
| Word           |       16       |       2        |
| Double Word    |       32       |       4        |
| Qword          |       64       |       8        |
| Double Qword   |       128      |       16       |

#### `CPU Registers`
- Registers are temporary storages inbuilt into cpu where the cpu computations are generally perfomed.
- There are 16, 64bit general purpose registers.
- Maybe be accessed with all 64 bits  or only a portion being accessed.
- If using lower portions of the 64 bit register, you can access the using a different register name as in the GPR table:
i.e. if using 16bit, we use ax instead of rax
- First four registers: rax,rbx,rcx,rdx; allow bits 8-15 to be accessed with ah,bh,ch,dh register names with exception of ah
#### stack point register(rsp)
- Used to point to the current top of the stack.
#### base point register(rbp)
- Used as a base pointer during function calls.
#### instruction point register(rip)
- is a special register in addition to GPR, used to point to instruction to be executed.
- <u>nb</u> since it points to next instruction, this means the instruction pointed to in debugger has not yet been executed.
#### flag registers
- rFlags are used for status and cpu information.
- updated by cpu after each instruction and not directly accessible to programs.
- stores status infomation about instruction that was just executed.

#### `xmmm registers`
- used to support 64 and 32 bit floating point operations and single instruction multiple data instructions(simd).
- simd instructions allow a single instruction to be applied to multiple data items thus enhancing perfomance.
xmm0 - xmm15

#### `Cache memory`
- if a memory location is copied, a copy of it is placed in cache.
- following access to that memory in succession will be retrieved now from the cache.

#### `Main memory`
- is byte addressable i.e. each memory holds one byte of information.
- architecture is little-endian (least significant byte stored in lowest memory address, most significant byte stored in highest memory address)
#### memory layout
- Reserved section -> Not available to user programs. available to CPU
- data section ->  is where initialized data is stored. includes Variables provided an initial value at assemble time.
- bss Section -> is where declared variables which have not been provided an initial value are stored.(uninitialized section).
- heap section -> is where all dynamically allocated data is stored(if requested)
- stack section -> starts in high memory and goes downwards
