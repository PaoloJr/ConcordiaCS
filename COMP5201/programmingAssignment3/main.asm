extern printf
extern scanf
extern print
extern iread
extern iprint
extern prln

section .data
    global newline
    global lenNewline

    firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $-firstPrompt 
    outMsg db "The number entered is: ", 0xA, 0
    lenOutMsg equ $-outMsg  
    outMsgDiv db "Half of the entered number is: ", 0xA, 0
    lenOutMsgDiv equ $-outMsgDiv
    outMsgMul db "Double of the entered number is: ", 0xA, 0
    lenOutMsgMul equ $-outMsgMul
    newline db 0xA, 0
    lenNewline equ $-newline 

section .bss
    global strIn
    global intOut
    global strOut
    
    strIn resb 6                                                           ; 6 bytes to hold sign + 4-digits + newline
    intOut resd 1                                                          ; hold the converted value as signed integer (1 double word, 32-bits)
    strOut resb 8                                                          ; 8 bytes to hold the returned signed ASCII string, newline and null terminator

section .text
    global _start

_start:

while:
    ; call print with the first prompt
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt
    call print

    call iread                                                             ; read signed integer and return the binary integer (store in intOut)

    ; Check if the input is empty (only Enter pressed)
    cmp byte [strIn], 10                                                   ; compare a byte with ASCII newline character
    je endwhile                                                            ; If yes, jump to endwhile to exit the loop

    ; display second messsage "The number entered is: "
    mov ecx, outMsg
    mov edx, lenOutMsg
    call print

    mov eax, [intOut]                                                      ; Load the integer value into eax
    call iprint                                                            ; print the original integer after converting to string
    call prln

    ; display "Double of the entered number is: "
    mov ecx, outMsgMul
    mov edx, lenOutMsgMul
    call print

    mov eax, [intOut]                                                      ; re-load integer value into eax
    sal eax, 1                                                             ; arithmetic shift left by 1 for multiplication
    call iprint
    call prln

    ; display "Half of the entered number is: "
    mov ecx, outMsgDiv
    mov edx, lenOutMsgDiv
    call print

    mov eax, [intOut]                                                      ; re-load integer value into eax
    test eax, eax                                                          ; Check if EAX is zero or non-zero and sets the sign-flag (SF)
    jns positive_halve                                                     ; If positive or zero (non-negative); SF = 0, jump to positive_halve

    ; Negative number adjustment
    add eax, 1                                                             ; Adjust for negative numbers
    sar eax, 1                                                             ; Arithmetic shift right by 1
    call iprint
    call prln
    jmp clear

positive_halve:
    sar eax, 1                                                             ; Direct shift for positive numbers
    call iprint
    call prln

clear:
    ; clear strOut before next iteration
    mov byte [strOut], 0

    ; print newlines to separate the iterations
    call prln
    call prln
    call prln

    jmp while                                                              ; repeat the loop

endwhile:
    call end                                                               ; program exit

end:
    mov eax, 1                               
    mov ebx, 0                               
    int 0x80