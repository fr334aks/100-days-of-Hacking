#### `Program Format`
- A properly disassembled source file consists of:<br>
(i) Data Section<br>
(ii) BSS section<br>
(iii) Text Section<br>

#### `Comments`
- We use semi-colon(;) to denote Comments

#### `Numeric Values`
- May be specified in decimal, hex or octal
- Hex values are precided by a 0x e.g. for 15 = 0xE
- Octal values are followed by a q e.g. for 511 = 777q
- No special notation is required for decimal values since it is used as the default radix

#### `Constants`
- Are defined using `equ` keyword. e.g.
<name> equ <value>
- Are substituted for their defined values during assembly process thus not assigned a memory location and consequently not assigned a specific size.

#### `Data Section`
- Initialised data must be declared in "section .data" Section i.e. variables, Constants etc...
- Variables names start with letter followed by number, characters or even special characters(_).e.g.<br>
 <variable name>  <dataType> <initialValue>
- Supported data types are:<br>
db - 8 bit Variables
dw - 16 bit Variables
dd - 32 bit Variables
dq - 64 bit Variables
ddq - 128 bit variables(int)
dt -128 bit variable(float)
- Initialised arrays are defined in comma separated Values
- Some examples are:
bVar db 01 ;byte variable<br>
cVar db "H" ;single character<br>
strng db  "Hello World" ;string<br>
wVar dw 5000 ;16bit variable<br>
dVar dd 50000 ;32bit variables<br>
arr dd 100,200,300 ;3 element arrays<br>
flt1 dd 3.142 ;32bit float<br>
qVar dq 1000000000 ;64bit variable<br>

#### `BSS Section`
- Uninitialized data is stored in "section .bss" section.
- Variables defination must include name, type and count i.e.<br>
<variable name>  <resType>  <count>
- Supported data types are:<br>
resb - 8 bit variables<br>
resw - 16 bit variables<br>
resd - 32 bit Variables<br>
resq - 64 bit variables<br>
resdq - 128 bit Variables<br>
- Some examples are:
bArr resb 10 ;10 byte element array<br>
wArr resw 20 ;20 word element array<br>
dArr resd 35 ;36 double word element arrays<br>
qArr resq 42 ;42 quad element arrays<br>
- Allocated array is not initialised to any specific value.

#### `Text Section`
- Code is placed in the "section .text" section
- includes some headers or labels that define intial program entry point:e.g<br>
<t> global _start<br>
<t> _start:<br>
- No special directives are given to terminate the program. We however use a system service to inform the operating system that the program should be terminated and resources recovered and utilized.

#### `Example program`
- Here is an example program: [Simple Program](./example.asm)
