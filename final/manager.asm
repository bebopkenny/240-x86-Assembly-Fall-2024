; Author name: Kenny Garcia
; Author email: kennygarcia15@csu.fullerton.edu
; Course and segment: CPSC240-5
; Today’s date: Dec 17, 2024

global manager
extern printf
extern scanf
extern variance

segment .data
    prompt_length db "Enter the number of elements in the array: ", 0
    prompt_float db "Enter float value for element %d: ", 0
    output_length db "The length of the array is: %ld", 10, 0
    output_sum db "The sum of the array is: %.5lf", 10, 0
    output_mean db "The mean of the array is: %.5lf", 10, 0
    output_variance db "The variance of the array is: %.5lf", 10, 0
    format_input db "%lf", 0
    format_int db "%d", 0

segment .bss
    array resq 100          ; Array to store up to 100 doubles
    length resq 1           ; Stores length of the array
    sum resq 1              ; Stores sum of the array
    mean resq 1             ; Stores mean

segment .text
manager:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    ; Prompt user for array length
    lea rdi, [prompt_length]
    call printf
    lea rdi, [format_int]
    lea rsi, [length]
    call scanf
    mov r15, qword [length]         ; Store length in r15
    test r15, r15
    jle end_manager

    ; Initialize variables
    pxor xmm0, xmm0                 ; Clear xmm0 for sum
    xor r13, r13                    ; r13 = index
    lea r14, [array]                ; Base address of array

input_loop:
    cmp r13, r15
    jge calculate_sum

    ; Prompt user for float value
    lea rdi, [prompt_float]
    mov rsi, r13
    call printf

    lea rdi, [format_input]
    lea rsi, [r14 + r13 * 8]
    call scanf

    ; Accumulate sum
    movsd xmm1, [r14 + r13 * 8]
    addsd xmm0, xmm1
    inc r13
    jmp input_loop

calculate_sum:
    movsd [sum], xmm0               ; Store sum
    cvtsi2sd xmm2, r15              ; Convert length to double
    divsd xmm0, xmm2                ; mean = sum / length
    movsd [mean], xmm0              ; Store mean

    ; Print length, sum, and mean
    lea rdi, [output_length]
    mov rsi, r15
    call printf

    lea rdi, [output_sum]
    movsd xmm0, [sum]
    call printf

    lea rdi, [output_mean]
    movsd xmm0, [mean]
    call printf

    ; Call variance function
    lea rdi, [array]
    mov rsi, r15
    movsd xmm0, [mean]
    call variance

    ; Print variance
    lea rdi, [output_variance]
    movsd xmm0, xmm0  ; Ensure xmm0 is passed properly
    call printf

    ; Return to caller
    add rsp, 16
    pop rbp
    ret

end_manager:
    add rsp, 16
    pop rbp
    ret
