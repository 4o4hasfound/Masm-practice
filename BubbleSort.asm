.386
.model flat, stdcall
.stack 4096

include irvine32.inc

.data
	list dd 50, 453, 534, 223, 1, 5, 23, 753, 4, 15, 43141, 123

.code
main PROC
	mov ebx, 0 ; i
	cmp ebx, LENGTHOF list
	jl LoopStart
	jge LoopEnd
	LoopStart:
		mov ecx, 0 ; j
		mov edx, LENGTHOF list - 1 ; j end
		sub edx, ebx
		cmp ecx, edx
		jl InnerLoopStart
		jge InnerLoopEnd

		InnerLoopStart:
			mov eax, list[ecx * 4 + 4]
			sub eax, list[ecx * 4]
			cmp eax, 0
			jg Swap
			jmp NextInnerLoop

			Swap:
				mov esi, list[ecx * 4 + 4]
				mov edi, list[ecx * 4]
				mov list[ecx * 4], esi
				mov list[ecx * 4 + 4], edi
				jmp NextInnerLoop

			NextInnerLoop:
				inc ecx
				cmp ecx, edx
				jl InnerLoopStart
				jge InnerLoopEnd

		InnerLoopEnd:
			nop

	NextLoop:
		inc ebx
		cmp ebx, LENGTHOF list
		jl LoopStart
		jge LoopEnd

	LoopEnd:
		mov ebx, 0
		cmp ebx, LENGTHOF list
		jl PrintLoopStart
		jge PrintLoopEnd

		PrintLoopStart:
			mov eax, list[ebx * 4]
			call WriteInt
			call CRLF
			
		NextPrintLoop:
			inc ebx
			cmp ebx, LENGTHOF list
			jl PrintLoopStart
			jge PrintLoopEnd

		PrintLoopEnd:
			call ExitProcess


main ENDP
END