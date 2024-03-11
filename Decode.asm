; This is the solution to this zerojudge: https://zerojudge.tw/ShowProblem?problemid=a009
;	在密碼學裡面有一種很簡單的加密方式，就是把明碼的每個字元加上某一個整數K而得到密碼的字元（明碼及密碼字元一定都在ASCII碼中可列印的範圍內）。
;	例如若K=2，那麼apple經過加密後就變成crrng了。解密則是反過來做。這個問題是給你一個密碼字串，請你依照上述的解密方式輸出明碼。
; 	(k == -7)



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
