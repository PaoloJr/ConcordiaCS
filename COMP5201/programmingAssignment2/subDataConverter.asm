section .data
    firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $-firstPrompt        

	outMsg db "The number entered is: ", 0xA, 0
    lenOutMsg equ $-outMsg                 

    outMsgDiv db "Half of the entered number is: ", 0xA, 0
    lenOutMsgDiv equ $-outMsgDiv

    outMsgMul db "Double of the entered number is: ", 0xA, 0
    lenOutMsgMul equ $-outMsgMul

    convertMsg db "The converted string is: ", 0xA, 0
    lenConvertMsg equ $-convertMsg         

    newline db 0xA, 0
    lenNewline equ $-newline

section .bss 
    strIn resb 6                                                          ; 6 bytes to hold sign + 4-digits + newline
    intOut resd 1                                                         ; hold the converted value as signed integer (1 double word, 32-bits)
    strOut resb 8                                                         ; 8 bytes to hold the returned signed ASCII string, newline and null terminator

section .text
	global _start


_start:

while:
    ; call print with the first prompt
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt
    call print

    call iread                                                          ; read signed integer and return the binary integer (store in intOut)

    ; Check if the input is empty (only Enter pressed)
    cmp byte [strIn], 10                                                ; compare a byte with ASCII newline character
    je endwhile                                                         ; If yes, jump to endwhile to exit the loop

    ; display second messsage "The number entered is: "
    mov ecx, outMsg
    mov edx, lenOutMsg
    call print

    mov eax, [intOut]                                                   ; Load the integer value into eax
    call iprint                                                         ; print the original integer after converting to string
    call prln

    ; display "Double of the entered number is: "
    mov ecx, outMsgMul
    mov edx, lenOutMsgMul
    call print

    mov eax, [intOut]                                                   ; re-load integer value into eax
    sal eax, 1                                                          ; arithmetic shift left by 1 for multiplication
    call iprint
    call prln

    ; display "Half of the entered number is: "
    mov ecx, outMsgDiv
    mov edx, lenOutMsgDiv
    call print

    mov eax, [intOut]                                                   ; re-load integer value into eax
    test eax, eax                                                       ; Check if EAX is zero or non-zero and sets the sign-flag (SF)
    jns positive_halve                                                  ; If positive or zero (non-negative); SF = 0, jump to positive_halve

    ; Negative number adjustment
    add eax, 1                                                          ; Adjust for negative numbers
    sar eax, 1                                                          ; Arithmetic shift right by 1
    call iprint
    call prln
    jmp clear

positive_halve:
    sar eax, 1                                                          ; Direct shift for positive numbers
    call iprint
    call prln

clear:
    ; clear strOut before next iteration
    mov byte [strOut], 0
    mov byte [strOut + 1], 0
    mov byte [strOut + 2], 0
    mov byte [strOut + 3], 0
    mov byte [strOut + 4], 0
    mov byte [strOut + 5], 0
    mov byte [strOut + 6], 0
    mov byte [strOut + 7], 0
    mov byte [strOut + 8], 0

    ; print newlines to separate the iterations
    call prln
    call prln
    call prln

    jmp while                                                              ; repeat the loop

endwhile:
    call end                                                               ; program exit

;----------------------------------------
; Subroutine: print
; Prints the string pointed to by ECX of length EDX
; ECX and EDX are setup before calling print
;----------------------------------------
print:
    mov eax, 4                                                             ; sys_write
    mov ebx, 1                                                             ; stdout, default output device 
    int 0x80
    ret

;----------------------------------------
; Subroutine: iread
; Reads a string from stdin, converts it to an integer, and stores it in [intOut]
;----------------------------------------
iread:
    ; read user input
    mov eax, 3                                                             ; sys_read
    mov ebx, 0                                                             ; stdin, default input device
    mov ecx, strIn                                                         ; load address of the buffer
    mov edx, 6                                                             ; bytes to read (sign + 4 chars)
    int 0x80

    ; ASCII to integer conversion, store result in intOut
    mov esi, strIn                                                         ; start ESI at strIn (beginning of user input buffer)
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    mov edi, 1                                                             ; set EDI to positive

    mov cl, [esi]                                                          ; load first character
    cmp cl, '-'                                                            ; compare with ASCII `-` character
    jne convert_to_int                                                     ; jump if it is not `-`
    mov edi, -1                                                            ; set EDI to negative
    inc esi                                                                ; move to next character (a number value) index

convert_to_int:
    mov cl, [esi]                                                          ; load current character (1 byte)
    cmp cl, 10                                                             ; check if character is a newline
    je done                                                                ; jump to done if cmp is true
    sub cl, '0'                                                            ; subtract ASCII value to convert character
    imul eax, eax, 10                                                      ; multiply to shift the value left by one decimal place
    add eax, ecx                                                           ; add integer value of current digit
    inc esi                                                                ; move to next character
    jmp convert_to_int

done:
    imul eax, edi                                                          ; multiply by EDI for the sign (+/-)
    mov [intOut], eax                                                      ; store to memory location `intOut`
    ret

;----------------------------------------
; Subroutine: iprint
; Converts the integer in EAX to a string and prints it
;----------------------------------------
iprint:
    mov ebx, eax                                                          ; Move integer to EBX
    mov esi, strOut + 7                                                   ; Point ESI to the end of strOut buffer
    mov ecx, 10                                                           ; Divisor for modulus
    xor edi, edi                                                          ; clear EDI (negative flag)  

convert_number:
    ; Handle negative numbers
    test ebx, ebx
    jge convert_to_string
    neg ebx                                                                ; Make EBX positive
    mov edi, 1                                                             ; set EDI to positive
    jmp convert_to_string

convert_to_string:
    xor edx, edx                                                           ; Clear EDX
    mov eax, ebx                                                           ; Move EBX to EAX for division
    div ecx                                                                ; Divide EAX by 10
    add dl, '0'                                                            ; Convert remainder to ASCII
    dec esi                                                                ; decrement esi
    mov [esi], dl                                                          ; Store character
    mov ebx, eax                                                           ; Update EBX with quotient
    cmp ebx, 0
    jne convert_to_string

finish_conversion:
    ; Add negative sign if necessary
    cmp edi, 1                                                             ; compare to positive flag in EDI
    jne prepare_print                                                      ; if not positive, skip adding negative sign
    dec esi                                                                ; move ESI pointer back to make space for `-`
    mov byte [esi], '-'                                                    ; add negative sign to that address (front of string integer)

prepare_print:
    mov ecx, esi                                                           ; Pointer to the start of the string
    mov edx, strOut                                                        ; strOut buffer
    sub edx, esi                                                           ; EDX = length of the string from ESI to end
    call print
    ret

;----------------------------------------
; Subroutine: prln
; Prints a newline
;----------------------------------------
prln:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 0x80
    ret

end:
    mov eax, 1                               
    mov ebx, 0                               
    int 0x80