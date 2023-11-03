section .text
global main
main:
        push rbp           ; prologue
        mov ebp, esp       
        mov esi, [esi]
	mov eax, esi   ; eax <- points to string
        mov edx, eax
look_for_last:
        mov ch, [edx]      ; put char from edx in ch
        inc edx
        test ch, ch        
        jnz look_for_last  ; if char != 0 loop
        sub edx, 2         ; found last
swap:                      ; eax = first, edx = last (characters in string)
        cmp eax, edx       
        jg end             ; if eax > edx reverse is done
        mov cl, [eax]      ; put char from eax in cl
        mov ch, [edx]      ; put char from edx in ch
        mov [edx], cl      ; put cl in edx
        mov [eax], ch      ; put ch in eax
        inc eax
        dec edx
        jmp swap            
end:
           ; move char pointer to eax (func return)
        pop rbp            ; epilogue
        ret
