extern print
extern iread
extern iprint
extern prln

section .data
    global newline
    global lenNewline

    firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $-firstPrompt 
    negMsg db "The entered number (", 0
    lenNegMsg equ $-negMsg
    negMsg2 db ") cannot be a perfect square as it is negative.", 0
    lenNegMsg2 equ $-negMsg2
    posMsg db "The entered number (", 0
    lenPosMg equ $-posMsg
    posMsg2 db ") is a perfect square and its square root is ", 0
    lenPosMsg2 equ $-posMsg2
    notPerfectMsg db ") is not a perfect square.", 0
    lenNotPerfectMsg equ $-notPerfectMsg
    errorMsgTooLong db "Error: number exceeds 4 digits.", 0
    lenErrorMsgTooLong equ $-errorMsgTooLong
    errorMsgInvalidNum db "Error: invalid number."
    lenErrorMsgInvalidNum equ $-errorMsgInvalidNum    
    errorMsgNonNum db "Error: entry contains non-digit(s).", 0
    lenErrorMsgNonNum equ $-errorMsgNonNum
    newline db 0xA, 0    
    lenNewline equ $-newline
    root dd 0

section .bss
    global strIn
    global intOut
    global strOut
    global rootsqr

    strIn resb 32                                                           ; to hold many characters
    intOut resb 32                                                          ; hold the converted value as signed integer
    strOut resb 32                                                          ; 32 bytes to hold the returned signed ASCII string, newline and null terminator
    rootsqr resd 1

section .text
    global main 
    global input_non_number
    global input_invalid_num
    

main:

while:
    ; call print with the first prompt
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt
    call print

    ; read signed integer and return the binary integer (store in intOut)
    call iread

    ; check if input is empty (compare a byte with ASCII newline character)
    cmp byte [strIn], 10            
    je end      

    ; check if number is within range
    mov eax, [intOut]
    cmp eax, -9999
    jl input_too_long
    cmp eax, 9999
    jg input_too_long

    ; Check if the number is negative or -0
    mov eax, [intOut]
    cmp eax, 0
    jl negative_number

valid_num:
    ; Positive number, determine initial guess for root
    mov ecx, eax
    cmp ecx, 9
    jle single_digit
    cmp ecx, 99
    jl double_digit
    cmp ecx, 999
    jl triple_digit
    cmp ecx, 9999
    jl four_digit

; initial guesses (switch cases)
single_digit:
    mov dword [root], 0
    jmp calculate_square

double_digit:
    mov dword [root], 4
    jmp calculate_square

triple_digit:
    mov dword [root], 10
    jmp calculate_square

four_digit:
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

;----------------------------------------
; Messages Section
;----------------------------------------

not_perfect_square:
    mov ecx, posMsg
    mov edx, lenPosMg
    call print
    mov eax, [intOut]
    call iprint
    mov ecx, notPerfectMsg
    mov edx, lenNotPerfectMsg
    call print
    call prln
    jmp reset

perfect_square:
    mov ecx, posMsg
    mov edx, lenPosMg
    call print
    mov eax, [intOut]
    call iprint
    mov ecx, posMsg2
    mov edx, lenPosMsg2
    call print
    mov eax, [root]
    call iprint
    call prln
    jmp reset

negative_number:
    mov ecx, negMsg
    mov edx, lenNegMsg
    call print
    mov eax, [intOut]
    call iprint
    mov ecx, negMsg2
    mov edx, lenNegMsg2
    call print
    call prln
    jmp reset

input_too_long:
    mov ecx, errorMsgTooLong
    mov edx, lenErrorMsgTooLong
    call print
    call prln
    jmp reset

input_non_number:
    mov ecx, errorMsgNonNum
    mov edx, lenErrorMsgNonNum
    call print
    call prln
    jmp reset

input_invalid_num:
    mov ecx, errorMsgInvalidNum
    mov edx, lenErrorMsgInvalidNum
    call print
    call prln
    jmp reset

reset:
    call prln    
    jmp while

end:
    mov eax, 1                               
    xor ebx, ebx
    int 0x80