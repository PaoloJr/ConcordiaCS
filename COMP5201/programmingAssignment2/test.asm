section .data
    ; Initialized data segment
    firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $ - firstPrompt    ; length of firstPrompt

    outMsg db "The number entered is: ", 0xA, 0
    lenOutMsg equ $ - outMsg             ; length of outMsg

    newline db 0xA, 0
    lenNewline equ $ - newline

section .bss
    ; Uninitialized data segment
    strIn resb 6         ; 6 bytes to hold sign + 4 digits + newline
    strInLen resb 1      ; 1 byte to hold the length

    intOut resd 1        ; 4 bytes to hold the converted integer
    strOut resb 6        ; 6 bytes to hold the converted string

section .text
    global _start

_start:
    ; Print the first prompt
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt
    call print

    ; Read the signed integer and store it in intOut
    call iread

    ; Display "The number entered is: "
    mov ecx, outMsg
    mov edx, lenOutMsg
    call print

    ; Load the integer value into eax
    mov eax, [intOut]

    ; Convert the integer to string and print it
    call iprint

    ; Print newline
    call prln

    ; Exit the program
    call end

;----------------------------------------
; Subroutine: print
; Prints the string pointed to by ECX of length EDX
;----------------------------------------
print:
    mov eax, 4            ; sys_write
    mov ebx, 1            ; stdout
    int 0x80
    ret

;----------------------------------------
; Subroutine: iread
; Reads a string from stdin, converts it to an integer, and stores it in [intOut]
;----------------------------------------
iread:
    ; Read user input
    mov eax, 3            ; sys_read
    mov ebx, 0            ; stdin
    mov ecx, strIn        ; buffer to store input
    mov edx, 6            ; max bytes to read
    int 0x80
    mov [strInLen], al    ; Store the number of bytes read

    ; ASCII to integer conversion
    mov esi, strIn        ; Pointer to input buffer
    xor eax, eax          ; Clear EAX (accumulator)
    mov edi, 1            ; Sign flag (1 for positive)

    ; Check for sign
    mov bl, [esi]         ; Load first character
    cmp bl, '-'           
    jne check_plus
    mov edi, -1           ; Set sign to negative
    inc esi               ; Move to next character
    jmp convert_loop

check_plus:
    cmp bl, '+'           
    jne convert_loop
    inc esi               ; Move to next character

convert_loop:
    mov bl, [esi]         ; Load current character
    cmp bl, 10            ; Newline character?
    je conversion_done
    sub bl, '0'           ; Convert ASCII to integer
    imul eax, eax, 10     ; Multiply current result by 10
    add eax, ebx          ; Add new digit
    inc esi               ; Move to next character
    jmp convert_loop

conversion_done:
    imul eax, edi         ; Apply sign
    mov [intOut], eax     ; Store the result
    ret

;----------------------------------------
; Subroutine: iprint
; Converts the integer in EAX to a string and prints it
;----------------------------------------
iprint:
    ; Save registers that we'll modify
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov ebx, eax          ; Move integer to EBX
    mov esi, strOut + 5   ; Point ESI to the end of strOut buffer
    mov ecx, 10           ; Divisor for modulus

    ; Handle zero case
    cmp ebx, 0
    jne convert_number
    mov byte [esi], '0'
    dec esi
    jmp finish_conversion

convert_number:
    ; Handle negative numbers
    test ebx, ebx
    jge positive_number
    neg ebx               ; Make EBX positive
    mov edi, 1            ; Negative flag
    jmp conversion_loop

positive_number:
    mov edi, 0            ; Positive flag

conversion_loop:
    xor edx, edx          ; Clear EDX
    mov eax, ebx          ; Move EBX to EAX for division
    div ecx               ; Divide EAX by 10
    add edx, '0'          ; Convert remainder to ASCII
    dec esi
    mov [esi], dl         ; Store character
    mov ebx, eax          ; Update EBX with quotient
    cmp ebx, 0
    jne conversion_loop

finish_conversion:
    ; Add negative sign if necessary
    cmp edi, 1
    jne prepare_print
    dec esi
    mov byte [esi], '-'

prepare_print:
    ; Calculate length of the string
    mov edx, strOut + 5
    sub edx, esi          ; edx = length of the string

    ; Print the string
    mov eax, 4            ; sys_write
    mov ebx, 1            ; stdout
    mov ecx, esi          ; Pointer to the start of the string
    int 0x80

    ; Restore registers
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

;----------------------------------------
; Subroutine: prln
; Prints a newline character
;----------------------------------------
prln:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 0x80
    ret

;----------------------------------------
; Subroutine: end
; Exits the program
;----------------------------------------
end:
    mov eax, 1            ; sys_exit
    xor ebx, ebx          ; Exit status 0
    int 0x80
