; Author name: Kenny Garcia
; Author email: kennygarcia15@csu.fullerton.edu
; Course and segment: CPSC240-5
; Today’s date: Dec 17, 2024
global variance
extern printf

segment .data
    debug_variance db "Variance Calculation - %.5lf", 10, 0

segment .text
variance:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    pxor xmm1, xmm1                ; xmm1 = variance sum
    xor r12, r12                   ; r12 = loop index

variance_loop:
    cmp r12, rsi                   ; Compare index with array length
    jge variance_done

    movsd xmm2, [rdi + r12 * 8]    ; Load array[i]
    subsd xmm2, xmm0               ; array[i] - mean
    mulsd xmm2, xmm2               ; (array[i] - mean)^2
    addsd xmm1, xmm2               ; Accumulate variance sum

    inc r12
    jmp variance_loop

variance_done:
    cvtsi2sd xmm2, rsi             ; Convert array length to double
    divsd xmm1, xmm2               ; variance = sum / length

    ; Debug output
    lea rdi, [debug_variance]
    movsd xmm0, xmm1               ; Move variance result to xmm0 for printf
    call printf

    movsd xmm0, xmm1               ; Ensure final variance is in xmm0 for return

    pop r13
    pop r12
    pop rbp
    ret
