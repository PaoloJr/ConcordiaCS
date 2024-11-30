section .data
    minus_zero db "-0", 0xA, 0

section .text
    extern strIn
    extern intOut
    extern strOut
    extern newline
    extern lenNewline
    extern input_non_number
    extern input_invalid_num

    global print:function
    global iread:function
    global iprint:function
    global prln:function

;----------------------------------------
; Subroutine: iread
; Reads a string from stdin, converts it to an integer, and stores it in [intOut]
;----------------------------------------
iread:
    ; read user input
    mov eax, 3                                                     ; sys_read
    mov ebx, 0                                                     ; stdin, default input device
    mov ecx, strIn                                                 ; load address of the buffer
    mov edx, 32                                                    ; many bytes to read
    int 0x80
    mov ebp, eax                   ;                               ; Store the number of bytes read

    ; Check if the input length matches minus_zero
    cmp ebp, 3                                                     ; Length of "-0\n" is 3 bytes
    jne continue_conversion        

    ; Set up registers for string comparison
    mov esi, strIn                                                 ; Source index pointing to strIn
    mov edi, minus_zero                                            ; Destination index pointing to minus_zero
    mov ecx, 3                                                     ; Number of bytes to compare

    ; Compare strIn with minus_zero
    repe cmpsb                                                     ; Compare ECX bytes from [ESI] and [EDI]

    ; Check if the strings are equal
    jne continue_conversion   

    ; If equal, the input is "-0\n", handle the error
    jmp input_invalid_num

continue_conversion:
    ; ASCII to integer conversion, store result in intOut
    mov esi, strIn                                                 ; start ESI at strIn (beginning of user input buffer)
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    mov edi, 1                                                     ; set EDI to positive

    ; check for negative sign
    mov cl, [esi]                                                  ; load first character
    cmp cl, '-'                                                    ; compare with ASCII `-` character
    jne check_digit                                                ; jump if it is not `-`
    mov edi, -1                                                    ; set EDI to negative
    inc esi                                                        ; move to next character (a number value) index

check_digit:
    mov cl, [esi]                                                  ; load current character (1 byte)
    cmp cl, 10                                                     ; check if character is a newline
    je done                                                        ; jump to done if cmp is true
    cmp cl, '0'
    jl input_error_non_number
    cmp cl, '9'
    jg input_error_non_number

convert_to_int:
    sub cl, '0'                                                    ; subtract ASCII value to convert character
    imul eax, eax, 10                                              ; multiply to shift the value left by one decimal place
    add eax, ecx                                                   ; add integer value of current digit
    inc esi                                                        ; move to next character
    jmp check_digit

done:
    imul eax, edi                                                  ; multiply by EDI for the sign (+/-)
    mov [intOut], eax                                              ; store to memory location `intOut`
    ret

input_error_non_number:
    call input_non_number                                          ; print error 
    
;----------------------------------------
; Subroutine: iprint
; Converts the integer in EAX to a string and prints it
;----------------------------------------
iprint:
    mov ebx, eax                                                   ; Move integer to EBX
    mov esi, strOut                                                ; Point ESI to the end of strOut buffer
    mov ecx, 10                                                    ; Divisor for modulus
    xor edi, edi                                                   ; clear EDI (negative flag)  

convert_number:
    ; Handle negative numbers
    test ebx, ebx
    jge convert_to_string
    neg ebx                                                        ; Make EBX positive
    mov edi, 1                                                     ; set EDI to positive

convert_to_string:
    xor edx, edx                                                   ; Clear EDX
    mov eax, ebx                                                   ; Move EBX to EAX for division
    div ecx                                                        ; Divide EAX by 10
    add dl, '0'                                                    ; Convert remainder to ASCII
    dec esi                                                        ; decrement esi
    mov [esi], dl                                                  ; Store character
    mov ebx, eax                                                   ; Update EBX with quotient
    cmp ebx, 0
    jne convert_to_string                                          ; if quotient is not zero, continue loop

finish_conversion:
    ; Add negative sign if necessary
    cmp edi, 1                                                     ; compare to positive flag in EDI
    jne prepare_print                                              ; if not positive, skip adding negative sign
    dec esi                                                        ; move ESI pointer back to make space for `-`
    mov byte [esi], '-'                                            ; add negative sign to that ESI address (front of string integer)

prepare_print:
    mov ecx, esi                                                   ; Pointer to the start of the string
    mov edx, strOut                                                ; strOut buffer
    sub edx, esi                                                   ; EDX = length of the string from ESI to end
    call print
    ret

;----------------------------------------
; Subroutine: print
; Prints the string pointed to by ECX of length EDX
; ECX and EDX are setup before calling print
;----------------------------------------
print:
    mov eax, 4                                                     ; sys_write
    mov ebx, 1                                                     ; stdout, default output device 
    int 0x80
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
