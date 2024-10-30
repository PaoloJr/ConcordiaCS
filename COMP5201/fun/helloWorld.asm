
; 32-bit ELF (Linux) Hello World
section .data
    msg db "Hello World!", 0xA          ; message to print with a newline character `0xA` = `\n` in ASCII
    msgLength equ $-msg                 ; dynamically get message buffer length

section .text
    global _start                       ; program must start with `_start`

_start:
    mov eax, 4                          ; sys_write
    mov ebx, 1                          ; file descriptor = 
    mov ecx, msg                        ; store message in ecx
    mov edx, msgLength                  ; store length of message in edx
    int 0x80

    ; try to print the value of msgLength
    mov eax, 4
    mov ebx, 1
    mov ecx, msgLength
    mov edx, msgLength
    int 0x80

    mov eax, 1                          ; sys_exit
    mov ebx, 0                          ; clear ebx
    int 0x80