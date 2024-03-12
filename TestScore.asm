; This is the solution to this zerojudge
; Which is the first question of APCS: https://zerojudge.tw/ShowProblem?problemid=j605
;	�� n �Ӵ�������A�� i �Ӵ����������Ӿ�� t �M i �N��W�Ǯɶ��M�Ӧ��W�Ǫ�����
;   �Y�� i �������浲�G���Y�����~�A�h s �� -1
;   �p���`���������� ������������̰��� - �`���榸�� - �`�Y�����~���� * 2
;   �Y�p��X�Ӫ����Ƭ��t�ƫh�p�� 0
;   �п�X�`���M�Ĥ@����o�̰������ɶ��I�C


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