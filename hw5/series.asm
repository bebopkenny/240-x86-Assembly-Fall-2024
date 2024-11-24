global series
extern taylor
extern printf

segment .data
    prompt1 db "This software will compute any power of e that you may need.", 10, 0
    prompt2 db "Please enter a float number value for x: ", 10, 0

segment .bss
    user_num dq %f

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

    mov,    rax, 0
    mov,    rdi, prompt1
    call printf



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