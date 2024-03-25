.386
.model flat, stdcall
.stack 4096

include irvine32.inc

.data
    TwoRootStr db "Two different roots", 0
    OneRootStr db "Two same roots", 0
    NoRootStr db "No real root", 0
    x1 db " x1=", 0
    x2 db " x2=", 0
    x db " x=", 0

    prefixA dd 0
    prefixB dd 0
    prefixC dd 0
    tmp dd 4
    discriminant dd 0

    answer real8 0.0

    float1 dd ?
    float2 dd ?


.code
main PROC
    ; Calculate the roots of the equation: ax^2 + bx + c = 0
    ; Where a = prefixA, b = prefixB, c = prefixC
    call ReadInt
    mov prefixA, eax
    call ReadInt
    mov prefixB, eax
    call ReadInt
    mov prefixC, eax
    
    mov eax, prefixB
    mul prefixB             ; b^2
    mov discriminant, eax
    mov eax, tmp
    mul prefixA             ; 4a
    mul prefixC             ; 4ac
    sub discriminant, eax   ; 4ac - b^2

    mov eax, discriminant

    cmp discriminant, 0
    jl NoRoot    ; 4ac - b^2 < 0
    je OneRoot   ; 4ac - b^2 == 0
    jg TwoRoot   ; 4ac - b^2 > 0

    NoRoot:
        mov edx, OFFSET NoRootStr
        call WriteString
        call ExitProcess

    OneRoot:
        mov edx, OFFSET OneRootStr
        call WriteString
        mov edx, OFFSET x
        call WriteString

        mov eax, prefixA
        mov ebx, 2
        mul ebx            ; 2a

        mov ebx, eax

        mov eax, prefixB   
        mov ecx, -1
        mul ecx            ; -b

        mov float1, eax
        mov float2, ebx

        finit 
        fild DWORD PTR float1
        fild DWORD PTR float2
        fdiv    ; -b / 2a
        call WriteFloat
        
        call ExitProcess

    TwoRoot:
        mov edx, OFFSET TwoRootStr
        call WriteString
        mov edx, OFFSET x1
        call WriteString

        mov eax, prefixB
        mov ecx, -1
        mul ecx        ; -b
        mov ecx, eax

        mov ebx, discriminant
        mov float1, ebx        ; D
        mov float2, ecx        ; -b

        finit 
        fild DWORD PTR float1  ; sqrt(D)
        fsqrt

        fist discriminant

        fiadd float2        ; -b + sqrt(D)
        
        mov eax, prefixA
        mov ebx, 2
        mul ebx
        mov float2, eax

        fidiv float2        ; (-b + sqrt(D)) / 2a
        call WriteFloat

        mov edx, OFFSET x2
        call WriteString

        fstp st(0)
        fild discriminant ; sqrt(D)
        mov float1, -1
        fimul float1
        
        mov float2, ecx
        fiadd float2        ; (-b - sqrt(D)) / 2a
        
        mov eax, prefixA
        mov ebx, 2
        mul ebx
        mov float2, eax
        
        fidiv float2
        call WriteFloat

        call ExitProcess


main ENDP
END
