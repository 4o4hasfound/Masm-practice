; Input the number to be find
; the program will then print "Target found in index: " following the found number's index
; if the number is not found, the prorgam will print "Target not found"

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
	mov target, eax ; Read the number into target

	mov eax, 0 ; Left pointer
	mov ebx, LENGTHOF list - 1 ; Right pointer
	
	cmp eax, ebx ; Leave the loop if lpointer = rpointer
	je BSearchEnd
	jmp BSearch
	BSearch:
		mov ecx, eax
		add ecx, ebx
		shr ecx, 1 ; ecx = eax + ebx >> 1
		mov edx, list[ecx * 4] ; move the current number to compare into edx

		cmp target, edx
		
		jg Greater
		jl Less
		je Equal
		
		Greater: ; target is greater than the current number
			mov eax, ecx ; move the ecx(middle pointer) to the left pointer
			jmp NextLoop
		Less: ; target is less than the current number
			mov esi, ecx
			sub esi, 1
			mov ebx, esi ; move the esi(middle pointer - 1) to the right pointer
			jmp NextLoop
		Equal: ; target is found
			mov edx, OFFSET found
			call WriteString
			mov eax, ecx
			call WriteInt
			call ExitProcess
		NextLoop:
			cmp eax, ebx
			je BSearchEnd
			jmp BSearch
	BSearchEnd: ; target not found
		mov edx, OFFSET notfound
		call WriteString
		call ExitProcess

main ENDP
END
