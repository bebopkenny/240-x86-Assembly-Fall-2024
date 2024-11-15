global output_array
extern printf

section .data
output_int db "%d", 0  ; Change format to integer

section .bss
align 64
storedata resb 832

section .text

output_array:
    ; Back up components
    push        rbp
    mov         rbp, rsp
    push        rbx
    push        rcx
    push        rdx
    push        rsi
    push        rdi
    push        r8 
    push        r9 
    push        r10
    push        r11
    push        r12
    push        r13
    push        r14
    push        r15

    xor         r13, r13     ; r13 keeps track of the index
    mov         r14, rdi     ; rdi contains the pointer to the array (user_array)
    mov         r15, rsi     ; rsi contains the count of the array

output_loop:
    ; If the index reaches the count, end the loop
    cmp         r13, r15
    jge         output_finished
 
    ; Print the number inside the array
    xor         rdi, rdi
    mov         rsi, qword [r14 + r13 * 8]  ; Access the long integer (8 bytes)
    mov         rdi, output_int        ; Format string for long integer
    call        printf                   ; Call printf to print the integer

   ; If this is not the last element, print a comma and space
    cmp         r13, r15
    je          no_comma
    mov         rdi, ", "               ; Print comma and space
    call        printf

no_comma:
    ; Increase the index
    inc         r13    

    ; Repeat the loop
    jmp         output_loop

output_finished:
    ; Restore the state (if necessary)
    pop         r15
    pop         r14
    pop         r13
    pop         r12
    pop         r11
    pop         r10
    pop         r9 
    pop         r8 
    pop         rdi
    pop         rsi
    pop         rdx
    pop         rcx
    pop         rbx
    pop         rbp
    ret 
