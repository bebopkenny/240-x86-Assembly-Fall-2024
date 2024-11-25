global series
extern taylor
extern printf
extern scanf

section .data
    prompt1 db "This software will compute any power of e that you may need.", 10, 0
    prompt2 db "Please enter a float number value for x: ", 0
    prompt3 db "Please enter the number of terms to include in the Taylor sum: ", 0
    start_time_msg db "The time on the clock is now %llu tics and taylor has been called.", 10, 0
    end_time_msg db "The time on the clock when Taylor terminated was %llu tics.", 10, 0
    elapsed_time_msg db "The execution time was %llu tics.", 10, 0
    result_msg db "The computed approximation of e^x is %.8f", 10, 0
    raw_memory_msg db "Raw memory contents of x after scanf: 0x%016lx", 10, 0
    raw_memory_msg_int db "Raw memory contents of n after scanf: 0x%016lx", 10, 0
    debug_msg db "Debug: x=%lf, n=%ld", 10, 0
    error_msg db "Error: Invalid input for x or n.", 10, 0
    float_format db "%lf", 0
    int_format db "%ld", 0  ; Updated format specifier for integer input

section .bss
    align 8                  ; Ensure proper alignment
    user_num resq 1          ; To store the user's float input (x)
    user_int resq 1          ; To store the user's integer input (n)
    result resq 1            ; To store the result of the taylor function
    start_ticks resq 1       ; To store the start clock ticks
    end_ticks resq 1         ; To store the end clock ticks
    elapsed_ticks resq 1     ; To store the elapsed clock ticks

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

    ; Debug: Print raw memory contents of x
    mov rax, qword [user_num]
    mov rdi, raw_memory_msg
    mov rsi, rax
    call printf

    ; Prompt for n (integer value)
    mov rax, 0
    mov rdi, prompt3
    call printf
    mov rax, 1
    mov rdi, int_format
    mov rsi, user_int
    call scanf

    ; Debug: Print raw memory contents of n
    mov rax, qword [user_int]
    mov rdi, raw_memory_msg_int
    mov rsi, rax
    call printf

    ; Check for invalid n
    mov rax, qword [user_int]
    test rax, rax
    jle error_exit

; Debug print for x and n
mov rax, 0
mov rdi, debug_msg

; Load x into the FPU stack and store back
fld qword [user_num]        ; Load `user_num` onto FPU stack
fstp qword [result]         ; Store back into memory
movsd xmm0, qword [result]  ; Move into `xmm0` for printf

; Ensure n is correctly loaded into rsi for printf
mov rsi, qword [user_int]

; Call printf to display debug information
call printf




    ; Rest of the code remains unchanged...

error_exit:
    ; Print error message and exit
    mov rax, 0
    mov rdi, error_msg
    call printf

cleanup:
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