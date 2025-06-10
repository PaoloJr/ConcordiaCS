section .data
    result_msg db "Result of addition: ", 0
    newline db 0xA

section .bss
    result_str resb 20              ; reserve 20 bytes for up to characters in result string

section .text
    global _start                   ; program entry point

    extern add_numbers             ; declare external function from file1.asm

_start:
    ; setup numbers to add
    mov rdi, 5                      ; first number
    mov rsi, 10                     ; second number

    call add_numbers                ; result will be in rax

    ; convert integer result in rax to string in result_str
    mov rdi, result_str             ; destination buffer for the string
    call int_to_string              ; convert integer to string

    ; print result message
    mov rax, 1                      ; sys_write
    mov rdi, 1                      ; stdout
    mov rsi, result_msg             ; pointer to message
    mov rdx, 20                     ; message length
    syscall

    ; print result string
    mov rax, 1                      ; sys_write
    mov rdi, 1                      ; stdout
    mov rsi, result_str
    mov rdx, rax                    ; string length (from int_to_string)
    syscall

    ; print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; exit program
    mov rax, 60                     ; sys_exit
    xor rdi, rdi                    ; exit code 0
    syscall

int_to_string:
    ; converts integer in rax to a string at rdi
    ; and returns string length in rax
    mov rcx, 10                     ; base 10 divisor
    mov rbx, rdi                    ; save start of buffer

.int_to_string_loop:
    xor rdx, rdx                    ; clear rdx for div
    div rcx                         ; divide rax by 10
    add dl, '0'                     ; convert remainder to ASCII
    dec rdi                         ; move pointer back
    mov [rdi], dl                   ; store digit
    inc rdx
    test rax, rax                   ; check if number is 0
    jnz .int_to_string_loop         ; if not zero, continue loop

    mov byte [rbx], 0               ; null-terminate string
    mov rax, rbx                    ; get end of buffer
    sub rax, rdi                    ; calculate length    
    ret
