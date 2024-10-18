section .data
    message_add db "Addition = %d", 10, 0
    message_sub db "Subtraction = %d", 10, 0
    message_mul db "Multiplication = %d", 10, 0
    message_div db "Division = %d", 10, 0
    message_div_remainder db "Division remainder = %d", 10, 0
    remainder dd 0

section .text
    global _main
    extern _printf

_main:
    ; addition
    mov eax, 10
    mov ebx, 10
    add eax, ebx
    push eax
    push message_add
    call _printf
    add esp, 8

    ; subtraction
    mov eax, 20
    mov ebx, 4
    sub eax, ebx
    push eax
    push message_sub
    call _printf
    add esp, 8

    ; multiplication
    mov eax, 2
    mov ebx, 4
    mul ebx
    push eax
    push message_mul
    call _printf
    add esp, 8

    ; division
    mov edx, 0 ; initialize edx to zero before division
    mov eax, 13
    mov ecx, 2
    div ecx
    mov [remainder], edx
    push eax
    push message_div
    call _printf
    add esp, 8

    ; print remainder
    push dword [remainder]
    push message_div_remainder
    call _printf
    add esp, 8

    ret