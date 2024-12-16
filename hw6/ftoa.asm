section .data
format db "%.6f", 0

section .text
global ftoa
extern sprintf

ftoa:
    sub rsp, 32
    mov rdi, rsi            ; Buffer address
    mov rsi, format         ; Format string
    movq xmm1, xmm0         ; Move double to xmm1
    mov rax, 1              ; Indicate floating-point argument
    call sprintf
    add rsp, 32
    ret

