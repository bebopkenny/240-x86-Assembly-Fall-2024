;Author information
;  Author name: Kenny Garcia
;  Author email: kennygarcia15@csu.fullerton.edu
;  Section: 03
;  CWID: 887930782

extern scanf

extern printf

global calc_average

section .data
    prompt1 db "Please enter your first and last names: ", 10, 0
    prompt2 db "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc: ", 10, 0
    prompt3 db "Thank you %s %s", 10, 0
    invalid_input db "Invalid data detected. Try again.", 10, 0  ; Error message
    santa_ana db "Enter the number of miles traveled from Fullerton to Santa Ana: ", 10, 0
    avg_santa_ana_text db "Enter your average speed during that leg of the trip: ", 10, 0
    long_beach db "Enter the number of miles traveled from Santa Ana to Long Beach: ", 10, 0
    avg_long_beach_text db "Enter your average speed during that leg of the trip: ", 10, 0
    fullerton db "Enter the number of miles traveled from Long Beach to Fullerton: ", 10, 0
    avg_fullerton_text db "Enter your average speed during that leg of the trip: ", 10, 0
    data_processing db "The inputted data are being processed ", 10, 0
    total_distance db "The total distance traveled is %lf miles.", 10, 0  ; Message to display total distance
    time_of_trip db "The time of trip is %lf hours.", 10, 0
    total_average_speed db "The average during this trip is %lf mph.", 10, 0
    string_format db "%s", 0
    number_format db "%lf", 0    ; Using %lf to read doubles
    three dq 3.0     ; Define the constant 3.0

section .bss
    user_name resb 100          ; Reserve space for the user's name
    user_title resb 100         ; Reserve space for the user's title
    miles_santa_ana resq 1      ; Buffer for the miles as a double
    avg_santa_ana resq 1        ; Buffer for average speed as a double
    miles_long_beach resq 1     ; Buffer for Long Beach miles as a double
    avg_long_beach resq 1       ; Buffer for Long Beach avg speed as a double
    miles_fullerton resq 1      ; Buffer for Fullerton miles as a double
    avg_fullerton resq 1        ; Buffer for Fullerton avg speed as a double
    sum_total_distance resq 1   ; Buffer for the total distance
    sum_time_of_trip resq 1
    sum_total_average_speed resq 1

section .text
    calc_average: 
     
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
    mov         rdi, prompt1     ; Move prompt message to rdi
    call        printf           ; Print the message

    mov         rdi, string_format
    mov         rsi, user_name   ; Prepare to scan input into user_name
    call        scanf            ; Read the user's name

    ; Prompt for user's title
    mov         rdi, prompt2     ; Move title prompt to rdi
    call        printf           ; Print the title prompt

    mov         rdi, string_format
    mov         rsi, user_title  ; Prepare to scan input into user_title
    call        scanf            ; Read the user's title

    ; Print "Thank you {name} {title}"
    mov         rdi, prompt3     ; Move the thank you message to rdi
    mov         rsi, user_name   ; Move user name to rsi
    mov         rdx, user_title  ; Move user title to rdx
    call        printf           ; Print the thank you message

    ; Prompt for Santa Ana miles
    mov         rdi, santa_ana   ; Prompt user for miles traveled to Santa Ana
    call        printf           ; Print the prompt

    input_miles_santa_ana:
    ; Use scanf with %lf to store the miles as a double
    mov         rdi, number_format
    mov         rsi, miles_santa_ana  ; Store input in miles_santa_ana
    call        scanf            ; Read miles_santa_ana

    ; Check if scanf successfully read a double (scanf returns 1 for success)
    cmp         rax, 1           ; Compare scanf result (stored in rax) with 1
    je          valid_miles_santa_ana  ; If valid, jump to valid_miles_santa_ana
    
    ; If invalid, print error message and try again
    mov         rdi, invalid_input  ; Load invalid input message
    call        printf             ; Print the error message
    jmp         input_miles_santa_ana  ; Jump back to retry the input

    valid_miles_santa_ana:
    ; Prompt for average speed to Santa Ana
    mov         rdi, avg_santa_ana_text  ; Prompt for avg speed to Santa Ana
    call        printf           ; Print the prompt

    input_avg_santa_ana:
    ; Use scanf with %lf to store the avg speed as a double
    mov         rdi, number_format
    mov         rsi, avg_santa_ana  ; Store input in avg_santa_ana
    call        scanf            ; Read avg_santa_ana

    cmp         rax, 1
    je          valid_avg_santa_ana

    mov         rdi, invalid_input
    call        printf
    jmp         input_avg_santa_ana

    valid_avg_santa_ana: 
    ; Prompt for Long Beach miles
    mov         rdi, long_beach   ; Prompt user for miles to Long Beach
    call        printf           ; Print the prompt

    input_miles_long_beach:
    ; Use scanf with %lf to store the miles as a double
    mov         rdi, number_format
    mov         rsi, miles_long_beach  ; Store input in miles_long_beach
    call        scanf            ; Read miles_long_beach

    cmp         rax, 1
    je          valid_miles_long_beach

    mov         rdi, invalid_input
    call        printf
    jmp         input_miles_long_beach

    valid_miles_long_beach:
    ; Prompt for average speed to Long Beach
    mov         rdi, avg_long_beach_text ; Prompt for avg speed to Long Beach
    call        printf           ; Print the prompt

    input_avg_long_beach:
    ; Use scanf with %lf to store the avg speed as a double
    mov         rdi, number_format
    mov         rsi, avg_long_beach  ; Store input in avg_long_beach
    call        scanf            ; Read avg_long_beach

    cmp         rax, 1
    je          valid_avg_long_beach

    mov         rdi, invalid_input
    call        printf
    jmp         input_avg_long_beach

    valid_avg_long_beach:
    ; Prompt for Fullerton miles
    mov         rdi, fullerton    ; Prompt user for miles to Fullerton
    call        printf           ; Print the prompt

    input_miles_fullerton:
    ; Use scanf with %lf to store the miles as a double
    mov         rdi, number_format
    mov         rsi, miles_fullerton  ; Store input in miles_fullerton
    call        scanf            ; Read miles_fullerton

    cmp         rax, 1
    je          valid_miles_fullerton

    mov         rdi, invalid_input
    call        printf
    jmp         input_miles_fullerton

    valid_miles_fullerton:
    ; Prompt for average speed to Fullerton
    mov         rdi, avg_fullerton_text  ; Prompt for avg speed to Fullerton
    call        printf           ; Print the prompt

    input_avg_fullerton:
    ; Use scanf with %lf to store the avg speed as a double
    mov         rdi, number_format
    mov         rsi, avg_fullerton  ; Store input in avg_fullerton
    call        scanf            ; Read avg_fullerton

    cmp         rax, 1
    je          valid_avg_fullerton

    mov         rdi, invalid_input
    call        printf
    jmp         input_avg_fullerton

    valid_avg_fullerton:
    ; Print "The inputted data are being processed"
    mov         rdi, data_processing   ; Move processing message to rdi
    call        printf                 ; Print processing message

    ; Calculate the total distance: length1 + length2 + length3
    movsd       xmm0, [miles_santa_ana]   ; Load miles_santa_ana into xmm0
    addsd       xmm0, [miles_long_beach]  ; Add miles_long_beach to xmm0
    addsd       xmm0, [miles_fullerton]   ; Add miles_fullerton to xmm0

    movsd       [sum_total_distance], xmm0  ; Store the result in sum_total_distance

    ; Print the total distance
    mov         rdi, total_distance    ; Move total_distance message to rdi
    movsd       xmm0, [sum_total_distance]  ; Load total distance into xmm0 for printing
    call        printf                 ; Print the total distance

      ; First leg (L1 / S1) - Santa Ana to Fullerton
    movsd       xmm0, [miles_santa_ana]   ; Load miles_santa_ana into xmm0
    divsd       xmm0, [avg_santa_ana]     ; Divide by avg_santa_ana (L1/S1)

    ; Second leg (L2 / S2) - Santa Ana to Long Beach
    movsd       xmm1, [miles_long_beach]  ; Load miles_long_beach into xmm1
    divsd       xmm1, [avg_long_beach]    ; Divide by avg_long_beach (L2/S2)
    addsd       xmm0, xmm1                ; Add result to xmm0

    ; Third leg (L3 / S3) - Long Beach to Fullerton
    movsd       xmm2, [miles_fullerton]   ; Load miles_fullerton into xmm2
    divsd       xmm2, [avg_fullerton]     ; Divide by avg_fullerton (L3/S3)
    addsd       xmm0, xmm2                ; Add result to xmm0

    ; Store the final result in sum_time_of_trip
    movsd       [sum_time_of_trip], xmm0

    ; Print the final total time
    mov         rdi, time_of_trip         ; Move time_of_trip message to rdi
    movsd       xmm0, [sum_time_of_trip]  ; Load the final time for printing
    call        printf                    ; Print the final result

    ; First part: S1 + S2
    movsd       xmm0, [avg_santa_ana]     ; Load avg_santa_ana (S1) into xmm0
    addsd       xmm0, [avg_long_beach]    ; Add avg_long_beach (S2) to xmm0

    ; Second part: Add S3 (avg_fullerton)
    addsd       xmm0, [avg_fullerton]     ; Add avg_fullerton (S3) to xmm0

    ; Divide by 3 to get the average speed
    movsd       xmm1, [three]             ; Load 3.0 into xmm1 (from .data section)
    divsd       xmm0, xmm1                ; Divide (S1 + S2 + S3) by 3

    ; Store the final result in sum_total_average_speed
    movsd       [sum_total_average_speed], xmm0

    ; Print the final average speed
    mov         rdi, total_average_speed  ; Move the average speed message to rdi
    movsd       xmm0, [sum_total_average_speed] ; Load the final average speed
    call        printf                    ; Print the final result

    movsd       xmm0, [sum_total_average_speed]  ; Load the final average speed into xmm0


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