extern  printf

 section .text           ; Code section.
        global main     ; the standard gcc entry point
main:
        ;save registers.
        push rdi
        push rsi
        sub rsp, 8      ;align stack.
        mov rsi, [rsi]  ;1st argument to be printed.
        mov rbx, rsi	;save rsi argument for reversal
        mov rdi, pfmt   ;format
        jmp iprint	;print the 1st argument.
iprint:                 
        xor rax, rax
        cmp [count], rax	;ignore the program directory.
        je setup_registers
        call printf	;initial print
        mov rsi, rbx
setup_registers:
        mov rax, rsi
        mov rbx, rax
find_last:
	cmp byte [rbx], 0	;when rbx is 0, the last char has been found.
	jz midpoint
	inc rbx
	jmp find_last
midpoint:
	dec rbx		;one less then the null terminated char.
swap:
	cmp rax, rbx
        jg print	;if rax > rbx, finished.
        mov cl, [rax]
        mov ch, [rbx]
        mov [rax], ch
        mov [rbx], cl
        dec rbx
        inc rax
        jmp swap

print:
        xor rax, rax
        cmp [count], rax	;ignore the program directory.
        je restore		
        mov rdi, rfmt		;print the 1st arugment reversed.
        call printf
restore:
        add rsp, 8      ;restore to prealigned value.
        inc qword [count]
        pop rsi
        pop rdi
        jmp loop
loop:
        add rsi, 8 	;loop between all arguments, including the program name.
        dec rdi         ;good way to keep track of loop.
        jnz main

        ;return
        mov eax, 1
	mov ebx, 0
        int 80h

section .data
pfmt db "the parameter is %s",10, 0     ;format for printing.
rfmt db "the parameter reversed is %s",10, 0     ;format for printing reversed arguments.
count dw 0              ;count of command line arguments entered.
                                                                
