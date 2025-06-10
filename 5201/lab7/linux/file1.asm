section .text
	global add_numbers			; make add_numbers function accessible to other files

add_numbers:
	; arguments passed in rdi and rsi (according to System V ABI on Linux
	; rdi = first number, rsi = second number
	mov rax, rdi				; move first number into rax
	add rax, rsi				; add second number to rax
	ret							; return result in rax
