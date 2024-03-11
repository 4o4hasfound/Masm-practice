.386
.model flat, stdcall
.stack 4096

include irvine32.inc

.data
	list dd 1, 3, 4, 6, 77, 86, 87, 88, 98, 107, 108, 1234
	target dd ?
	found db "Target found in index: ", 0
	notfound db "Target not found", 0
	
.code
main PROC
	call ReadInt
	mov target, eax

	mov eax, 0
	mov ebx, LENGTHOF list - 1
	
	cmp eax, ebx
	je BSearchEnd
	jmp BSearch
	BSearch:
		mov ecx, eax
		add ecx, ebx
		shr ecx, 1
		mov edx, list[ecx * 4]

		cmp target, edx
		
		jg Greater
		jl Less
		je Equal
		
		Greater:
			mov eax, ecx
			jmp NextLoop
		Less:
			mov esi, ecx
			sub esi, 1
			mov ebx, esi
			jmp NextLoop
		Equal:
			mov edx, OFFSET found
			call WriteString
			mov eax, ecx
			call WriteInt
			call ExitProcess
		NextLoop:
			cmp eax, ebx
			je BSearchEnd
			jmp BSearch
	BSearchEnd:
		mov edx, OFFSET notfound
		call WriteString
		call ExitProcess

main ENDP
END