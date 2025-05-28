section .data
    msg db 'Factorial of 3 is: ', 0
    len equ $-msg
    newline db '', 0xA

section .bss
    fact resw 1     ; reserve 1 word / byte

section .text
    global _start

_start:             ; entry point
    mov bx, 3
    call proc_fact
    add ax, 30h
    mov [fact], ax

    ; print "Factorial of 3 is: "
    mov edx, len
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; print factorial
    mov edx, 1
    mov ecx, fact
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; print newline
    mov edx, 1
    mov ecx, newline
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; exit program
    mov eax, 1      ; sys_exit
    int 0x80        ; call kernel

proc_fact:
    cmp bl, 1       ; bl is an 8-bit register, subpart of bx (16-bit register)
    jg do_calculation
    mov ax, 1
    ret

do_calculation:
    dec bl
    call proc_fact
    inc bl
    mul bl          ; ax = al * bl
    ret

