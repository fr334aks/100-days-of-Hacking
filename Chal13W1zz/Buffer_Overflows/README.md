Buffer Overflow - A type of a memory corruption Vulnerability
-can be used to control the exectution flow of an application 

## Introduction To The X_86 Architecture
# Program Memory
 an executed binary application allocates memory in a very specific way, within the memory boundaries used by the modern computers
 
 Process Memory Allocation in windows Btwn The lowest and the highest memory addresses
 [image process mem alloc]
 
# The Stack
 a running thread executes code within the program image or from various dll's loaded by the application
 the thread requires a short term data area for functions, local variables and  pc info , the data area is called the stack
 Each thread in a running app has it's own stack to facilitate execution of multiple threads
 items pushed on the stack are popped 1st (LIFO)
 x_86 arch implements dedicated push and pop asm instructions in order to add or remove data from the stack
 
# Function Return Mechanics
 When code within a thread calls a func, it must know which addr to return to once the func completes, the return addr along with the func params and local vars is stored in the stack. this coll of data is associated with one func call and is stored in a stack frame (A section of the stack memory)
 [image stack frame]
 when a func ends, the RA is taken from the stack and used to restore the exec flow back to the main prog or the calling func.
 
# Cpu Registers
Small extreemely high speed cpu storage locations where data can be effeciently read or manipulated(They aid in performing effecient code exec)
They are  9, 32bit
 Their names were initially established for 16bits registers and then were extended with the advent the 32bit platform
 [image registers]
 E in the registers accronyms means extended
  
  Each register may contain a 32, 16 or 8 bit value in the respective sub-registers
  [image sub-register]
  
# General Purpose Registers
 Used to store temporary data
 EAX - Accumulator = used for Arithmetical n Logical Instructions
 EBX - Base Pointer For Memory Addresses
 ECX - Count Register used for Loop, Shift and Rotation Counter
 EDX - Used For I/O port addressing , Multipplication and division
 ESI - Source Index Used as A pointer addressing the data source in string copy operations 
 EDI - Destination index used as a pointer addressing the destination memory buffer in string copy operations  
 
# ESP, EBP and EIP 
 ESP - The Stack Pointer = keeps the track of the most recently referenced location on the stack by storing a pointer to it
 - ->a pointer is a ref to an address or a location in memory 
 registers store target address
 -Since the stack is in constant flux storing the execution of a thread, it's hard for a func to locate it's own stack frame, therefore need for an ebp 
 EBP - The Base Pointer = Stores a pointer to the top of the stack when a func is called  
 A func can esily ref info from its own stack frame via offsets while exec
 EIP- The Instruction Pointer = always points to the next code instruction to be executed (Directs the flow of a program)
 
 ##
