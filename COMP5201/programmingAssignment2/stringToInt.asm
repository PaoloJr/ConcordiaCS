section .bss
    buffer resb 6                                                               ; Reserve 6 bytes for input buffer (sign + 4-digits + newline)
    int_str resb 6                                                              ; Buffer to store the integer string

section .data
    prompt db "Enter an integer: ", 0
    lenPrompt equ $ - prompt
    newline db 10, 0
    lenNewline equ $ - newline

section .text
    global _start

_start:
    ; Print the prompt
    mov eax, 4                                                                  ; sys_write
    mov ebx, 1                                                                  ; file descriptor (stdout)
    mov ecx, prompt                                                             ; message to write
    mov edx, lenPrompt                                                          ; message length
    int 0x80                                                                    ; call kernel

    ; Read input
    mov eax, 3                                                                  ; sys_read
    mov ebx, 0                                                                  ; file descriptor (stdin)
    mov ecx, buffer                                                             ; buffer to store input
    mov edx, 10                                                                 ; maximum number of bytes to read
    int 0x80                                                                    ; call kernel

    ; Convert input to integer
    mov esi, buffer                                                             ; point to the start of the buffer
    xor eax, eax                                                                ; clear eax (accumulator for the integer)
    xor ebx, ebx                                                                ; clear ebx (multiplier, initially 0)
    xor ecx, ecx                                                                ; clear ecx (current character)
    mov edi, 1                                                                  ; initialize sign to positive (1)

    ; Check for sign
    mov cl, [esi]                                                               ; load the first character
    cmp cl, '-'                                                                 ; check if it's a minus sign
    ; jne check_plus                                                              ; if not, check for plus sign
    jne convert_to_int                                                              ; if not, check for plus sign
    mov edi, -1                                                                 ; set sign to negative (-1)
    inc esi                                                                     ; move to the next character
    jmp convert_to_int                                                          ; jump to conversion loop

; check_plus:
;     cmp cl, '+'                                                                 ; check if it's a plus sign
;     jne convert_to_int                                                          ; if not, proceed to conversion loop
;     inc esi                                                                     ; move to the next character

convert_to_int:
    mov cl, [esi]                                                               ; load the current character
    cmp cl, 10                                                                  ; check if it's a newline (end of input)
    je done                                                                     ; if newline, we're done
    sub cl, '0'                                                                 ; convert ASCII digit to integer
    imul eax, eax, 10                                                           ; multiply current result by 10
    add eax, ecx                                                                ; add the new digit
    inc esi                                                                     ; move to the next character
    jmp convert_to_int                                                            ; repeat the loop

done:
    imul eax, edi                                                               ; apply the sign

    ; Convert integer to string to print
    mov esi, int_str                                                            ; point to the start of the int_str buffer
    mov ecx, 10                                                                 ; divisor for modulus operation
    xor ebx, ebx                                                                ; clear ebx (will be used for remainder)
    test eax, eax                                                               ; check if eax is zero
    jns positive                                                                ; if positive, jump to positive

    ; Handle negative number
    neg eax                                                                     ; negate the number
    mov byte [esi], '-'                                                         ; store the negative sign
    inc esi                                                                     ; move to the next character
    jmp convert_to_string

positive:
    mov edi, esi                                                                ; save the current position in the buffer

convert_to_string:
    xor edx, edx                                                                ; clear edx (will be used for remainder)
    div ecx                                                                     ; divide eax by 10
    add dl, '0'                                                                 ; convert remainder to ASCII
    dec esi                                                                     ; move to the previous position
    mov [esi], dl                                                               ; store the ASCII character
    test eax, eax                                                               ; check if eax is zero
    jnz convert_to_string                                                       ; if not zero, repeat the loop

    ; add negative sign if necessary
    cmp edi, -1
    jne print_result
    dec esi
    mov byte [esi], '-'

print_result:
    ; Print the result
    mov eax, 4                                                                  ; sys_write
    mov ebx, 1                                                                  ; file descriptor (stdout)
    mov ecx, esi                                                                ; message to write (start of the integer string)
    mov edx, edi                                                                ; message length
    sub edx, esi                                                                ; calculate the length of the string
    int 0x80                                                                    ; call kernel

    ; Print newline
    mov eax, 4                                                                  ; sys_write
    mov ebx, 1                                                                  ; file descriptor (stdout)
    mov ecx, newline                                                            ; message to write
    mov edx, lenNewline                                                         ; message length
    int 0x80                                                                    ; call kernel

    ; Exit
    mov eax, 1                                                                  ; sys_exit
    xor ebx, ebx                                                                ; exit code 0
    int 0x80                                                                    ; call kernel