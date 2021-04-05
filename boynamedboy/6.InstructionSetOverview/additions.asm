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

;double quad
dquad1   ddq  0x1A000000000000000
dquad2   ddq  0x2C000000000000000
dqSum     ddq  0

;---
; Code Section
section .text
global _start
_start:
;Addition
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
;inc instruction
inc rax ; rax = rax + 1
inc byte [bNum1] ; bNum1 = bNum1 + 1
inc word [wNum1] ; wNum1 = wNum1 + 1
inc dword [dNum1] ; dNum1 = dNum1 + 1
inc qword [qNum1] ; qNum1 = qNum1 + 1 

;--------------
;adc instruction
mov rax, qword [dquad1] ; accesses first 64 bits of dquad1 variable
mov rdx, qword [dquad1+8] ;access the next 64 bits of dquad1 variable 
                          ;accomplished by using the variable starting address, dquad1 then adding 8 bytes thus skipping first 64bits(8bytes)  and thus accessing next 64 bits

;if the LSQ's are added, then the MSQ's are added including any carry,...
; ...thus the 128 bit result can be correctly obtained
add rax, qword [dquad2]
adc rdx, qword [dquad2+8]

mov qword [dqSum], rax
mov qword [dqSum+8], rdx



;----------------
;Substraction
;bAns = bNum1 - bNum2
mov al, byte[bNum1]
sub al, byte[bNum2]
mov byte[bAns], al

;wAns = wNum1 - wNum2
mov ax, word [wNum1]
sub ax, word [wNum2] 
mov word [wAns], ax 

;dAns = dNum1 - dNum2
mov eax, dword [dNum1] 
sub eax, dword [dNum2] 
mov dword [dAnsw], eax

;qAns = qNum1 - qNum2
mov rax, qword [qNum1]
sub rax, qword [qNum2]
mov qword [qAns], rax



;------------------
;decrement
dec rax ;rax - 1
dec byte [bNum1] ;bNum1 = bNum1 - 1
dec word [wNum1] ;dNum1 = dNum1 -1
dec dword [dNum1] ;dNum1 = dNum1 -1
dec qword [qNum1] ;qNum1 = qNum1 - 1










last:
mov rax, SYS_exit   ;Call program code for exit
mov rdi, EXIT_SUCCESS ;exit program with success
syscall
















