.386
.model flat, stdcall
.stack 4096

include irvine32.inc

.data
	money dd 10000, 5000, 1000, 500, 100, 50, 10, 5, 1

.code
main PROC
	call ReadInt
	mov ebx, eax

	mov ecx, 0 ; answer
	mov esi, 0 ; i
	cmp ebx, 0
	jg LoopStart
	jmp LoopEnd

	LoopStart:
		mov eax, ebx
		mov edx, 0
		div money[esi * 4]
		add ecx, eax
		mov ebx, edx
		jmp NextLoop

	LoopEnd:
		mov eax, ecx
		call WriteInt
		call ExitProcess
	NextLoop:
		inc esi
		cmp ebx, 0
		jg LoopStart
		jmp LoopEnd


main ENDP
END