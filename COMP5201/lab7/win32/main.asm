extern _add_numbers                 ; declare external function from .dll
extern _printf                      ; declare external printf function (C library)

section .data
    msg db "Result: %d", 10, 0      ; format string for printf
    dll_name db "link.dll", 0        ; .dll file name

section .bss
    result resd 1

section .text
    global _main                    ; entry point for program

_main:
    ; prepare arguments for the _add_numbers function
    push 5
    push 3

    call _add_numbers               ; call dll function

    ; now eax contains the result
    ; store result in the `result` variable
    mov [result], eax

    push eax                        ; push result (in eax) to the stack as an argument for _printf
    push msg                        ; push the format string (msg) to the stack
    call _printf

    ; exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80