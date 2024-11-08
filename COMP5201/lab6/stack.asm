section .data
    result_msg db "Result: %d", 0       ; message to be printed
    result db 0                         ; buffer to hold the result as a string
    result_len equ 14                   ; length of the message and result string

section .text
    global _start

_start:
    mov eax, 5                          ; first argument
    push eax                            ; push 5 onto the stack

    mov eax, 10                         ; second argument
    push eax                            ; push 10 onto the stack

    call add_numbers                    ; call function

    add esp, 8                          ; clean up the stack (remove arguments)

    ; EAX now contains the result (15)
    ; convert EAX to string in result
    mov ecx, result                     ; pointer to result buffer
    mov ebx, 10                         ; base 10 for conversion
    call int_to_string                  ; convert integer to string

    ; print result message
    mov eax, 4                          ; sys_write
    mov ebx, 1                          ; stdout
    mov ecx, result_msg                 ; pointer to the message
    mov edx, 9                          ; length of the message. could use the result_msg_len
    int 0x80                            ; call kernel to write

    ; print the result
    mov eax, 4                          ; sys_write
    mov ebx, 1                          ; stdout
    mov ecx, result                     ; pointer to result string
    mov edx, 10                         ; length of result string (adjust as needed)
    int 0x80                            ; call kernel to write

    ; exit
    mov eax, 1                          ; exit system call
    int 0x80

add_numbers:
    ; stack layout:
    ; [esp+4] - First argument (5)
    ; [esp] - Second argument (10)

    mov eax, [esp+4]                    ; load first argument into EAX
    mov ebx, [esp]                      ; load second argument into ebx
    add eax, ebx                        ; EAX = EAX + EBX (5 + 10 = 15)

int_to_string:
    xor edx, edx                        ; clear EDX (will hold the length of the string)
    mov ebx, 10                         ; base 10

.convert_loop:
    xor edx, edx                        ; clear EDX before dividing
    div ebx                             ; divide EAX by 10, result in EAX, remainder in edx
    add dl, '0'                         ; convert remainder to ASCII
    dec ecx                             ; move pointer backwards
    mov [ecx], dl                       ; store ASCII character
    inc edx                             ; incremenet digit count
    test eax, eax                       ; check if EAX is zero
    jnz .convert_loop                   ; if not, repeat
    ret                                 ; return to caller