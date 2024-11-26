section .text
    global taylor

; double taylor(double x, unsigned long n)
taylor:
    ; Prologue
    push rbp
    mov rbp, rsp
    sub rsp, 32  ; Allocate stack space for local variables

    ; Initialize sum and term
    xorps xmm1, xmm1          ; xmm1 = sum = 0.0
    movsd xmm2, qword [rbp+16]; xmm2 = x
    mov rax, 1                ; rax = factorial = 1
    xor rcx, rcx              ; rcx = i = 0

.loop_start:
    cmp rcx, rdi              ; Compare i with n
    jge .loop_end             ; If i >= n, exit loop

    ; Calculate term: x^i / i!
    test rcx, rcx             ; Check if i == 0
    jz .first_term
    imul rax, rcx             ; factorial *= i
.first_term:
    mov rbx, rax              ; Copy factorial to rbx
    cvtsi2sd xmm3, rbx        ; xmm3 = (double)factorial

    mov rbx, rcx
    movsd xmm4, xmm2          ; xmm4 = x
    call pow                  ; xmm4 = x^i

    divsd xmm4, xmm3          ; xmm4 = term = x^i / i!
    addsd xmm1, xmm4          ; sum += term

    ; Debugging: Optional code to print intermediate values
    ; Print x^i (in xmm4), i! (in xmm3), and sum (in xmm1)

    inc rcx
    jmp .loop_start
.loop_end:
    movsd xmm0, xmm1          ; Return sum in xmm0

    ; Epilogue
    leave
    ret

; Power function (x^i)
pow:
    test rbx, rbx
    jz .pow_end               ; If exponent is 0, result is 1
    movsd xmm0, xmm4          ; xmm0 = base = x
.pow_loop:
    mulsd xmm0, xmm4          ; xmm0 *= base
    dec rbx
    jnz .pow_loop             ; Repeat until exponent reaches 0
.pow_end:
    ret
