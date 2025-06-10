section .text
    global _main
    extern _printf

_main:
    mov eax, 45
    mov ebx, 55
    add eax, ebx
    push eax
    push message
    call _printf
    add esp, 8
    ret

message db "Value = %d", 10, 0