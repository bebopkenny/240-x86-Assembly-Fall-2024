section .data
    msg1 db "Welcome to Electricity brought to you by Henry Finkelstein.", 0xA, 0
    msg2 db "This program will compute the resistance in your direct current circuit.", 0xA, 0

section .text
    global _start
    extern faraday ; Declare the external function

_start:
    ; Print the first message
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, msg1       ; address of msg1
    mov rdx, 68         ; Correct length of msg1 including newline
    syscall

    ; Print the second message
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, msg2       ; address of msg2
    mov rdx, 100        ; Correct length of msg2 including newline
    syscall

    ; Call the faraday function
    call faraday

    ; Exit program
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; exit status 0
    syscall
