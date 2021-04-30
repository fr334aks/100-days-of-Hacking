;we will be using thr gcc linker :-)
extern printf,_exit; here we call c functions

section .data;here we add important data files
;
        message : db "hello world",10,0
        format:db "%s",0;0 is ascii for end or terminate while 10 stands for new line

;section .bss;reserved memory
section .text;
global main
 main:
    push ebp
    mov ebp,esp
    ;you call variables in the reversed order 
    push message
    push format
    call printf
    ;it is important to clean up the variables that you have used
    ;format and message take in 8 bytes
    ;so we clean 8 bytes from esp 
    add esp,0x8;when we add esp we are clearing values from it

    ;clear stack;
    mov esp,ebp
    pop ebp
    ret
    ;
    ;gcc hello -o gets -m32 -fno-stack-protector -z execstack compile with no stack protection #this links binary to the object file
    ;nasm -f elf helloworld.asm -o hello  #this compiles it to  elf object file
