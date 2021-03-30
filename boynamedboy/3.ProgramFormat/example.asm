section .data

;------
;Define Constants

EXIT_SUCCESS    equ     0 ;Successful Operation
SYS_exit        equ     60;Call for application to quit

;-----
; Byte(8bit) variable declaration
bVar1    db      17
bVar2   db      9
bResult db      0

;---
; Word(16bit) variable declaration
wVar1       dw      17000
wVar2       dw      9000
wResult     dw      0

;---
; Double Word(32bit) variable declaration
dVar1       dd      17000000
dVar2       dd      9000000
dResult     dd      0


;---
; Quad(64bit) variable declaration
qVar1       dq      17000000
qVar2       dq      9000000
qResult     dq      0

;---
; Code Section
section .text
global _start
_start:

;Perfom Basic Addition

;Byte example:
;bResult = bVar1 + bVar2
mov al, byte [bVar1]  ;move value in bVar1 to register al
add al, byte [bVar2]  ;add value in bVar2 to value in register al
mov byte [bResult], al ; move value in al to bResult

;Word example:
;wResult = wVar1+wVar2
mov ax, word [wVar1] ;move value in wVar1 to register ax
add ax, word [wVar2] ;add value in wVar2 to value in register ax
mov word [wResult], ax ;move value in ax to wResult

;Double Word Example:
;dResult = dVar1+dVar2
mov eax, dword [dVar1] ;move value in dVarq to register eax
add eax, dword [dVar2] ;add value in dVar2 to value in the register
mov dword [dResult], eax ;move value in register eax to dResult

;Quad word exmaple:
;qResult = qVar1+qVar2
mov rax, qword [qVar1] ;move value in qVar1 to register rax
add rax, qword [qVar2] ;add value in qVar2 to value in register rax
mov qword [qResult], rax ;move value in register rax to qResult

;Done, now we can terminate the program using the constants we declared

last:
mov rax, SYS_exit   ;Call program code for exit
mov rdi, EXIT_SUCCESS ;exit program with success
syscall
















