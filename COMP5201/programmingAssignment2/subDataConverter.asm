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
	
    strIn resb 6                              ; 6 bytes to hold sign + 4-digits + newline
    strInLen resb 6                           ; 6 bytes for the length

    intOut resd 1                             ; hold the converted value as signed integer (1 double word, 32-bits)
    strOut resb 6                             ; 6 bytes to hold the returned ASCII string and newline


section .text
	global _start


_start:

while:
    ; call print with the first prompt
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt
    call print

    ; read the signed integer and returns the binary integer (store in intOut)
    call iread

    ; Check if the input is empty (only Enter pressed)
    cmp byte [strInLen], 1         ; Check if the length of input is 1 (newline only)
    je endwhile                    ; If yes, jump to endwhile to exit the loop

    ; display second prompt "The number entered is: "
    mov ecx, outMsg
    mov edx, lenOutMsg
    call print

    ; Load the integer value into eax
    mov eax, [intOut]

    ; print the integer after converting to string
    call iprint

    ; clear strOut before next iteration
    mov byte [strOut], 0
    mov byte [strOut + 1], 0
    mov byte [strOut + 2], 0
    mov byte [strOut + 3], 0
    mov byte [strOut + 4], 0
    mov byte [strOut + 5], 0

    ; print newline
    call prln
    call prln
    call prln

    ; repeat the loop
    jmp while

endwhile:
    ; program exit
    call end

;----------------------------------------
; Subroutine: print
; Prints the string pointed to by ECX of length EDX
; ECX and EDX are setup before calling print
;----------------------------------------
print:
    mov eax, 4                                ; syscall number for sys_write
    mov ebx, 1                                ; stdout, default output device 
    int 0x80
    ret

;----------------------------------------
; Subroutine: iread
; Reads a string from stdin, converts it to an integer, and stores it in [intOut]
;----------------------------------------
iread:
    ; read user input
    mov eax, 3                                ; syscall number for sys_read
    mov ebx, 0                                ; stdin, default input device
    mov ecx, strIn                            ; load address of the buffer
    mov edx, 6                                ; bytes to read (sign + 4 chars)
    int 0x80
    mov [strInLen], eax
    ; ASCII to integer conversion, store result in intOut
    mov esi, strIn
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    mov edi, 1

    mov cl, [esi]
    cmp cl, '-'
    jne convert_to_int
    mov edi, -1
    inc esi
    jmp convert_to_int

convert_to_int:
    mov cl, [esi]
    cmp cl, 10
    je done
    sub cl, '0'
    imul eax, eax, 10
    add eax, ecx
    inc esi
    jmp convert_to_int

done:
    imul eax, edi
    mov [intOut], eax
    ret

;----------------------------------------
; Subroutine: iprint
; Converts the integer in EAX to a string and prints it
;----------------------------------------
iprint:
    mov ebx, eax          ; Move integer to EBX
    mov esi, strOut + 5   ; Point ESI to the end of strOut buffer
    mov ecx, 10           ; Divisor for modulus
    xor edi, edi          ; clear EDI (negative flag)  

    ; Handle zero case
    cmp ebx, 0
    jne convert_number
    mov byte [esi], '0'
    dec esi
    jmp finish_conversion

convert_number:
    ; Handle negative numbers
    test ebx, ebx
    jge convert_to_string
    neg ebx               ; Make EBX positive
    mov edi, 1            ; Negative flag
    jmp convert_to_string

positive_number:
    mov edi, 0            ; Positive flag

convert_to_string:
    xor edx, edx          ; Clear EDX
    mov eax, ebx          ; Move EBX to EAX for division
    div ecx               ; Divide EAX by 10
    add dl, '0'          ; Convert remainder to ASCII
    dec esi
    mov [esi], dl         ; Store character
    mov ebx, eax          ; Update EBX with quotient
    cmp ebx, 0
    jne convert_to_string

finish_conversion:
    ; Add negative sign if necessary
    cmp edi, 1
    jne prepare_print
    dec esi
    mov byte [esi], '-'

prepare_print:
    ; Calculate length of the string
    mov edx, strOut + 6   ; End of strOut buffer (since buffer is 6 bytes)
    sub edx, esi          ; EDX = length of the string from ESI to end

    mov ecx, esi          ; Pointer to the start of the string

    call print

    ret


;----------------------------------------
; Subroutine: prln
; Prints a newline character
;----------------------------------------
prln:
    ; Print newline after the output
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
    mov eax, 1                                ; syscall number for exit
    mov ebx, 0                                ; exit status
    int 0x80