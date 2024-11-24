global series
extern taylor
extern printf
extern scanf

segment .data
    prompt1 db "This software will compute any power of e that you may need.", 10, 0
    prompt2 db "Please enter the number of terms to include in the Taylor sum: ", 10, 0
    float_format db "%f", 0
    int_format db "%d", 0
segment .bss
    user_num resq 1
    user_int resq 1
segment .text
series:
    ; Back up registers
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    mov    rax, 0
    mov    rdi, prompt1
    call   printf

    mov     rax, 1
    mov     rdi, float_format
    mov     rsi, user_num
    call    scanf

    mov     rax, 0
    mov     rdi, prompt2
    call    printf

    mov     rax, 1
    mov     rdi, int_format
    mov     rsi, user_int
    call    scanf
    


    ; Restore registers
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp