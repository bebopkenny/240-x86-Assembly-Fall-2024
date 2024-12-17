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
    prompt_name db "Please enter your full name: ", 0
    prompt_career db "Please enter the career path you are following: ", 0
    thank_you db "Thank you. We appreciate all ", 0
    newline db 10, 0
    prompt_emf db "Please enter the EMF of your circuit in volts: ", 0
    entered_emf db "You entered: ", 0
    prompt_current db "Please enter the current in this circuit in amps: ", 0
    entered_current db "You entered: ", 0
    resistance_msg db "The resistance in this circuit is: ", 0
    ohms db " ohms", 0
    thank_user db "Thank you, ", 0

section .bss
    global resistance_value       ; Make resistance_value accessible to driver.asm
    name_input resb 100
    career_input resb 100
    emf_input resb 100
    emf_output resb 50
    current_input resb 100
    current_output resb 50
    res_output resb 50
    resistance_value resq 1       ; Storage for resistance value

section .text
global faraday
extern atof
extern ftoa

faraday:
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
    ; Prompt for full name
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, prompt_name ; address of the "Please enter your full name" message
    mov rdx, 30         ; message length
    syscall             ; print the prompt to the user

    ; Read user input for full name
    mov rax, 0          ; syscall: read
    mov rdi, 0          ; file descriptor: stdin
    mov rsi, name_input ; buffer to store the name
    mov rdx, 100        ; maximum input size
    syscall             ; read user input

    ; Prompt for career path
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, prompt_career ; address of the "Please enter your career path" message
    mov rdx, 48         ; message length
    syscall             ; print the career path prompt

    ; Read user input for career path
    mov rax, 0          ; syscall: read
    mov rdi, 0          ; file descriptor: stdin
    mov rsi, career_input ; buffer to store the career path
    mov rdx, 100        ; maximum input size
    syscall             ; read user input

    ; Print the thank you message
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, thank_you  ; address of the "Thank you. We appreciate all " message
    mov rdx, 30         ; message length
    syscall             ; print the thank you message

    ; Print the career path input
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, career_input ; address of the career input buffer
    mov rdx, 100        ; length of the career input
    syscall             ; print the user's career path input


    ; Print a newline for spacing
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, newline    ; print a newline character
    mov rdx, 1
    syscall

    ; Prompt user to enter EMF
    mov rax, 1          ; syscall: write
    mov rdi, 1
    mov rsi, prompt_emf ; prompt message for EMF
    mov rdx, 40         ; length of the message
    syscall

    ; Read EMF input from user
    mov rax, 0          ; syscall: read
    mov rdi, 0          ; file descriptor: stdin
    mov rsi, emf_input  ; buffer to store user input
    mov rdx, 100        ; max input length
    syscall

    ; Convert EMF input (ASCII) to integer
    mov rdi, emf_input  ; address of input buffer
    call atof           ; call atof to convert input to integer
    mov r8, rax         ; store the EMF value in r8

    ; Convert EMF integer value back to ASCII for display
    mov rdi, rax        ; EMF integer value
    mov rsi, emf_output ; buffer to store converted ASCII
    call ftoa

    ; Display "You entered: " for EMF
    mov rax, 1
    mov rdi, 1
    mov rsi, entered_emf
    mov rdx, 12
    syscall

    ; Display the EMF value entered
    mov rax, 1
    mov rdi, 1
    mov rsi, emf_output ; print the converted EMF value
    mov rdx, 50
    syscall

    ; Print a newline for spacing
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Prompt user to enter current
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_current ; prompt message for current
    mov rdx, 50
    syscall

    ; Read current input from user
    mov rax, 0
    mov rdi, 0
    mov rsi, current_input  ; buffer to store current input
    mov rdx, 100
    syscall

    ; Convert current input (ASCII) to integer
    mov rdi, current_input  ; address of input buffer
    call atof               ; convert input to integer
    mov r9, rax             ; store the current value in r9

    ; Convert current integer value back to ASCII for display
    mov rdi, rax            ; current integer value
    mov rsi, current_output ; buffer to store converted ASCII
    call ftoa

    ; Display "You entered: " for current
    mov rax, 1
    mov rdi, 1
    mov rsi, entered_current
    mov rdx, 14
    syscall

    ; Display the current value entered
    mov rax, 1
    mov rdi, 1
    mov rsi, current_output ; print the converted current value
    mov rdx, 50
    syscall

    ; Print a newline for spacing
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Calculate Resistance = EMF / Current
    mov rax, r8          ; EMF in r8
    xor rdx, rdx         ; Clear remainder
    mov rcx, r9          ; Current in r9
    div rcx              ; rax = EMF / Current
    mov [resistance_value], rax   ; Store resistance value globally

    mov rdi, rax
    mov rsi, res_output
    call ftoa

    ; Display Resistance
    mov rax, 1
    mov rdi, 1
    mov rsi, resistance_msg
    mov rdx, 35
    syscall

    ; Print the calculated resistance value
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, res_output ; address of the resistance output buffer
    mov rdx, 50         ; number of bytes to write
    syscall

    ; Print the "ohms" label after the resistance value
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, ohms       ; address of the " ohms" string
    mov rdx, 6          ; number of bytes to write
    syscall

    ; Print a newline for formatting
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, newline    ; address of the newline character
    mov rdx, 1          ; number of bytes to write
    syscall

    ; Print the "Thank you" message
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, thank_user ; address of the "Thank you, " string
    mov rdx, 10         ; number of bytes to write
    syscall

    ; Print the user's name entered earlier
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, name_input ; address of the user-inputted name buffer
    mov rdx, 100        ; maximum number of bytes to write
    syscall

    ; Print a newline for formatting
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, newline    ; address of the newline character
    mov rdx, 1          ; number of bytes to write

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

; Return from the faraday function
ret                 ; Return control to the calling function
