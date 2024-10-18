segment .data ; initialized data segment
	firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $-firstPrompt ; length of firstPrompt
	outMsg1 db "The number entered is: ", 0xA, 0
    lenOutMsg1 equ $-outMsg1 ; length of outMsg1

segment .bss ; unintialized data segment
	buffer1 resw 1 ; to hold the value entered, 1 word, 2 bytes

segment .text
	global main
    extern prinf

main:
    ; print prompt to user
    mov eax, 4 ; syscall number for sys_write
    mov ebx, 1 ; stdout, default output device 
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt ; length of firstPrompt
    int 0x80

    ; read user input
    mov eax, 3 ; syscall number for sys_read
    mov ebx, 0 ; stdin, default input device
    lea ecx, [buffer1] ; load address of the buffer
    mov edx, 6 ; max number of bytes to read
    int 0x80


    ; print output message
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, outMsg1 ; address of of outMsg1
    mov edx, lenOutMsg1 ; length of outMsg1
    int 0x80


    ; print the user-entered input
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    lea ecx, [buffer1] ; address of the buffer
    mov edx, 6 ; bytes to write (5 chars + newline)
    int 0x80

    ; exit
    mov eax, 1 ; syscall number for exit
    mov ebx, 0
    int 0x80
