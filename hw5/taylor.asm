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

global taylor
section .text

taylor:
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

    ; Initialize variables
    mov r13, rdi             ; r13 = n (number of terms)
    cvtsi2sd xmm15, r13      ; Convert n to double for debug if needed
    movsd xmm14, xmm0        ; xmm14 = x (input x)
    movsd xmm13, qword [one] ; xmm13 = e^x (initially 1.0)
    movsd xmm12, qword [one] ; xmm12 = prev_term (initially 1.0)
    mov r12, 1               ; r12 = k (loop counter), starting at 1

taylor_loop:
    ; Break if k >= n
    cmp r12, r13
    jge taylor_done

    ; Compute current term: current_term = prev_term * x / k
    movsd xmm0, xmm12        ; xmm0 = prev_term
    mulsd xmm0, xmm14        ; xmm0 *= x
    cvtsi2sd xmm1, r12       ; Convert k to double
    divsd xmm0, xmm1         ; xmm0 /= k
    movsd xmm12, xmm0        ; Update prev_term = current_term

    ; Add current term to sum
    addsd xmm13, xmm0        ; e^x += current_term

    ; Increment k (r12) and loop
    inc r12
    jmp taylor_loop

taylor_done:
    ; Move result to xmm0
    movsd xmm0, xmm13

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

section .data
one dq 1.0
