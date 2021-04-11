;Reverse a list of numbers
section .data
;---------------------------------------
;define constamts
EXIT_SUCCESS    eq      0
SYS_EXIT        eq      60
;----------------------------------------
;define variables
numbers    dq  100, 101, 102, 103, 104
len        dq  0

section .text
global _start:
start:
;push each number into stack
;pop each number, then put back into memory

;loop to get numbers into stack
mov     rcx, qword [len]
mov     rbx, numbers
mov     r12, 0
mov     rax, 0

pushLoop:
push    qword [rbx + (r12*8)]
inc     r12
loop    pushLoop

;-------------------
;with all numbers on stack now do:
;loop to get them back off into original list
mov     rcx, qword [len]
mov     rbx, numbers
mov     r12,  0

popLoop:
pop     rax
mov     qword [numbers + (r12*8)], rax
inc     r12
loop    popLoop

;done, we can now terminate the program below
last:
mov     rax, SYS_EXIT
mov     rdi, EXIT_SUCCESS
syscall
