section .data
    prompt_name db "Please enter your full name: ", 0
    prompt_career db "Please enter the career path you are following: ", 0
    thank_you db "Thank you. We appreciate all ", 0
    newline db 10, 0
    prompt_emf db "Please enter the EMF of your circuit in volts: ", 0
    entered_emf db "You entered: ", 0
    prompt_current db "Please enter the current in this circuit in amps: ", 0
    entered_current db "You entered: ", 0

section .bss
    name_input resb 100
    career_input resb 100
    emf_input resb 100
    emf_output resb 50
    current_input resb 100
    current_output resb 50

section .text
global faraday
extern atof
extern ftoa

faraday:
    ; Prompt and read full name
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_name
    mov rdx, 30
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, name_input
    mov rdx, 100
    syscall

    ; Prompt and read career path
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_career
    mov rdx, 48
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, career_input
    mov rdx, 100
    syscall

    ; Print thank you message
    mov rax, 1
    mov rdi, 1
    mov rsi, thank_you
    mov rdx, 30
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, career_input
    mov rdx, 100
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Prompt and read EMF
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_emf
    mov rdx, 40
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, emf_input
    mov rdx, 100
    syscall

    ; Convert EMF input to float
    mov rdi, emf_input
    call atof

    ; Format and print EMF value
    movq xmm0, rdi
    mov rsi, emf_output
    call ftoa

    mov rax, 1
    mov rdi, 1
    mov rsi, entered_emf
    mov rdx, 12
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, emf_output
    mov rdx, 50
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Prompt and read current
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_current
    mov rdx, 50
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, current_input
    mov rdx, 100
    syscall

    ; Convert current input to float
    mov rdi, current_input
    call atof

    ; Format and print current value
    movq xmm0, rdi
    mov rsi, current_output
    call ftoa

    mov rax, 1
    mov rdi, 1
    mov rsi, entered_current
    mov rdx, 14
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, current_output
    mov rdx, 50
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ret


