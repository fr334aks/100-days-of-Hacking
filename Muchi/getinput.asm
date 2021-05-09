extern printf,scanf,_exit

section .data
    message :db "enter a number",10,0
    stringformat: db "%s",0
    decimalformat:db "%d",0
    holder:dd 00000000

section .text;
global _main
_main:
    push ebp
    mov esp,ebp
    jmp @printsring
    jmp @getinput
    jmp @printdecimal
    jmp @exit
   

@printstring:
    push ebp
    mov esp,ebp
    push message
    push stringformat
    call printf
    add esp,8
    mov esp,ebp
    pop ebp
    ret

@printdecimal:
    push ebp
    mov esp,ebp
    push eax
    push decimalformat
    call printf
    add esp,8
    mov esp,ebp
    pop ebp
    ret
@getinput:
    push ebp
    mov esp,ebp
    xor eax,eax
    mov eax,holder
    push decimalformat
    call scanf
    mov eax,dword[holder]
    add esp,8
    mov esp,ebp
    pop ebp
    ret

@exit:





