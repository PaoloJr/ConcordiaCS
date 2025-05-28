; ------------------------------------------------------------------
; helloworld.asm
;
; This is a Win64 console program that writes "Hello World"
; on a single line and then exits.
;
; To assemble to .obj: nasm -f win64 helloworld.asm
; To compile to .exe:  gcc helloworld.obj -o helloworld.exe
; ------------------------------------------------------------------

        global    main                ; declare main() method
        extern    printf              ; link to printf

        section  .data
                msg:    db 'Hello World', 0           ; null-terminated string

        ;section  .text

main:
        sub     rsp, 28h              ; allocate stack space
        lea     rcx, [msg]            ; load address of msg into rcx
        call    printf                ; call printf
        add     rsp, 28h              ; deallocate stack space
        ret                           ; return