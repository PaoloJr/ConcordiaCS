section .data
    ; initialized data segment 
	
    firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $-firstPrompt        ; length of firstPrompt

	outMsg db "The number entered is: ", 0xA, 0
    lenOutMsg equ $-outMsg                 ; length of outMsg

    outMsgDiv db "Half of the entered number is: ", 0xA, 0
    lenOutMsgDiv equ $-outMsgDiv

    outMsgMul db "Double of the entered number is: ", 0xA, 0
    lenOutMsgMul equ $-outMsgMul

    convertMsg db "The converted string is: ", 0xA, 0
    lenConvertMsg equ $-convertMsg            ; length of convertMsg

    newline db 0xA, 0
    lenNewline equ $-newline

    modulo dd 0

section .bss 
    ; unintialized data segment
	
    strIn resb 6                              ; 6 bytes to hold the (ASCII string) plus newline
    strInLen resd 1                           ; 4 bytes for the length

    intOut resd 1                             ; hold the converted value as signed integer (1 double word, 32-bits)
    strOut resb 6                             ; 6 bytes to hold the returned ASCII string and newline
    sign resb 1                               ; reserve 1 byte for the sign


section .text
	global _start


_start:

    ; call print with the first prompt
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt
    call print

    ; read the signed integer and returns the binary integer (store in intOut)
    call iread

    ; display second prompt "The number entered is: "
    mov ecx, outMsg
    mov edx, lenOutMsg
    call print

    ; print the integer after converting to string
    call iprint

    ; print newline
    call prln

    ;exit
    call end


print:
    mov eax, 4                                ; syscall number for sys_write
    mov ebx, 1                                ; stdout, default output device 
    int 0x80
    ret

iread:
    ; read user input
    mov eax, 3                                ; syscall number for sys_read
    mov ebx, 0                                ; stdin, default input device
    mov ecx, strIn                            ; load address of the buffer
    mov edx, 6                                ; bytes to read (sign + 4 chars)
    int 0x80
    mov [strInLen], eax
    ; ASCII to integer conversion, store result in intOut
    ret
    
iprint:
    ; print the user-entered input (4-digit signed integer)
    mov eax, 4                               ; sys_write
    mov ebx, 1                               ; stdout
    lea ecx, strIn                           ; address of the buffer
    mov edx, [strInLen]                      ; bytes to write (up to strInLen)
    int 0x80
    ret

prln:
    ; Print newline after the output
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 0x80
    ret


end:
    ; program exit
    mov eax, 1                                ; syscall number for exit
    mov ebx, 0                                ; exit status
    int 0x80