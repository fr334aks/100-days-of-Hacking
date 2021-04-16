;Program converts integer to and ascii string
;Integer iis double word; must  be converted to quad word for division
;since number being divided must have a bigger size thab the divisor
section .data
;declare constants
NULL                equ   0
EXIT_SUCCESS        equ   0  ;successful exit
SYS_exit            equ   60 ;code for terminate
;declare variables
intNum      dw  1480

section .bss
strNum      resb    10

section .text
global _start
_start:
;convert interger to ascii string
;Part A - Successive Division
;Since the stack is quadwords, the entire quadword register will be pushed
;The upper-order portion of the register will not
;be accessed, so its contents are not relevant

mov     eax, dword [intNum] ;get integer
mov     rcx, 0 ;digitCount = 0
mov     ebx, 10 ;set count for dividing by 10

divideLoop:
mov     edx, 0
div     ebx ;divide number by 10

push    rdx ;push remainder
inc     rcx ;increment digit count

cmp     eax, 0 ;if (result>0)
jne     divideLoop ;to to divideLoop

;-------------------------------
;convert remainders and store
mov     rbx, strNum ;get address of string
mov     rdi, 0 ;idx = 0

popLoop:
pop     rax ;pop intDigit(remove it from rax)

add     al, "0" ;char = int + "0"

mov     byte [rbx+rdi], al;string [idx] = char
inc     rdi ;increments idx
loop    popLoop ;if (digitCount > 0 ), go to popLoop

mov     byte [rbx+rdi], NULL ;string idx = NULL

last:
; terminate program
mov     rax, SYS_exit ;call for code to exit
mov     rdi, EXIT_SUCCESS ; exit with success
syscall