global executive
extern fgets, printf, strlen, stdin, atoi
extern fill_random_array, show_array, normalize_array, sort

max_size equ 60

segment .data
    prompt_name db "Please enter your name: ", 0
    prompt_title db "Please enter your title (Mr, Ms, Sargent, Chief, Project Leader, etc): ", 0
    prompt_welcome db "Nice to meet you %s %s", 10, 10, 0
    prompt_instruction_1 db "This program will generate 64-bit IEEE float numbers.", 10, 0
    prompt_instruction_2 db "How many numbers do you want? Today’s limit is 100 per customer: ", 0
    prompt_print_num_1 db "Your numbers have been stored in an array. Here is that array.", 10, 10, 0
    prompt_print_num_2 db 10, "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array.", 10, 10, 0
    prompt_sorted db 10, "The array will now be sorted", 10, 0
    prompt_goodbye db "Goodbye %s. You are welcome any time.", 10, 0

segment .bss
    input_name resb max_size
    input_title resb max_size
    input_count resb max_size
    random_number_array resq 100

segment .text
executive:
    ; Save registers and set up the stack frame
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

    ; Prompt for the user's name
    mov rdi, prompt_name
    call printf
    lea rdi, [input_name]
    mov rsi, max_size
    mov rdx, [stdin]
    call fgets
    mov rdi, input_name
    call strlen
    mov byte [input_name + rax - 1], 0  ; Remove newline

    ; Prompt for the user's title
    mov rdi, prompt_title
    call printf
    lea rdi, [input_title]
    mov rsi, max_size
    mov rdx, [stdin]
    call fgets
    mov rdi, input_title
    call strlen
    mov byte [input_title + rax - 1], 0  ; Remove newline

    ; Print the welcome message
    mov rdi, prompt_welcome
    mov rsi, input_title
    mov rdx, input_name
    call printf

    ; Print the first instruction
    mov rdi, prompt_instruction_1
    call printf

    ; Prompt for the number of random numbers
    mov rdi, prompt_instruction_2
    call printf
    lea rdi, [input_count]
    mov rsi, max_size
    mov rdx, [stdin]
    call fgets
    mov rdi, input_count
    call strlen
    mov byte [input_count + rax - 1], 0  ; Remove newline

    ; Convert input to integer
    mov rdi, input_count
    call atoi
    mov r15, rax

    ; Validate the number of random numbers
    cmp r15, 1
    jl .exit                             ; Exit if less than 1
    cmp r15, 100
    jg .exit                             ; Exit if greater than 100

    ; Generate random numbers in the array
    mov rdi, random_number_array
    mov rsi, r15
    call fill_random_array

    ; Print the first array message
    mov rdi, prompt_print_num_1
    call printf

    ; Display the array
    mov rdi, random_number_array
    mov rsi, r15
    call show_array

    ; Normalize the array
    mov rdi, random_number_array
    mov rsi, r15
    call normalize_array

    ; Print the normalization message
    mov rdi, prompt_print_num_2
    call printf

    ; Display the normalized array
    mov rdi, random_number_array
    mov rsi, r15
    call show_array

    ; Print the sorting message
    mov rdi, prompt_sorted
    call printf

    ; Sort the array
    mov rdi, random_number_array
    mov rsi, r15
    call sort

    ; Display the sorted array
    mov rdi, random_number_array
    mov rsi, r15
    call show_array

.exit:
    ; Print the goodbye message
    mov rdi, prompt_goodbye
    mov rsi, input_title
    call printf

    ; Restore registers and clean up
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