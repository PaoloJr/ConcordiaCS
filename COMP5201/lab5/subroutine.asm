section .data
    message db 'Hello World!', 0xA          ; message to print followed by newline
    message_len equ $-message               ; length of message
    newline db 0xA                          ; ASCII newline character

section .text
    global _start

_start:
    call print_message                      ; call the print message subroutine
    call prIn                               ; call the prIn subroutine to print a newline
    mov rax, 60                             ; exi system call
    xor rdi, rdi                            ; return code 0
    syscall                                 ; exit the program

; subroutine to print a string
print_message:
    mov rax, 1                              ; sys_write system call number
    mov rdi, 1                              ; file descriptor (stdout)
    mov rsi, message                        ; address of the message
    mov rdx, message_len                    ; length of the message
    syscall                                 ; make the system call
    ret                                     ; return to the caller

prIn:
    mov rax, 1                              ; sys_write system call number
    mov rdi, 1                              ; file descriptor (stdout)
    mov rsi, newline                        ; address of the message
    mov rdx, 1                              ; length of the newline (1 byte)
    syscall                                 ; make the system call
    ret                                     ; return to the caller
