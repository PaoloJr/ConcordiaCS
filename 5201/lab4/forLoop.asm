section .data
    msg db "Value: %d", 0

section .text
    extern _printf
    global _main

_main:
    ;initialize i = 0
    mov ecx, 0

for_loop:
    ; set the conditionL if (x >=5), exit the for_loop
    cmp ecx, 5
    jge end_for_loop

    ; body of the for_loop
    push ecx
    push msg
    call _printf
    add esp, 8

    ; increment i (ecx)
    inc ecx+
    jmp for_loop

end_for_loop:
    ; exit the program
    mov eax, 0
    ret