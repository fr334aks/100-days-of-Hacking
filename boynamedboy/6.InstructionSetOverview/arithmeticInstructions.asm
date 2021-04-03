section .data

;------
;Define Constants

EXIT_SUCCESS    equ     0 ;Successful Operation
SYS_exit        equ     60;Call for application to quit

;-------------
;variable declaration
;byte
bNum1   db  42
bNum2   db  73
bAns    db  0

;word
wNum1   dw  4321
wNum2   dw  1234
wAns    dw  0

;Double Word
dNum1   dd  42000
dNum2   dd  73000
dAnsw   dd  0

;quad
qNum1   dq  42000000
qNum2   dq  73000000
qAns    dq  0

;---
; Code Section
section .text
global _start
_start:
;bAns = bNum1 + bNum2
mov al, byte[bNum1]
add al, byte[bNum2]
mov byte[bAns], al

;wAns = wNum1 + wNum2
mov ax, word [wNum1]
add ax, word [wNum2] 
mov word [wAns], ax 

;dAns = dNum1 + dNum2
mov eax, dword [dNum1] 
add eax, dword [dNum2] 
mov dword [dAnsw], eax

;qAns = qNum1 + qNum2
mov rax, qword [qNum1]
add rax, qword [qNum2]
mov qword [qAns], rax

;------------
;inc operand
inc rax ; rax = rax + 1
inc byte [bNum1] ; bNum1 = bNum1 + 1
inc word [wNum1] ; wNum1 = wNum1 + 1
inc dword [dNum1] ; dNum1 = dNum1 + 1
inc qword [qNum1] ; qNum1 = qNum1 + 1 














last:
mov rax, SYS_exit   ;Call program code for exit
mov rdi, EXIT_SUCCESS ;exit program with success
syscall
















