;macro example with 3 arguments
;defining macro
%macro      aver    3
    mov    eax, 0
    mov    eax, dword[%2] ;length
    mov    r12, 0
    lea    rbx, [%1]

%%sumLoop:
    add    eax, dword [rbx+ r12*4]
    inc    r12
    loop   %%sumLoop

    cdq 
    idiv    dword [%2]
    mov     dword [%3], eax
%endmacro

section .data
;define constants
EXIT_SUCCESS        equ  0      ;successful exit
SYS_exit            equ  60     ;code for terminate
;define variables
list1     dd    4, 5, 2, -3, 1
len1      dd    5
ave1      dd    0

list2     dd    2, 6, 3, -2, 1, 8, 19
len2      dd    7
ave2      dd    0

section .text
global _start
_start:
;---------------
;invoke the macro here in program
aver    list1,len1,ave1 ;first dataset
aver    list1,len2,ave2 ;second dataset

last:
mov     rax, SYS_exit       ;exit
mov     rdi, EXIT_SUCCESS   ;success
syscall