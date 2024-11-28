extern print
extern iread
extern iprint
extern prln

section .data
    global newline
    global lenNewline

    firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $-firstPrompt 
    ; outMsg db "The number entered is: ", 0xA, 0
    ; lenOutMsg equ $-outMsg  
    ; outMsgDiv db "Half of the entered number is: ", 0xA, 0
    ; lenOutMsgDiv equ $-outMsgDiv
    ; outMsgMul db "Double of the entered number is: ", 0xA, 0
    ; lenOutMsgMul equ $-outMsgMul

    ; new messages
    negMsg db "The entered number (", 0
    lenNegMsg equ $-negMsg
    negMsg2 db ") cannot be a perfect square as it is negative.", 0xA, 0
    lenNegMsg2 equ $-negMsg2
    posMsg db "The entered number (", 0
    lenPosMg equ $-posMsg
    posMsg2 db ") is a perfect square and its square root is ", 0
    lenPosMsg2 equ $-posMsg2
    notPerfectMsg db ") is not a perfect square.", 0xA, 0
    lenNotPerfectMsg equ $-notPerfectMsg
    errorMsg db "Error: Number exceeds 4 digits.", 0xA, 0
    lenErrorMsg equ $-errorMsg
    newline db 0xA, 0
    lenNewline equ $-newline 

section .bss
    global strIn
    global intOut
    global strOut
    global digitCount
    
    strIn resb 6                                                           ; 6 bytes to hold sign + 4-digits + newline
    intOut resd 1                                                          ; hold the converted value as signed integer (1 double word, 32-bits)
    strOut resb 8                                                          ; 8 bytes to hold the returned signed ASCII string, newline and null terminator

    ; new variables
    global root 
    global rootsqr

    root resd 1
    rootsqr resd 1
    digitCount resb 1

section .text
    global main

main:

while:
    ; call print with the first prompt
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt
    call print

    mov byte [digitCount], 0        ; reset digitCount
    call iread                      ; read signed integer and return the binary integer (store in intOut)

    ; check if input is empty (compare a byte with ASCII newline character)
    cmp byte [strIn], 10            
    je endwhile           

    ; check if the input length exceeds 4 digits
    ; mov al, [digitCount]            
    ; cmp al, 4
    ; jg input_too_long

    ; check if input is not an integer

    ; Check if the number is negative
    mov eax, [intOut]
    cmp eax, 0
    jl negative_number

    ; Positive number, determine initial guess for root
    mov ecx, eax
    cmp ecx, 9
    jl set_root_0
    cmp ecx, 99
    jl set_root_4
    cmp ecx, 999
    jl set_root_10
    cmp ecx, 9999
    jl set_root_32

; initial guesses (switch cases)
set_root_0:
    mov dword [root], 0
    jmp calculate_square

set_root_4:
    mov dword [root], 4
    jmp calculate_square

set_root_10:
    mov dword [root], 10
    jmp calculate_square

set_root_32:
    mov dword [root], 32

calculate_square:
    mov eax, [root]
    imul eax, eax
    mov [rootsqr], eax

calculate_loop:
    mov eax, [rootsqr]
    cmp eax, [intOut]
    jge check_perfect_square
    mov eax, [root]
    inc eax
    mov [root], eax
    imul eax, eax
    mov [rootsqr], eax
    jmp calculate_loop

check_perfect_square:
    mov eax, [rootsqr]
    cmp eax, [intOut]
    je perfect_square

not_perfect_square:
    mov ecx, posMsg
    mov edx, lenPosMg
    call print
    mov eax, [intOut]
    ; mov edi, strOut
    call iprint
    mov ecx, notPerfectMsg
    mov edx, lenNotPerfectMsg
    call print
    call prln
    jmp while

perfect_square:
    mov ecx, posMsg
    mov edx, lenPosMg
    call print
    mov eax, [intOut]
    ; mov edi, strOut
    call iprint
    mov ecx, posMsg2
    mov edx, lenPosMsg2
    call print
    mov eax, [root]
    ; mov edi, strOut
    call iprint
    call prln
    jmp while

negative_number:
    mov ecx, negMsg
    mov edx, lenNegMsg
    call print
    mov eax, [intOut]
    ; mov edi, strOut
    call iprint
    mov ecx, negMsg2
    mov edx, lenNegMsg2
    call print
    call prln
    jmp while

input_too_long:
    mov ecx, errorMsg
    mov edx, lenErrorMsg
    call print
    call prln
    jmp while


; while:
;     ; call print with the first prompt
;     mov ecx, firstPrompt
;     mov edx, lenFirstPrompt
;     call print

;     call iread                                                             ; read signed integer and return the binary integer (store in intOut)

;     ; Check if the input is empty (only Enter pressed)
;     cmp byte [strIn], 10                                                   ; compare a byte with ASCII newline character
;     je endwhile                                                            ; If yes, jump to endwhile to exit the loop

;     ; display second messsage "The number entered is: "
;     mov ecx, outMsg
;     mov edx, lenOutMsg
;     call print

;     mov eax, [intOut]                                                      ; Load the integer value into eax
;     call iprint                                                            ; print the original integer after converting to string
;     call prln

;     ; display "Double of the entered number is: "
;     mov ecx, outMsgMul
;     mov edx, lenOutMsgMul
;     call print

;     mov eax, [intOut]                                                      ; re-load integer value into eax
;     sal eax, 1                                                             ; arithmetic shift left by 1 for multiplication
;     call iprint
;     call prln

;     ; display "Half of the entered number is: "
;     mov ecx, outMsgDiv
;     mov edx, lenOutMsgDiv
;     call print

;     mov eax, [intOut]                                                      ; re-load integer value into eax
;     test eax, eax                                                          ; Check if EAX is zero or non-zero and sets the sign-flag (SF)
;     jns positive_halve                                                     ; If positive or zero (non-negative); SF = 0, jump to positive_halve

;     ; Negative number adjustment
;     add eax, 1                                                             ; Adjust for negative numbers
;     sar eax, 1                                                             ; Arithmetic shift right by 1
;     call iprint
;     call prln
;     jmp clear

; positive_halve:
;     sar eax, 1                                                             ; Direct shift for positive numbers
;     call iprint
;     call prln

; clear:
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
    xor ebx, ebx
    int 0x80