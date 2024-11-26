;====================================================================================
; Program Name: "Taylor Series Approximation". 
; This program calculates the Taylor series expansion to approximate the exponential 
; function e^x using user-provided inputs for the base x and the number of terms.
;
; Copyright (C) 2024  Kenny Garcia. 
;
; This program is free software: you can redistribute it and/or modify it under the
; terms of the GNU General Public License as published by the Free Software Foundation,
; version 3 or (at your option) any later version.
;
; Taylor Series Approximation is distributed in the hope that it will be helpful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
; or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for details.
;
; A copy of the GNU General Public License v3 can be found at: <https://www.gnu.org/licenses/>.
;====================================================================================
;
; Author Information:
;   Author Name: Kenny Garcia
;   Author Email: kennygarcia15@csu.fullerton.edu
;   CWID: 887930782
;   Class: 240 Section 05
;
; Program Information:
;   Program Name: Taylor Series Approximation
;   Programming Languages: Main module in C++, supporting modules in x86 Assembly
;   Start Date: 2024-November-24
;   Last Updated: 2024-November-25
;   Files in the Program: main.cpp, series.asm, taylor.asm, r.sh
;   Status: Complete and verified for functional accuracy
;
; Purpose:
;   This program computes the approximation of e^x using the Taylor series expansion
;   up to a specified number of terms. The result is calculated efficiently and 
;   execution time is measured in CPU clock ticks for performance evaluation.
;====================================================================================


global series
extern taylor
extern printf
extern scanf

section .data
    input_prompt_x db "Please enter a float number value for x: ", 0  ; Prompt for x
    input_prompt_n db "Please enter the number of terms to include in the Taylor sum: ", 0  ; Prompt for n
    clock_start_msg db "The time on the clock is now %llu tics and Taylor has been called.", 10, 0  ; Start clock message
    thank_you_msg db "Thank you for waiting.", 10, 0  ; Thank you message
    clock_end_msg db "The time on the clock when Taylor terminated was %llu tics.", 10, 0  ; End clock message
    exec_time_msg db "The execution time was %llu tics.", 10, 0  ; Elapsed time message
    result_msg db "The computed approximation of e^x is: %.8f with precision of 8 digits right of the point.", 10, 0  ; Result message
    freq_msg db "The frequency of the microprocessor of this computer is %.1f GHz.", 10, 0  ; Frequency of processor
    ns_time_msg db "The time required to run the Taylor function was %.1f ns.", 10, 0  ; Time in nanoseconds
    outro_msg1 db "Thank you for using the Eyere exponential calculator.", 10, 0  ; Outro part 1
    outro_msg2 db "Please return another day. The computed value will be set to the caller functions.", 10, 0  ; Outro part 2
    driver_msg db "The driver received this number %.8f and will keep it.", 10, 0  ; Driver result message
    format_float db "%lf", 0  ; Format for floating-point input
    format_int db "%lu", 0    ; Format for integer input

    ; Constants
    processor_freq dq 2.1         ; Frequency of the processor in GHz
    thousand dq 1000.0            ; Constant for 1000.0

section .bss
    x resq 1                      ; Storage for x (user input)
    n resq 1                      ; Storage for n (user input)
    start_tics resq 1             ; Start tics for timing
    end_tics resq 1               ; End tics for timing
    elapsed_ticks resq 1          ; Calculated elapsed tics
    nanoseconds resq 1            ; Time in nanoseconds

section .text
series:
    ; Prologue with 15 pushes
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    ; Prompt for x
    lea rdi, [input_prompt_x]  ; Load the x prompt message
    xor rax, rax
    call printf
    lea rsi, [x]               ; Address to store x
    lea rdi, [format_float]    ; Format for float input
    xor rax, rax
    call scanf                 ; Read user input for x

    ; Prompt for n
    lea rdi, [input_prompt_n]  ; Load the n prompt message
    xor rax, rax
    call printf
    lea rsi, [n]               ; Address to store n
    lea rdi, [format_int]      ; Format for integer input
    xor rax, rax
    call scanf                 ; Read user input for n

    ; Start timing
    rdtsc                      ; Read current tics into EDX:EAX
    shl rdx, 32                ; Shift high 32 bits to upper register
    or rax, rdx                ; Combine into a 64-bit value
    mov qword [start_tics], rax ; Store start tics

    ; Print clock start message
    lea rdi, [clock_start_msg]
    mov rsi, rax
    xor rax, rax
    call printf

    ; Call taylor function
    movsd xmm0, qword [x]      ; Load x into xmm0
    mov rdi, qword [n]         ; Move n into rdi
    call taylor

    ; Print thank you message
    lea rdi, [thank_you_msg]
    xor rax, rax
    call printf

    ; End timing
    rdtsc                      ; Read current tics into EDX:EAX
    shl rdx, 32                ; Shift high 32 bits to upper register
    or rax, rdx                ; Combine into a 64-bit value
    mov qword [end_tics], rax  ; Store end tics

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
    mov rax, qword [elapsed_ticks] ; Convert elapsed ticks to nanoseconds
    cvtsi2sd xmm1, rax
    movsd xmm2, qword [thousand]
    mulsd xmm1, xmm2
    movsd xmm0, qword [processor_freq]
    divsd xmm1, xmm0
    movsd qword [nanoseconds], xmm1

    ; Print the result of Taylor function
    lea rdi, [result_msg]
    movsd xmm0, qword [nanoseconds] ; Move computed result to xmm0
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
    movsd xmm0, qword [nanoseconds]
    call printf

    ; Epilogue with 15 pops
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp
    ret
