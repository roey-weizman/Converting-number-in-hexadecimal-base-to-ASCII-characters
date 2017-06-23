%define newline 10

section	.rodata
LC0:
	DB	"%s", 10, 0	; Format string

section .bss
LC1:
	RESB	256

section .text
	align 16
	global my_func
	extern printf

my_func:
	push	ebp
	mov	ebp, esp	; Entry code - set up ebp and esp
	pushad			; Save registers
	mov ecx, dword [ebp+8]	; Get argument (pointer to string)	
	mov esi,0
	mov ebx,0
	mov eax,0
	mov edx,0
	mov esi,LC1
.loop:
		cmp byte [ecx],10
		jz .continue
		mov bl,[ecx]
		sub bl, 48
		mov al,16
		mul bl
		inc ecx
		mov dl,[ecx]
		cmp dl,'9'
		jle  .SecNum
		cmp dl,'Z'
		jle .UpperCase
		jmp .LowerCase
		
.SecNum:
		sub dl,48
		add al,dl
		mov [esi],al
		inc ecx
		inc esi
		jmp .loop
.UpperCase:
		sub dl,55
		add al,dl
		mov [esi],al
		inc ecx
		inc esi
		jmp .loop
.LowerCase:
		sub dl,87
		add al,dl
		mov [esi],al
		inc ecx
		inc esi
		jmp .loop


.continue:
	mov bl,0
	mov ax,0	
	
	push	LC1		; Cnall printf with 2 arguments: pointer to str
	push	LC0		; and pointer to format string.
		call	printf
	add 	esp, 8		; Clean up stack after call

	popad			; Restore registers
	mov	esp, ebp	; Function exit code
	pop	ebp
	ret

