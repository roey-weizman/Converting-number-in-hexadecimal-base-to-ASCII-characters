%define newline 10

section	.rodata

section .data
ERROR_format:
	db "x or k, or both are off range", newline, 0
number_format:
	db	"%d", 10, 0	; Format string

section .text
	align 16
	global calc_div
	extern printf
	extern check
calc_div:
	push	ebp
	mov	ebp, esp	; Entry code - set up ebp and esp
	pushad			; Save registers
	mov edx,0; clear edx
	mov esi, dword [ebp+8]; Get argument (pointer to string)	
	mov edx , dword [ebp+12]
	mov ecx,0
	mov eax,0
	push edx ; sec arg k
	push esi ; first arg x
	call check ; call c function with k,x
	add esp, 8 ;
	cmp eax,0 ; treating the result
	je .notLegal
	
	mov eax,0 ; initialize reg 

	mov cl,dl   ;number of shift-power
	cmp cl,1 
	je .Power1 
	sub cl,1    ; for getting the right power
	mov eax,2 ; base
	shl eax,cl ;power op, result in ax, shift on eax need a lot of place but nimber of shift must be small(cl)
.divOp:
	mov edx,0; clear register
	mov ebx,0; clear ebx for use 
	mov ebx,eax ;div op is happening between eax:edx/ebx
	mov eax,esi; 
	DIV ebx ; division op	
	
	push eax
	push number_format
	call	printf
	add 	esp, 8		; Clean up stack after call
	jmp .end;
.notLegal: 
	push ERROR_format 
	call printf
	add esp,4
	jmp .end
.Power1:
	mov al ,2
	jmp .divOp
.end:
	popad			; Restore registers
	mov	esp, ebp	; Function exit code
	pop	ebp
	ret
