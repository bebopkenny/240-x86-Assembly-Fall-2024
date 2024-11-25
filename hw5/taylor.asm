global taylor
extern printf  ; Declare printf as an external function

section .data
    debug_taylor_msg db "Debug: taylor called with x=%lf, n=%lu", 10, 0
    debug_iteration_msg db "Debug: Iteration k=%ld, term=%lf", 10, 0

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

    ; Debug: Print parameters passed to taylor
    mov rax, 0
    mov rdi, debug_taylor_msg
    movsd xmm0, xmm0    ; x (double) passed in xmm0
    mov rsi, rdi        ; n (unsigned long int) passed in rdi
    call printf

    ; Initialize variables
    mov rbx, rdi          ; rbx = n (number of terms)
    mov r12, 1            ; r12 = factorial accumulator, initially 1
    xor r13, r13          ; r13 = k (current term index), initially 0
    movsd xmm1, xmm0      ; xmm1 = x (base value for terms)
    movsd xmm2, qword [taylor_one] ; xmm2 = 1.0 (initial x^0)
    movsd xmm3, xmm2      ; xmm3 = result accumulator, initially 1.0

taylor_loop:
    ; Break if k > n (all terms computed)
    cmp r13, rbx
    jg taylor_done

    ; Debug: Print current iteration values
    mov rax, 0
    mov rdi, debug_iteration_msg
    mov rsi, r13          ; Current term index (k)
    movsd xmm0, xmm2      ; Current term (x^k / k!)
    call printf

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
