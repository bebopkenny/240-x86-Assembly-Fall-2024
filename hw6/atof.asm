;====================================================================================
; Program Name: "Electricity Resistance Calculator". 
; This program calculates the resistance in a direct current circuit using the formula
; Resistance = EMF / Current, based on user-provided inputs for EMF (voltage) and Current.
;
; Copyright (C) 2024  Kenny Garcia. 
;
; This program is free software: you can redistribute it and/or modify it under the
; terms of the GNU General Public License as published by the Free Software Foundation,
; version 3 or (at your option) any later version.
;
; Electricity Resistance Calculator is distributed in the hope that it will be helpful,
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
;   Program Name: Electricity Resistance Calculator
;   Programming Languages: Main module in x86 Assembly
;   Start Date: 2024-December-05
;   Last Updated: 2024-December-17
;   Files in the Program: driver.asm, faraday.asm, atof.asm, ftoa.asm, r.sh
;   Status: Complete and verified for functional accuracy
;
; Purpose:
;   This program calculates the resistance in a DC circuit using user-provided inputs
;   for the EMF (in volts) and the current (in amps). The program validates inputs, 
;   computes the resistance, and displays the results. It also outputs a message 
;   confirming the calculation and returns a zero status to the operating system.
;====================================================================================

section .text
global atof

atof:
push       rbp                          ;Save a copy of the stack base pointer
mov        rbp, rsp                     ;We do this in order to be fully compatible with C and C++.
push       rbx                          ;Back up rbx
push       rcx                          ;Back up rcx
push       rdx                          ;Back up rdx
push       rsi                          ;Back up rsi
push       rdi                          ;Back up rdi
push       r8                           ;Back up r8
push       r9                           ;Back up r9
push       r10                          ;Back up r10
push       r11                          ;Back up r11
push       r12                          ;Back up r12
push       r13                          ;Back up r13
push       r14                          ;Back up r14
push       r15                          ;Back up r15
pushf  
    xor rax, rax              ; Clear rax for the result
    xor rcx, rcx              ; Reset digit index

parse_loop:
    movzx rdx, byte [rdi + rcx] ; Load character
    cmp rdx, 0                ; Check for null terminator
    je done_parsing           ; Exit loop if null terminator
    cmp rdx, '.'              ; Check for decimal point
    je done_parsing           ; Stop parsing at decimal point
    sub rdx, '0'              ; Convert ASCII to integer
    cmp rdx, 9                ; Validate digit (0-9)
    ja done_parsing           ; Exit if invalid digit
    imul rax, rax, 10         ; Multiply result by 10
    add rax, rdx              ; Add current digit
    inc rcx                   ; Move to the next character
    jmp parse_loop

done_parsing:
popf                                            ;Restore rflags
pop        r15                                  ;Restore r15
pop        r14                                  ;Restore r14
pop        r13                                  ;Restore r13
pop        r12                                  ;Restore r12
pop        r11                                  ;Restore r11
pop        r10                                  ;Restore r10
pop        r9                                   ;Restore r9
pop        r8                                   ;Restore r8
pop        rdi                                  ;Restore rdi
pop        rsi                                  ;Restore rsi
pop        rdx                                  ;Restore rdx
pop        rcx                                  ;Restore rcx
pop        rbx                                  ;Restore rbx
pop        rbp                                  ;Restore rbp
ret
