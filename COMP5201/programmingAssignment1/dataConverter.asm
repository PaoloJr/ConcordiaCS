section .data ; initialized data segment
	firstPrompt db "Enter an integer (+/-) up to four digits long: ", 0xA, 0
    lenFirstPrompt equ $-firstPrompt ; length of firstPrompt
	outMsg1 db "The number entered is: ", 0xA, 0
    lenOutMsg1 equ $-outMsg1 ; length of outMsg1
    outMsg2 db "The converted string is: %d", 0xA, 0

section .bss ; unintialized data segment
	userInput resd 1 ; to hold the (ASCII string)  value entered, 1 double word, 4 bytes
    userInputLength equ $-userInput
    userInputInteger resd 1 ; hold the converted value as signed integer
    userInputIntegerLength equ $-userInputInteger
    sign resb 1 ; reserve 1 byte for the sign

section .text
	global main
    extern printf

main:
    ; print prompt to user
    mov eax, 4                 ; syscall number for sys_write
    mov ebx, 1                 ; stdout, default output device 
    mov ecx, firstPrompt
    mov edx, lenFirstPrompt    ; length of firstPrompt
    int 0x80

    ; read user input
    mov eax, 3                 ; syscall number for sys_read
    mov ebx, 0                 ; stdin, default input device
    lea ecx, [userInput]       ; load address of the buffer
    mov edx, 6                 ; max number of bytes to read
    int 0x80


    ; print output message
    mov eax, 4                 ; sys_write
    mov ebx, 1                 ; stdout
    mov ecx, outMsg1           ; address of of outMsg1
    mov edx, lenOutMsg1        ; length of outMsg1
    int 0x80


    ; print the user-entered input
    mov eax, 4                 ; sys_write
    mov ebx, 1                 ; stdout
    lea ecx, [userInput]       ; address of the buffer
    mov edx, 6                 ; bytes to write (5 chars + newline)
    int 0x80


    ; Initialize variables for the loop
    mov esi, userInput   ; Point `esi` to the start of userInput
    mov eax, 0           ; Clear `eax` for calculations (accumulator)
    mov ebx, 0           ; Clear `ebx` as well to store the result
    mov byte [sign], 0   ; Assume input is positive by default

    ; Check for negative sign at the start of the string
    mov al, [esi]        ; Load the first byte of the input
    cmp al, '-'          ; Compare to '-'
    jne start_conversion ; If not '-', jump to start of conversion
    mov byte [sign], 1   ; Set sign flag to indicate negative
    inc esi              ; Move the pointer to skip the '-' sign

start_conversion:
    ; Begin conversion using the logic provided in the question
    mov ecx, 0           ; Initialize index `i` to start processing
    mov edx, 0           ; Initialize `edx` to hold the converted value

process_digits:
    mov al, [esi + ecx]  ; Load the current character from the string
    cmp al, 0x0A         ; Check if it's a newline or end-of-input
    je end_conversion    ; If it is, stop processing

    cmp al, 0            ; Check if it's a null character
    je end_conversion    ; If so, stop processing

    sub al, 48           ; Convert ASCII to integer by subtracting '0'
    imul edx, edx, 10    ; Multiply `edx` by 10 for positional value
    add edx, eax         ; Add the new digit value to `edx`
    inc ecx              ; Move to the next character
    jmp process_digits   ; Continue processing

end_conversion:
    ; Handle if it's a negative input
    cmp byte [sign], 1   ; Check if the sign is set
    jne store_result     ; If not, skip the negation
    neg edx              ; Negate the value in `edx` if it's negative

store_result:
    mov eax, edx         ; Copy the result to `eax`
    mov ebx, eax         ; Store the result in `ebx` as well

    ; Push values to printf, assuming `outMsg2` exists for printing format:
    push dword eax       ; Push the final integer value
    push outMsg2         ; Push the message format string
    call printf          ; Call printf to print the result
    add esp, 8           ; Clean up the stack


    ; program exit
    mov eax, 1                 ; syscall number for exit
    mov ebx, 0                 ; exit status
    int 0x80
