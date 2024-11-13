extern _add_numbers
extern _printf

section .data
    filename db "input.txt", 0
    newline db 10

section .bss
    buff resb 128
    bytesread resq 1

section .text
    global _start

_start:
    ; open file (sys_open)
    mov rax, 2                      ; sys_open
    mov rdi, filename               ; pointer to filename
    mov rsi, 0
    syscall                         ; make syscall
    mov rbx, rax

    ; check if file was opened successfully
    mov rax, 0
    jl _exit                        ; if opened failed, exit program

    ; read from file
    mov rax, 0                      ; sys_read
    mov rdi, rbx                    ; file descriptor
    mov rsi, buff                   ; buffer to store
    mov rdx, 128                    ; number of bytes to read
    syscall

    mov [bytesread], rax           ; store number of bytes read

    ; write to stdout
    mov rax, 1                      ; sys_write
    mov rdi, 1                      ; stdout
    mov rsi, buff                   ; pointer to buffer
    syscall                         ; make syscall     

    ; print newline
    mov rax, 1                      ; sys_write
    mov rdi, 1                      ; stdout
    mov rsi, newline
    mov rdx, 1
    syscall

    ; close the file
    mov rax, 3                      ; sys_close
    mov rdi, rbx                    ; file descriptor
    syscall
    

_exit:
    mov rax, 60
    xor rdi, rdi
    syscall