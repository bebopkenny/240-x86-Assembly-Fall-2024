global input_array
extern printf
extern scanf
extern isinteger
extern malloc

segment .data
prompt db "Enter a number: ", 0
invalid_msg db "Invalid input. Please try again. ", 10, 0
format_integer db "%ld", 0  ; Changed to %ld for long integers

segment .bss
align 64
storedata resb 832

segment .text

input_array:
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
    pushf

    ; Save all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xsave       [storedata]
    
    xor         r13, r13    ; r13 keeps track of the index of the loop   
    mov         r14, rdi     ; rdi contains the array (user_array)    
    mov         r15, rsi     ; rsi contains the size of the array

input_loop:
    ; If the array is full, end the loop
    cmp         r13, r15
    jge         input_finished

    ; Scan for input
    mov         rax, 0
    mov         rdi, format_integer  ; Use %ld for integers
    lea         rsi, [r12]          ; Address of the variable for storing input
    call        scanf 

    ; If the user presses CTRL+D, end the loop
    cmp         rax, 1                ; scanf returns the number of inputs read
    jne         input_finished         ; If 0 or EOF, exit the loop

    ; Move the input into the array
    mov         [r14 + r13 * 8], r12  ; Store the read integer in user_array
    
    ; Increase the index
    inc         r13      
    
    ; Repeat the loop
    jmp         input_loop

input_finished:
    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ; Send the count back to manage
    mov         rax, r13  

    ; Restore the original values to the GPRs
    popf          
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

    ; Clean up
    ret 
