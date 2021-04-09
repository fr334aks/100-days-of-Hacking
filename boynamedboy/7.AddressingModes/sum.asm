;program to calculate sum of numbers in list
section .data
;Declare variables and constants
;Constants
EXIT_SUCCESS    eq  0   ;code for exiting successful
SYS_EXIT        eq  60  ;code for calling program to terminate
;variables

lst     dd  1002, 1004, 1006, 1008, 10010
len     dd  5
sum     dd  0



section .text
global _start
start:
;----------------
;summation loop
mov ecx, dword [len]    ;get length value
mov rsi, 0              ;index = 0

sumLoop:
mov eax, dword [lst+(rsi*4)]    ;get lst[rsi]
add dword [sum], eax            ;update sum
inc rsi                         ;next item
loop sumLoop                    ;loop the sumLoop label on reaching this point

;-------------
;done, now we terminate program below

last:
mov rax, SYS_EXIT
mov rdi, EXIT_SUCCESS
syscall
