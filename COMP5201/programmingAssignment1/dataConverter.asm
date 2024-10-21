section .data ; initialized data segment
	firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $-firstPrompt    ; length of firstPrompt

	outMsg1 db "The number entered is: ", 0xA, 0
    lenOutMsg1 equ $-outMsg1            ; length of outMsg1

    outMsgDiv db "Half of the entered number is: ", 0xA, 0
    lenOutMsgDiv equ $-outMsgDiv

    extraOutMsg db "The converted string is: ", 0xA, 0
    lenOutMsg2 equ $-extraOutMsg        ; length of outMsg2

    newline db 0xA, 0
    lenNewline equ $-newline

section .bss ; unintialized data segment
	userInput resb 6                    ; 6 bytes to hold the (ASCII string) plus newline
    userInputLength resd 1              ; 2 bytes for the length

    userInputInteger resd 1             ; hold the converted value as signed integer (1 double word, 32-bits)
    userInputIntegerLength resd 1       ; 2 bytes for the length
    sign resb 1                         ; reserve 1 byte for the sign

    userInputIntDivision resb 6         ; reserve 6 bytes, same as user input

section .text
	global _start

_start:
    ; print "Enter an integer..." to user
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; stdout, default output device 
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt             ; length of firstPrompt
    int 0x80

    ; read user input
    mov eax, 3                          ; syscall number for sys_read
    mov ebx, 0                          ; stdin, default input device
    lea ecx, userInput                  ; load address of the buffer
    mov edx, 6                          ; bytes to read (sign + 4 chars)
    int 0x80

    mov [userInputLength], eax          ; store the number of bytes read
    cmp dword [userInputLength], 0
    je end
    dec dword [userInputLength]         ; subtract 1 to exclude newline


    ; convert string input to integer value
    mov esi, userInput
    mov ecx, [userInputLength]          ; initialize the loop counter
    mov edx, 0                          ; edx will be used as index counter
    mov eax, 0                          ; eax will accumulate final integer
    mov byte [sign], 0                  ; initialize sign to be positive

    ; handle negative sign & decrement length
    cmp byte [esi], '-'                 ; check value of first byte with '-'
    jne first_digit                     ; if not negative jump
    mov byte [sign], 1                  ; otherwise, change value of sign variable

    ; If number is negative, get and convert first digit *before* loop and increment index
    mov bl, byte [esi + edx]            ; Retrieve first digit before incrementing index
    sub bl, '0'
    movzx eax, bl
    inc edx                             ; skip '-' if integer is negative

; get the first digit
first_digit:
    mov bl, [esi + edx]                 ; get d3
    sub bl, '0'                         ; d3 - 48
    movzx eax, bl                       

conversion_loop:                        ; (i = 2 to 0 in the formula)
    inc edx
    cmp edx, ecx                          ; Has the first digit been accounted for yet?
    jge apply_sign                      ; If just first digit, apply the sign, else convert

    mov bl, [esi + edx]                 ; Get di
    sub bl, '0'                         ; di - 48
    imul eax, eax, 10                   ; value = value * 10
    add eax, ebx                        ; value = value + (di - 48)
    jmp conversion_loop                 ; Automatically decrements ecx and jumps if ecx > 0

apply_sign:
    cmp byte [sign], 1
    jne store_int
    neg eax

store_int:
    mov ebx, eax                        ; store in ebx
    mov [userInputInteger], eax         ; store in memory
    sar eax, 1                          ; divide eax by 2 (shift arithmetic right)

    ; convert halved integer to string
    mov edi, userInputIntDivision
    mov byte [edi], 0

    cmp eax, 0                          ; if negative, store sign and negate
    jge div_convert
    mov byte [userInputIntDivision], '-'
    neg eax

div_convert:                            ; do-while loop to convert
    mov edx, 0
    mov ebx, 10
    div ebx                             ; eax = quotient, edx = remainder
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz div_convert

continue:
    ; print "The number entered is: "
    mov eax, 4                          ; sys_write
    mov ebx, 1                          ; stdout
    mov ecx, outMsg1                    ; address of of outMsg1
    mov edx, lenOutMsg1                 ; length of outMsg1
    int 0x80

    ; print the user-entered input (4-digit signed integer)
    mov eax, 4                          ; sys_write
    mov ebx, 1                          ; stdout
    lea ecx, userInput                  ; address of the buffer
    mov edx, [userInputLength]          ; bytes to write (up to userInputLength)
    int 0x80

    ; Print newline after the output
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 0x80

    ; print "Half the entered..."
    mov eax, 4                          ; sys_write
    mov ebx, 1                          ; stdout
    mov ecx, outMsgDiv                  ; address of of outMsgDiv
    mov edx, lenOutMsgDiv               ; length of outMsgDiv
    int 0x80

    ; print halved signed integer
    mov eax, 4
    mov ebx, 1
    mov ecx, edi                    
    mov edx, userInputIntDivision    
    sub edx, edi                     ; Calculate the actual length of the string
    int 0x80

    ; Print newline after the output
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 0x80


end:
    ; program exit
    mov eax, 1                          ; syscall number for exit
    mov ebx, 0                          ; exit status
    int 0x80
