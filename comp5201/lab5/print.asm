section .data
    message db "Hello World!", 0xA               ; string to print (with newline)
    len equ $-message                            ; length of the string

section .text
    global _start

_start:
    mov rsi, message                             ; address ot the string
    mov rdx, len                                 ; length of the string
    call print                                   ; call the print subroutine

    mov rax, 60                                  ; exit system call
    xor rdi, rdi                                 ; return code 0
    syscall                                      ; exit the program

print:
    mov rax, 1                                   ; sys_write
    mov rdi, 1                                   ; file descriptor (stdout)
    syscall                                      ; make system call
    ret                                          ; return to the function caller