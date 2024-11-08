section .data ; initialized data segment
	firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $-firstPrompt        ; length of firstPrompt

	outMsg1 db "The number entered is: ", 0xA, 0
    lenOutMsg1 equ $-outMsg1                ; length of outMsg1

    outMsgDiv db "Half of the entered number is: ", 0xA, 0
    lenOutMsgDiv equ $-outMsgDiv

    outMsgMul db "Double of the entered number is: ", 0xA, 0
    lenOutMsgMul equ $-outMsgMul

    extraOutMsg db "The converted string is: ", 0xA, 0
    lenOutMsg2 equ $-extraOutMsg            ; length of outMsg2

    newline db 0xA, 0
    lenNewline equ $-newline


section .bss ; unintialized data segment
	userInput resb 6                        ; 6 bytes to hold the (ASCII string) plus newline
    userInputLength resd 1                  ; 4 bytes for the length

    userInputInteger resd 1                 ; hold the converted value as signed integer (1 double word, 32-bits)
    sign resb 1                             ; reserve 1 byte for the sign

    userInputIntDiv resd 1                  ; 4 bytes to hold the halved value
    halvedString resb 9                     ; halved value, reserve 8 bytes

    userInputIntMul resd 1                  ; 4 bytes to hold doubled value    
    doubledString resb 10                   ; doubled value, reserve 8 bytes


section .text
	global _start


_start:
    ; print "Enter an integer..." to user
    mov eax, 4                              ; syscall number for sys_write
    mov ebx, 1                              ; stdout, default output device 
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt                 ; length of firstPrompt
    int 0x80

    ; read user input
    mov eax, 3                              ; syscall number for sys_read
    mov ebx, 0                              ; stdin, default input device
    lea ecx, userInput                      ; load address of the buffer
    mov edx, 6                              ; bytes to read (sign + 4 chars)
    int 0x80

    mov [userInputLength], eax              ; store the number of bytes read
    cmp dword [userInputLength], 0
    je end                                  ; jump if equal to
    dec dword [userInputLength]             ; subtract 1 to exclude newline


    ; convert string input to integer value
    mov esi, userInput
    mov ecx, [userInputLength]              ; initialize the loop counter
    mov edx, 0                              ; edx will be used as index counter
    mov eax, 0                              ; eax will accumulate final integer
    mov byte [sign], 0                      ; initialize sign to be positive

    ; handle negative sign & decrement length
    cmp byte [esi], '-'                     ; check value of first byte with '-'
    jne first_digit                         ; if not negative jump
    mov byte [sign], 1                      ; otherwise, change value of sign variable

    ; If number is negative, get and convert first digit before loop and increment index
    mov bl, byte [esi + edx]                ; Retrieve first digit before incrementing index
    sub bl, '0'
    movzx eax, bl
    inc edx                                 ; skip '-' if integer is negative

; get the first digit
first_digit:
    mov bl, [esi + edx]                     ; get d3
    sub bl, '0'                             ; d3 - 48
    movzx eax, bl                       

conversion_loop:                            ; (i = 2 to 0 in the formula)
    inc edx
    cmp edx, ecx                        
    jge apply_sign                          ; If just first digit, apply the sign, else convert

    mov bl, [esi + edx]                     ; Get di
    sub bl, '0'                             ; di - 48
    imul eax, eax, 10                       ; value = value * 10
    add eax, ebx                            ; value = value + (di - 48)
    jmp conversion_loop                     ; Automatically decrements ecx and jumps if ecx > 0

apply_sign:
    cmp byte [sign], 1
    jne store_int                           ; if sign != 1, skip negation
    neg eax                                 ; else, negate eax

store_int:
    ; eax and ebx will have the same value
    ; eax will be used for division
    ; ebx will be used for multiplication
    mov ebx, eax                            ; store in ebx
    mov [userInputInteger], eax             ; store in memory

    ; division setup
    sar eax, 1                              ; divide eax by 2 (shift arithmetic right)
    mov [userInputIntDiv], eax              ; store halved value
    mov edi, halvedString + 9               ; Point edi to the end of halvedString (6 bytes buffer)
    mov byte [edi], 0                       ; Null-terminate
    call convert_div_toString               ; Convert halved value to string

    ; multiplication setup
    mov eax, ebx
    sal ebx, 1                              ; multiply ebx by 2 (shift arithmetic left)
    mov [userInputIntMul], ebx              ; store the doubled value
    mov edi, doubledString + 10             ; Point edi to the end of doubledString (7 bytes buffer)
    mov byte [edi], 0                       ; Null-terminate
    call convert_mul_toString               ; Convert doubled value to string

    jmp continue

convert_div_toString:                      
    push eax        

    ; Check if the value is negative and handle it
    cmp eax, 0
    jge div_convert_loop                    ; If non-negative, proceed to conversion
    ; neg eax                                 ; If negative, make it positive for conversion
    mov byte [sign], 1                      ; Set the sign to indicate it's negative     

div_convert_loop:                           ; do-while loop to convert                           
    mov edx, 0
    mov ecx, 10
    idiv ecx                                ; eax = quotient, edx = remainder
    add dl, '0'
    dec edi
    mov [edi], dl
    cmp eax, 0
    jnz div_convert_loop

    ; Handle negative sign after conversion based on original input
    cmp byte [sign], 1                      ; compare first byte with stored sign variable
    jne div_done                            ; if positive, skip prepend
    dec edi                                 ; Adjust edi for the sign
    mov byte [edi], '-'                     ; Prepend '-'

div_done:
    pop eax                                 ; Restore original halved value
    mov [halvedString], edi                 ; store string for printing
    mov byte [edi + 6], 0
    mov byte [sign], 0                      ; Reset sign
    ret                                     ; Return to calling function


convert_mul_toString:
    push ebx

    ; Check if the value is negative and handle it
    cmp ebx, 0
    jge mul_convert_start                   ; If non-negative, proceed to conversion
    neg ebx                                 ; If negative, make it positive for conversion
    mov byte [sign], 1                      ; Set the sign to indicate it's negative

mul_convert_start:
    mov eax, ebx                            ; Load the doubled value into eax

mul_convert_loop:                           ; do-while loop to convert
    mov edx, 0
    mov ecx, 10
    idiv ecx                                ; eax = quotient, edx = remainder
    add dl, '0'
    dec edi
    mov [edi], dl
    cmp eax, 0
    jnz mul_convert_loop

    ; Handle negative sign after conversion based on original input
    cmp byte [sign], 1                      ; compare first byte with stored sign variable
    jne mul_done                            ; if positive, skip prepend
    dec edi 
    mov byte [edi], '-'                     ; Prepend '-'

mul_done:
    pop ebx                                 ; Restore ebx
    mov [doubledString], edi                ; store string for printing
    mov byte [sign], 0                      ; Reset sign
    ret


; printing section
continue:
    ; print "The number entered is: "
    mov eax, 4                              ; sys_write
    mov ebx, 1                              ; stdout
    mov ecx, outMsg1                        ; address of of outMsg1
    mov edx, lenOutMsg1                     ; length of outMsg1
    int 0x80

    ; print the user-entered input (4-digit signed integer)
    mov eax, 4                              ; sys_write
    mov ebx, 1                              ; stdout
    lea ecx, userInput                      ; address of the buffer
    mov edx, [userInputLength]              ; bytes to write (up to userInputLength)
    int 0x80

    ; Print newline after the output
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 0x80

    ; print "Half the entered..."
    mov eax, 4                              ; sys_write
    mov ebx, 1                              ; stdout
    mov ecx, outMsgDiv                      ; address of of outMsgDiv
    mov edx, lenOutMsgDiv                   ; length of outMsgDiv
    int 0x80

    ; print halved signed integer
    mov eax, 4
    mov ebx, 1
    lea ecx, [halvedString]
    mov edx, 9                     
    int 0x80

    ; Print newline after the output
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 0x80

    ; print "Double of the entered..."
    mov eax, 4
    mov ebx, 1
    mov ecx, outMsgMul
    mov edx, lenOutMsgMul
    int 0x80

    ; print doubled signed integer
    mov eax, 4
    mov ebx, 1
    lea ecx, [doubledString]                    
    mov edx, 10
    int 0x80

    ; Print newline after the output
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 0x80



; program exit
end:
    mov eax, 1                                 ; syscall number for exit
    mov ebx, 0                                 ; exit status
    int 0x80