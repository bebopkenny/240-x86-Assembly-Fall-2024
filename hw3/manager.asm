extern scanf
extern printf
extern input_array
extern isinteger
extern sum
extern output_array
max_size equ 10

global manager

segment .data
    prompt db "Please enter your name: ", 0      
    prompt2 db "This program will sum your array of integers.", 10, 0
    prompt3 db "Enter a sequence of long integers separated by white space.", 10, 0
    prompt4 db "After the last input press enter followed by Control+D: ", 10, 0
    prompt5 db "These number were received and placed into the: ", 10, 0
    string_format db "%s", 0
    integer_format db "%ld ", 0          ; To print long integers

segment .bss
    align 64
    storedata resb 832
    user_array resq max_size
    user_name resb 100

segment .text
manager:
    push        rbp             ; Save base pointer
    mov         rbp, rsp        ; Set base pointer to the stack pointer
    push        rbx             ; Save registers for later use
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
    pushf                        ; Save flags

    ; Prompt for user's name
    mov         rax, 7
    mov         rdx, 0
    xsave       [storedata]

    mov         rax, 0
    mov         rdi, prompt      ; Move prompt message to rdi
    call        printf           ; Print the message

    mov         rdi, string_format
    mov         rsi, user_name   ; Prepare to scan input into user_name
    call        scanf            ; Read the user's name

    ; Print the user's name
    mov         rdi, user_name
    call        printf

    ; Print other messages
    mov         rdi, prompt2
    call        printf
    
    mov         rdi, prompt3
    call        printf

    mov         rdi, prompt4
    call        printf

    ; Call input_array
    mov         rax, 0
    mov         rdi, user_array
    mov         rsi, max_size
    call        input_array      ; Input integers and store count in rax

    ; rax contains the count of elements
    mov         r13, rax         ; Move count of elements to r13

    ; Print the array elements
    mov         rax, 0
    mov         rdi, prompt5
    call        printf

    xor         r14, r14         ; Set index to 0

print_loop:
    cmp         r14, r13         ; If we've printed all elements, exit the loop
    jge         print_finished

    mov         rsi, qword [user_array + r14 * 8]  ; Load the element from the array (4 bytes for int)
    mov         rdi, integer_format          ; Format to print integer
    call        printf

    inc         r14              ; Increment index
    jmp         print_loop

print_finished:
    ; Restore stack and registers
    popf                           ; Restore flags
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

    ; Clean up and return
    ret
