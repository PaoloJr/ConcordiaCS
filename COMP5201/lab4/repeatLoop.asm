section .data
    msg db "Value:  %d", 0

section .bss
    value resb 4

section .text
    extern _printf
    global _main

_main:
    ; intitialize i = 0
    mov ecx, 0

repeat_loop:
    ; body of the for_loop
    push ecx
    push msg
    call _printf
    add esp, 8

    ; increment i (ecx)
    inc ecx

    ; condition: if (i < 5), continue the for_loop
    cmp ecx, 5
    jl repeat_loop

    ; exit the program
    mov eax, 0
    ret