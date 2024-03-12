; This is the solution to this zerojudge
; Which is the first question of APCS: https://zerojudge.tw/ShowProblem?problemid=j605
;	給 n 個提交紀錄，第 i 個提交紀錄有兩個整數 t 和 i 代表上傳時間和該次上傳的分數
;   若第 i 次的提交結果為嚴重錯誤，則 s 為 -1
;   計算總分的公式為 提交紀錄中的最高分 - 總提交次數 - 總嚴重錯誤次數 * 2
;   若計算出來的分數為負數則計為 0
;   請輸出總分和第一次獲得最高分的時間點。


.386
.model flat, stdcall
.stack 4096

include irvine32.inc

.data?
    k dd ?
    
.data
    time dd 6 dup(?)
    score dd 6 dup(?)

    maxScore dd -2
    maxScoreTime dd 0
    fatalTimes dd 0


.code
LoadList PROC
    mov ecx, 0
    cmp ecx, k
    jge LoadEnd

LoadStart:
    call ReadInt
    mov [time + ecx * 4], eax
    call ReadInt
    mov [score + ecx * 4], eax

    add ecx, 1
    cmp ecx, k
    jl LoadStart
LoadEnd:
    ret
LoadList ENDP

main PROC
    call ReadInt
    mov k, eax
    call LoadList

    mov ecx, 0
    cmp ecx, k
    jge LoopEnd
LoopStart:
    cmp [score + ecx * 4], -1
    je Fatal
    jmp NotFatal
Fatal:
    inc fatalTimes
NotFatal:
    mov ebx, [score + ecx * 4]
    cmp ebx, maxScore
    jg Greater
    jmp Less
Greater:
    mov ebx, [score + ecx * 4]
    mov maxScore, ebx
    mov ebx, [time + ecx * 4]
    mov maxScoreTime, ebx
Less:
    inc ecx
    cmp ecx, k
    jl LoopStart
LoopEnd:
    mov eax, maxScore
    sub eax, k
    sub eax, fatalTimes
    sub eax, fatalTimes

    cmp eax, 0
    jge NotLessThanZero
LessThanZero:
    mov eax, 0
NotLessThanZero:
    call WriteInt
    call CRLF
    mov eax, maxScoreTime
    call WriteInt
    call ExitProcess
main ENDP

END main