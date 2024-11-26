section .data
    welcome_msg db "Welcome to Taylor Series by Kenny Garcia.", 10, 0
    software_msg db "This software will compute any power of e that you may need.", 10, 0
    input_prompt_x db "Please enter a float number value for x (e.g., 17.55): ", 0
    input_prompt_n db "Please enter the number of terms to include in the Taylor sum (e.g., 8): ", 0
    clock_start_msg db "The time on the clock is now %llu tics and Taylor has been called.", 10, 0
    thank_you_msg db "Thank you for waiting.", 10, 0
    clock_end_msg db "The time on the clock when Taylor terminated was %llu tics.", 10, 0
    exec_time_msg db "The execution time was %llu tics.", 10, 0
    result_msg db "The computed approximation of e^x is: %.8f", 10, 0
    goodbye_msg db "Thank you for using the Eyere exponential calculator.", 10, 0
    outro_msg db "Please return another day. The computed value will be set to the caller functions.", 10, 0
    driver_msg db "The driver received this number %.8f and will keep it.", 10, 0
    farewell_msg db "Goodbye.", 10, 0

    ; Format strings for scanf and printf
    format_float db "%lf", 0  ; Format for reading a double
    format_int db "%lu", 0    ; Format for reading an unsigned long integer

section .bss
    x resq 1                ; Storage for x
    n resq 1                ; Storage for n
    start_tics resq 1       ; Start tics
    end_tics resq 1         ; End tics

section .text
    global series
    extern taylor
    extern printf           ; To print formatted strings
    extern scanf            ; To read user input

; double series(double x, unsigned long n)
series:
    ; Prologue
    push rbp
    mov rbp, rsp
    sub rsp, 32             ; Allocate stack space for local variables

    ; Print welcome message
    lea rdi, [welcome_msg]
    xor rax, rax
    call printf             ; printf(welcome_msg)

    ; Print software purpose message
    lea rdi, [software_msg]
    xor rax, rax
    call printf             ; printf(software_msg)

    ; Prompt for x
    lea rdi, [input_prompt_x] ; Load the x prompt string
    xor rax, rax
    call printf             ; Display prompt

    lea rsi, [x]              ; Address to store x
    lea rdi, [format_float]   ; Format for float input "%lf"
    xor rax, rax
    call scanf                ; scanf("%lf", &x)

    ; Prompt for n
    lea rdi, [input_prompt_n] ; Load the n prompt string
    xor rax, rax
    call printf             ; Display prompt

    lea rsi, [n]              ; Address to store n
    lea rdi, [format_int]     ; Format for integer input "%lu"
    xor rax, rax
    call scanf                ; scanf("%lu", &n)

    ; Start timing
    rdtsc                       ; Read tics into EDX:EAX
    shl rdx, 32
    or rax, rdx
    mov qword [start_tics], rax

    ; Print clock start message
    lea rdi, [clock_start_msg]
    mov rsi, rax
    xor rax, rax                ; printf expects 0 floating-point arguments
    call printf                 ; printf(clock_start_msg, start_tics)

    ; Call taylor function
    movsd xmm0, qword [x]       ; Load x into xmm0
    mov rdi, qword [n]          ; Move n into rdi
    call taylor                 ; Call taylor(x, n)

    ; End timing
    rdtsc                       ; Read tics into EDX:EAX
    shl rdx, 32
    or rax, rdx
    mov qword [end_tics], rax

    ; Print clock end message
    lea rdi, [clock_end_msg]
    mov rsi, rax
    xor rax, rax
    call printf                 ; printf(clock_end_msg, end_tics)

    ; Calculate execution time
    mov rax, qword [end_tics]
    sub rax, qword [start_tics]

    ; Print execution time
    lea rdi, [exec_time_msg]
    mov rsi, rax
    xor rax, rax
    call printf                 ; printf(exec_time_msg, exec_time)

    ; Print result
    lea rdi, [result_msg]
    mov rax, 1                  ; printf expects 1 floating-point argument
    call printf                 ; printf(result_msg, result in xmm0)

    ; Print outro messages
    lea rdi, [goodbye_msg]
    xor rax, rax
    call printf

    lea rdi, [outro_msg]
    xor rax, rax
    call printf

    lea rdi, [driver_msg]
    mov rax, 1
    call printf                 ; printf(driver_msg, result in xmm0)

    lea rdi, [farewell_msg]
    xor rax, rax
    call printf

    ; Epilogue
    leave
    ret

