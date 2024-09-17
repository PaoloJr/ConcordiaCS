; ------------------------------------------------------------------
; helloworld.asm
;
; This is a Win64 console program that writes "Hello World"
; on a single line and then exits.
;
; To assemble to .obj: nasm -f win64 helloworld.asm -o helloworld.obj
; To compile to .exe:  zig cc helloworld.obj -o helloworld.exe -lkernel32 -lmsvcrt
; ------------------------------------------------------------------

        global    main                ; declare main() method
        extern    printf              ; link to external library

        section  .data
message: db   'Hello world', 0xA, 0  ; text message
                    ; 0xA (10) is hex for (NL), carriage return
                    ; 0 terminates the line

        section .text
main:                            ; the entry point! void main()
        sub     rsp, 28h         ; allocate stack space
        lea     rcx, [message]   ; load address of message into rcx
        call    printf           ; call printf
        add     rsp, 28h         ; deallocate stack space
        ret                      ; return