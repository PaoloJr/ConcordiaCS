global _add_numbers             ; declare function to be exported

section .text

_add_numbers:
    ; parameters passed through the stack
    ; first parameter is at [esp + 4] and second at [esp + 8]
    mov eax, [esp + 4]          ; move first argumaent into eax
    mov eax, [esp + 8]          ; add second argument to eax
    ret                         ; return result in eax