global taylor

section .text

; Function prototype:
; double taylor(double x, unsigned long int n)
; Inputs:
;   x in xmm0 (double)
;   n in rdi (unsigned long int)
; Output:
;   Result in xmm0 (double)

taylor:
    ; Back up callee-saved registers
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15

    ; Initialize variables
    mov rbx, rdi          ; rbx = n (number of terms)
    mov r12, 1            ; r12 = factorial accumulator, initially 1
    xor r13, r13          ; r13 = k (current term index), initially 0
    movsd xmm1, xmm0      ; xmm1 = x (base value for terms)
    movsd xmm2, xmm0      ; xmm2 = x^k, initially x^0 = 1.0
    movsd xmm3, qword [taylor_one] ; xmm3 = result accumulator, initially 1.0

taylor_loop:
    ; Break if k > n (all terms computed)
    cmp r13, rbx
    jg taylor_done

    ; Compute current term: xmm4 = x^k / k!
    movsd xmm4, xmm2      ; xmm4 = x^k
    divsd xmm4, qword [r12] ; xmm4 = x^k / k!
    addsd xmm3, xmm4      ; result += x^k / k!

    ; Increment k (r13) and compute the next term
    inc r13               ; k++
    mulsd xmm2, xmm1      ; xmm2 *= x (next x^k)
    imul r12, r13         ; r12 *= k (next factorial)

    ; Loop back for next term
    jmp taylor_loop

taylor_done:
    ; Return result in xmm0
    movsd xmm0, xmm3

    ; Restore callee-saved registers
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

section .data
taylor_one dq 1.0  ; Constant value 1.0 for initializing result
