# BUFFER OVERFLOW ROOM

* In this room I will be looking at 64 bit stack overflows

## PROCESS LAYOUT

* When a program runs on a machine, the computer runs the program as a process.
* Current computer architecture allows multiple processes to be run concurrently.
* While these processes may appear to run at the same time, the computer actually switches between the processes very quickly and makes it look like they are running at the same time. 
* Switching between processes is called a context switch. Since each process may need different information to run(e.g. The current instruction to execute), the operating system has to keep track of all the information in a process. 
* The memory in the process is organised sequentially 

|	User stack					|
|								|
|	Shared library regions		|
|								|
|	Run time heap 				|
|								| 
|	Read/write Data 			|
|								|
|	Read only code/data 		|

* The user stack contains the information requried to run the program. This informatino would include the current program counter, saved registers and more information. 
* This information would include the current program counter, saved registers and more information/ The section after the user sack is unused memory and it is used in case the stack grows
* Shared library regions are used to either statically/dynamically link libraries that are used by the program
* The heap increases and decreases dynamically depending on whether a program dynamically assigns memory. Notice there is a section that is unassigned above the heap which is used in the event that the size of the heap increases.
* The program code and data stores the program executable and initialised variables.


## x86-74 procedures

* A program would usually comprise of multiple functions and there needs to be a way of tracking which function has been called, and which data is passed from one function to antoher. 
* The stack is a region of contiguous memory addresses and it is used to make it esy to transfer control and data between functions.
* The top of the stack is at the lowest memory address and the stack grows towards lower memory addresses.

```
push var - This is the assembly instruction to push a value onto the stack. It does the following
* Uses var or value stored in memory location of var
* Decrements the stack pointer(known as rsp) by 8
* Writes above value to new location of rsp, which is now the top of the stack

pop var - This is the assembly to read a value and pop it off the stack
* Reads the value at the address given by the stack pointer
* Increments the stack pointer by 8
* Store the value that was read from rsp into var
```

* It’s important to note that the memory does not change when popping values of the stack - it is only the value of the stack pointer that changes
* Each compiled program may include multiple functions where each function would need to store local variables, arguments passed to the function and more.
* To make this easy to manage, each function has its own separate stack frame, where each new stack frame is allocated when a function is called, and deallocated when the function is complete

```
int add(int a, int b){

   int new = a + b;

   return new;

}



int calc(int a, int b){

   int final = add(a, b);

   return final;

}



calc(4, 5)
```

* The current point of execution for now is inside the calc function.
* In this case calc is known as the caller fucntion and add is the callee function.
* The add function is invoked using the call operand in assembly,in this case callq sym.add
* The call operand can either take a function name as an argument or it can take a memory address as an offset to the location of the start of a function.
* Once the add function is invoked , the program would need to know what point to continue in the program, to do this , the computer pushes the address of the next instruction onto the stack
* It the allocates a stack frame for the new function, change the current instruction pointer to the first instruction in the function, cchange the stack pointer to the top of the stack and change the frame pointer(rbp) to point to the start of the new frame
* Once the function is finished executing, it will call the return instruction(retq)
* This instruction will pop the value of the return address off the stack, deallocate the stack frame for the add function, change the instruction pointer to the value of the return address, change the stack pointer (rsp) to the top of the stack and change the frame pointer(rbp) to the stack frame of calc

* Let us look at how data is transferred
* The calc function takes 2 arguments.(a and b) Upto 6 arguments for functions can be stored int he following registers - rdi, rsi, rdx, rcx, r8, r9

* rax is a speical register that stores the return values of the function.
* If a function has anymore arguments, these arguments would be stored on the funtion's stack frame.
* A caller function may save values in their registers but what happens if a callee function also wants to save values in the registers? To ensure the values are not overwritten, the callee values first save the values of the registers on their stack frame, use the rigsters and the load values back into the reigsters
* The caller function can also save values on the caller function frame to prevent the values from being overwritten. Here are some rules around which registers are caller and callee saved

1. rax is caller saved
2. rdi, rsi, rdx, rcx r8 and r9 are called saved(and they are usually arguments for functions)
3. r10, r11 are caller saved
4. rbx, r12, r13, r14 are callee saved 
5. rbp is also callee saved(and can be optionally used as a frame pointer)
6. rsp is callee saved

## ENDIANESS

* In the above programs, you can see the binary information is represented in hexadecimal format.
* Different architectures represent the same hexadecimal number in different ways, this is referred to as endianness.
* Let’s take the value of 0x12345678 as an example. Here the least significant value is the right most value(78) while the most significant value is the left most value(12).
* Little Endian is where the value is arranged from the least significant byte to the most significant byte
* Big Endian is where the value is arranged from the most significant byte to the least significant byte.


## OVERWRITING VARIABLES


* Lets explore how these overflows actually work.

#OVERFLOW 1

* Your goal is to achenge the value of the integer variable
* From the C code you can see that the integer variable and character variable have been allocated next to each other- since memory is allocated in contiguous bytes, you can assume that the integer variable and character buffer are allocated next to each buffer.

```
Note: this may not always be the case. With how the compiler and stack are configured, when variables are allocated, they would need to be aligned to particular size boundaries
```

# OVERFLOW 2

* Similar to the example above, data is read into a buffer using the gets function, but the variable above the bufer is not a pointer to a fucntion.
* A pointer is used to point to a memory location, and in this case the memory location is that of the normal function. 
* Find a way of invoking the special function.


# OVERFLOW 3 & 4

* python -c “print (NOP * no_of_nops + shellcode + random_data * no_of_random_data + memory address)”

1. Start by crashing the program and finding an offset
2. Find shellcode to fit into the buffer size
3. View the stack and where we will jump to
4. Use that memory address after the offset size