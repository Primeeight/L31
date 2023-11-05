extern  printf

 section .text           ; Code section.
        global main     ; the standard gcc entry point
main:
        ;save registers.
        push rdi
        push rsi
        sub rsp, 8      ;align stack.                         
	mov rsi, [rsi]  ;argument to be printed.
        mov rdi, pfmt   ;format
	jmp setup_registers
print:
	sub rbx, 2
        mov rsi, [rbx]
	xor eax, eax
        cmp [count], eax
        je restore

        call printf
restore:
        add rsp, 8      ;restore to prealigned value.
        inc qword [count]
        pop rsi
        pop rdi
	jmp loop

setup_registers:
	mov rax, rsi
	mov rbx, rax
find_last:
	cmp byte [rbx], 0
	jz swap
	inc rbx
	jmp find_last
swap:
	cmp rax, rbx
	jg print
	mov cl, [rax]
	mov ch, [rbx]
        mov [rbx], cl ;why does this move the value of cl and the next address into rbx? value of cl is 116-assci of first char.
        mov [rax], ch ;value of ch is 0, ascci of eof 
        inc rax
        dec rbx
        jmp swap        	


loop:
        add rsi, 8 ;loop between all arguments, including the program name.
        dec rdi         ;good way to keep track of loop.
        jnz main

        ;return
        mov eax, 1
        mov ebx, 0
        int 80h

section .data
pfmt db "the parameter is %s",10, 0     ;format for printing.
count dw 0              ;For keeping count of arguments
