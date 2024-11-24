global series
extern taylor
extern printf
extern scanf

section .data
    prompt1 db "This software will compute any power of e that you may need.", 10, 0
    prompt2 db "Please enter a float number value for x: ", 0
    prompt3 db "Please enter the number of terms to include in the Taylor sum: ", 0
    start_time_msg db "The time on the clock is now %llu tics and taylor has been called", 10, 0
    end_time_msg db "The time on the clock when Taylor terminated was %llu tics", 10, 0
    elapsed_time_msg db "The execution time was %llu tics.", 10, 0
    result_msg db "The computed approximation of e^x is: %.8f", 10, 0
    float_format db "%lf", 0
    int_format db "%lu", 0

section .bss
    user_num resq 1      ; To store the user's float input (x)
    user_int resq 1      ; To store the user's integer input (n)
    result resq 1        ; To store the result of the taylor function
    start_ticks resq 1   ; To store the start clock ticks
    end_ticks resq 1     ; To store the end clock ticks
    elapsed_ticks resq 1 ; To store the elapsed clock ticks

section .text
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

    ; Display prompt1
    mov rax, 0
    mov rdi, prompt1
    call printf

    ; Prompt for x (float value)
    mov rax, 0
    mov rdi, prompt2
    call printf
    mov rax, 1
    mov rdi, float_format
    mov rsi, user_num
    call scanf

    ; Prompt for n (integer value)
    mov rax, 0
    mov rdi, prompt3
    call printf
    mov rax, 1
    mov rdi, int_format
    mov rsi, user_int
    call scanf

    ; Get start clock ticks
    rdtsc                     ; Read time-stamp counter
    shl rdx, 32               ; Shift high bits to upper 32
    or rax, rdx               ; Combine rax and rdx
    mov qword [start_ticks], rax ; Store start ticks

    ; Print start time message
    mov rax, 1
    mov rdi, start_time_msg
    mov rsi, qword [start_ticks]
    call printf

    ; Load user inputs into registers for taylor function
    movsd xmm0, qword [user_num]  ; Load x (float) into xmm0
    mov rdi, qword [user_int]     ; Load n (integer) into rdi

    ; Call taylor function
    call taylor

    ; Store result from taylor (in xmm0) into memory
    movsd qword [result], xmm0

    ; Get end clock ticks
    rdtsc                     ; Read time-stamp counter
    shl rdx, 32               ; Shift high bits to upper 32
    or rax, rdx               ; Combine rax and rdx
    mov qword [end_ticks], rax ; Store end ticks

    ; Print end time message
    mov rax, 1
    mov rdi, end_time_msg
    mov rsi, qword [end_ticks]
    call printf

    ; Calculate elapsed ticks
    mov rax, qword [end_ticks]
    sub rax, qword [start_ticks]
    mov qword [elapsed_ticks], rax

    ; Print elapsed time message
    mov rax, 1
    mov rdi, elapsed_time_msg
    mov rsi, qword [elapsed_ticks]
    call printf

    ; Print the result
    mov rax, 1
    mov rdi, result_msg
    mov rsi, result
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
    ret