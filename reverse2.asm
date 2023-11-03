	extern puts
	section .text
	global main
main:
	push rbp
	mov rbp, rsp	;save point on stack.
	mov rax, rsi	;store the address of the string in rax.
setup_registers:
	mov rbx, rax	;setup the registers for the swap.
	jmp print
last_char:
	cmp byte [rbx], 0	;if rbx is 0, the last char has been found.
	jz midpoint		
	inc rbx		;increment until the last char is found.
	jmp last_char	;loop
midpoint:	
	jmp swap
swap:
	cmp rax, rbx	;if rax is greater than rbx, swap is complete.
	jg print
	mov cl, [rax]	;perform the swap of chars.
	mov ch, [rbx]
	mov [rbx], cl    
        mov [rax], ch
	inc rax	
	dec rbx
	jmp swap	;loop
	
print:
	;sub rbx, 2
        mov rdi, [rsi]
        call puts

end:       
        pop rbp 	;restore stack         
        ret 		;return

section .data
	msg db "testword",0 	;string to be reversed.

