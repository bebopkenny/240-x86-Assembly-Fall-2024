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

section .data
    msg1 db "Welcome to Electricity brought to you by Henry Finkelstein.", 0xA, 0
    msg2 db "This program will compute the resistance in your direct current circuit.", 0xA, 0
    msg_driver db "The driver received this number ", 0
    msg_last db ", and will keep it until next semester.", 0xA, 0
    msg_zero db "A zero will be returned to the Operating System", 0xA, 0

section .bss
    res_driver_output resb 50  ; Buffer to hold formatted resistance output

section .text
    global _start
    extern faraday
    extern ftoa               ; Ensure ftoa is declared

    extern resistance_value   ; Import resistance_value from faraday.asm

_start:
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
    ; Print the first message
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, 68
    syscall

    ; Print the second message
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, 100
    syscall

    ; Call the faraday function
    call faraday

    ; Convert resistance_value to string using ftoa
    mov rax, [resistance_value]  ; Load resistance_value
    mov rdi, rax                ; Move it to rdi for ftoa
    mov rsi, res_driver_output  ; Buffer to store the string
    call ftoa                   ; Convert to string

    ; Print "The driver received this number "
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_driver
    mov rdx, 36
    syscall

    ; Print the formatted resistance value
    mov rax, 1
    mov rdi, 1
    mov rsi, res_driver_output
    mov rdx, 50
    syscall

    ; Print ", and will keep it until next semester."
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_last
    mov rdx, 43
    syscall

    ; Print "A zero will be returned..."
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_zero
    mov rdx, 49
    syscall

    ; Exit program
    mov rax, 60
    xor rdi, rdi

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
syscall








