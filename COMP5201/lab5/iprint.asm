section .data
    prompt db "Enter your age: ", 0            ; prompt message
    prompt_len equ $-prompt                    ; length of prompt message (equ is a directive use to define constants or symbolic names; it allow to assign a name to a value
    result_msg db "Your age is: ", 0
    result_msg_len equ $-result_msg            ; length of result message ($ represents the current address)
    newline db 0xA                             ; ASCII newline character

section .bss
    age resb 3                                 ; buffer to store the age input (2 digits + newline)
                                               ; resb means reserve bytes                                            

section .text
    global _start

_start:
    ; print the prompt message
    mov eax, 4                                  ; sys_write
    mov ebx, 1                                  ; file descriptor: stdout
    mov ecx, prompt                             ; pointer to message
    mov edx, prompt_len                         ; length of message
    int 0x80

    ; read user input
    mov eax, 3                                  ; sys_read
    mov ebx, 0                                  ; file descriptor: stdin
    mov ecx, age                                ; buffer to stroe input
    mov edx, 3                                  ; maximum number of bytes to read (2 digits + newline)
    int 0x80                                    ; make syscall

    ; print the result message
    mov eax, 4                                  ; sys_write
    mov ebx, 1                                  ; file descriptor: stdout
    mov ecx, result_msg                         ; pointer to the result message
    mov edx, result_msg_len                     ; length of the result message
    int 0x80                                    ; make the syscall

    ; print the age
    mov eax, 4                                  ; sys_write
    mov ebx, 1                                  ; file descriptor: stdout
    mov ecx, age                                ; pointer to the age input
    mov edx, 2                                  ; number of bytes to print (age input)
    int 0x80                                    ; make the syscall

    ; print a newline for better output formatting
    mov eax, 4                                  ; sys_write
    mov ebx, 1                                  ; file descriptor: stdout
    mov ecx, newline                            ; pointer to the newline
    mov edx, 1                                  ; length of the newline
    int 0x80                                    ; make the syscall

    ; exit the program
    mov eax, 1                                  ; syscall exit
    xor ebx, ebx                                ; return code 0
    int 0x80                                    ; make the syscall