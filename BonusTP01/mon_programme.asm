section .data
format db "%d", 10, 0  

section .bss
num resb 10

section .text
global main
extern printf

main:
    xor eax, eax        

loop_start:
    push eax
    push format
    call printf         
    add esp, 8          

    inc eax             
    cmp eax, 10000      
    jle loop_start      

    push 0              
    call exit           
