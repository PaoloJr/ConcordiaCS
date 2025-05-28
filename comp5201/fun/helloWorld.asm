section .data
    msg db "Hello World! What is your name?", 0xA, 0      ; message to print with a newline character `0xA` = `\n` in ASCII
    msgLength equ $-msg                                    ; dynamically get message buffer length
    msgName db "Hi ", 0                                    ; message prefix
    format db "%s%s", 0xA, 0                               ; format string for printf

section .bss
    inputTxt resb 100                                      ; reserve 100 bytes for input

section .text
    extern printf                                          ; declare the printf function
    extern exit                                            ; declare the exit function
    global main                                            ; program must start with `main`

main:
    ; print the initial message
    mov eax, 4                                             ; sys_write
    mov ebx, 1                                             ; file descriptor = stdout
    mov ecx, msg                                           ; store message in ecx
    mov edx, msgLength                                     ; store length of message in edx
    int 0x80

    ; read input
    mov eax, 3                                             ; sys_read
    mov ebx, 0                                             ; file descriptor = stdin
    mov ecx, inputTxt                                      ; store input buffer in ecx
    mov edx, 100                                           ; number of bytes to read
    int 0x80

    ; add null terminator to input
    mov byte [inputTxt + eax - 1], 0                       ; add null terminator at the end of input

    ; call printf to print the input
    push dword inputTxt                                    ; push the input buffer
    push dword msgName                                     ; push the message prefix
    push dword format                                      ; push the format string
    call printf                                            ; call printf
    add esp, 12                                            ; clean up the stack

    ; exit the program
    push dword 0                                           ; exit code 0
    call exit                                              ; call exit