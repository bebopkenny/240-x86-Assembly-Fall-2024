global taylor
section .text

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
    mov r13, rdi             ; r13 = n (number of terms)
    cvtsi2sd xmm15, r13      ; Convert n to double for debug if needed
    movsd xmm14, xmm0        ; xmm14 = x (input x)
    movsd xmm13, qword [one] ; xmm13 = e^x (initially 1.0)
    movsd xmm12, qword [one] ; xmm12 = prev_term (initially 1.0)
    mov r12, 1               ; r12 = k (loop counter), starting at 1

taylor_loop:
    ; Break if k >= n
    cmp r12, r13
    jge taylor_done

    ; Compute current term: current_term = prev_term * x / k
    movsd xmm0, xmm12        ; xmm0 = prev_term
    mulsd xmm0, xmm14        ; xmm0 *= x
    cvtsi2sd xmm1, r12       ; Convert k to double
    divsd xmm0, xmm1         ; xmm0 /= k
    movsd xmm12, xmm0        ; Update prev_term = current_term

    ; Add current term to sum
    addsd xmm13, xmm0        ; e^x += current_term

    ; Increment k (r12) and loop
    inc r12
    jmp taylor_loop

taylor_done:
    ; Move result to xmm0
    movsd xmm0, xmm13

    ; Restore callee-saved registers
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

section .data
one dq 1.0