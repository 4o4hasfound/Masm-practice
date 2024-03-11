.386
.model flat, stdcall
.stack 4096

include irvine32.inc

.data
	k db -7
	len dd 0

.code
main PROC
	StartLoop:
		call ReadChar
		call WriteChar

		mov bl, 13
		cmp al, bl
		je EndLoop
		add al, k
		push eax
		inc len

		jmp StartLoop

	EndLoop:
		mov ecx, 0
		cmp ecx, len
		jge PrintLoopEnd

		PrintLoopStart:
			mov ebx, len
			sub ebx, 1
			sub ebx, ecx

			mov al, [esp + ebx * 4]
			call WriteChar
			inc ecx
			cmp ecx, len
			jl PrintLoopStart

		PrintLoopEnd:
			call CRLF
			call ExitProcess
main ENDP
END