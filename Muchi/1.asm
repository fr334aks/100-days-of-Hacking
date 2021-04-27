extends _printf, _exit;
section .data;
    message: db "Hello World",10,0; zero acts as a null terminator.in ascii 0 is null 10 is new line
    format: db "%s",0
    ; db ;stands for define double
    ; dw ;stands for define word
    ; dd ;define double

;section ;
section .text;

section _main
_main:
    push ebp; reserve stack space 
    mov ebp,esp;
    push message;
    push format;
    call _printf
