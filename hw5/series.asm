global series
extern taylor
extern printf
extern scanf

section .data
    welcome_msg db "Welcome to Taylor Series by Kenny Garcia.", 10, 0
    software_msg db "This software will compute any power of e that you may need.", 10, 0
    input_prompt_x db "Please enter a float number value for x (e.g., 17.55): ", 0
    input_prompt_n db "Please enter the number of terms to include in the Taylor sum (e.g., 8): ", 0
    clock_start_msg db "The time on the clock is now %llu tics and Taylor has been called.", 10, 0
    thank_you_msg db "Thank you for waiting.", 10, 0
    clock_end_msg db "The time on the clock when Taylor terminated was %llu tics.", 10, 0
    exec_time_msg db "The execution time was %llu tics.", 10, 0
    result_msg db "The computed approximation of e^x is: %.8f with precision of 8 digits right of the point.", 10, 0
    freq_msg db "The frequency of the microprocessor of this computer is %.1f GHz.", 10, 0
    ns_time_msg db "The time required to run the Taylor function was %.1f ns.", 10, 0
    outro_msg1 db "Thank you for using the Eyere exponential calculator.", 10, 0
    outro_msg2 db "Please return another day. The computed value will be set to the caller functions.", 10, 0
    driver_msg db "The driver received this number %.8f and will keep it.", 10, 0
    goodbye_msg db "Good-bye.", 10, 0
    format_float db "%lf", 0
    format_int db "%lu", 0

    ; Constants
    processor_freq dq 2.1         ; Frequency of the processor in GHz
    thousand dq 1000.0            ; Constant for 1000.0

section .bss
    x resq 1                      ; Storage for x
    n resq 1                      ; Storage for n
    start_tics resq 1             ; Start tics
    end_tics resq 1               ; End tics
    elapsed_ticks resq 1          ; Elapsed tics
    nanoseconds resq 1            ; Time in nanoseconds

section .text
series:
    ; Prologue
    push rbp
    mov rbp, rsp

    ; Print welcome message
    lea rdi, [welcome_msg]
    xor rax, rax
    call printf

    ; Print software message
    lea rdi, [software_msg]
    xor rax, rax
    call printf

    ; Prompt for x
    lea rdi, [input_prompt_x]
    xor rax, rax
    call printf
    lea rsi, [x]                ; Address to store x
    lea rdi, [format_float]     ; Format for float input
    xor rax, rax
    call scanf

    ; Prompt for n
    lea rdi, [input_prompt_n]
    xor rax, rax
    call printf
    lea rsi, [n]                ; Address to store n
    lea rdi, [format_int]       ; Format for integer input
    xor rax, rax
    call scanf

    ; Start timing
    rdtsc
    shl rdx, 32
    or rax, rdx
    mov qword [start_tics], rax

    ; Print clock start message
    lea rdi, [clock_start_msg]
    mov rsi, rax
    xor rax, rax
    call printf

    ; Call taylor function
    movsd xmm0, qword [x]
    mov rdi, qword [n]
    call taylor

    ; Print thank you message
    lea rdi, [thank_you_msg]
    xor rax, rax
    call printf

    ; End timing
    rdtsc
    shl rdx, 32
    or rax, rdx
    mov qword [end_tics], rax

    ; Print clock end message
    lea rdi, [clock_end_msg]
    mov rsi, rax
    xor rax, rax
    call printf

    ; Calculate elapsed tics
    mov rax, qword [end_tics]
    sub rax, qword [start_tics]
    mov qword [elapsed_ticks], rax

    ; Print execution time
    lea rdi, [exec_time_msg]
    mov rsi, rax
    xor rax, rax
    call printf

    ; Calculate nanoseconds
    mov rax, qword [elapsed_ticks]
    cvtsi2sd xmm1, rax
    movsd xmm2, qword [thousand]
    mulsd xmm1, xmm2
    movsd xmm0, qword [processor_freq]
    divsd xmm1, xmm0
    movsd qword [nanoseconds], xmm1

    ; Print the result of Taylor function
    lea rdi, [result_msg]
    movsd xmm0, xmm1             ; Return value from taylor
    call printf

    ; Print processor frequency
    lea rdi, [freq_msg]
    movsd xmm0, qword [processor_freq]
    call printf

    ; Print time in nanoseconds
    lea rdi, [ns_time_msg]
    movsd xmm0, qword [nanoseconds]
    call printf

    ; Print outro messages
    lea rdi, [outro_msg1]
    xor rax, rax
    call printf

    lea rdi, [outro_msg2]
    xor rax, rax
    call printf

    lea rdi, [driver_msg]
    movsd xmm0, xmm1             ; Return value from taylor
    call printf

    lea rdi, [goodbye_msg]
    xor rax, rax
    call printf

    ; Epilogue
    leave
    ret


