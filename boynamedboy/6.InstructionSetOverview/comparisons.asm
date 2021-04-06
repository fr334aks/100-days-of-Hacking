section .data
;------
;Define Constants

EXIT_SUCCESS    equ     0 ;Successful Operation
SYS_exit        equ     60;Call for application to quit
TRUE            equ     1
FALSE           equ     0
;-------------
;variable declaration
x       dd    0
y       dd    0
ans     dd    0
errFlag dd    0
;---
; Code Section
section .text
global _start
_start:

;if (x != 0) {
;    ans = x / y;
;    errFlg = FALSE;
;} else {
;    ans = 0;
;    errFlg = TRUE;
;}
;this can be translated as:
cmp  dword [x], 0
je   doElse
mov  eax, dword [x]
cdq
idiv eax, dword [y]
mov  dword [ans], eax
mov byte [errFlag], FALSE
jmp last


doElse:
mov dword [ans], 0
mob byte [errFlag], TRUE
jmp last

last:
mov rax, SYS_exit   ;Call program code for exit
mov rdi, EXIT_SUCCESS ;exit program with success
syscall