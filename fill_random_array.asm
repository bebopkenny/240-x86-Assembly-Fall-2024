; Program Title: "Random Float Array Processor". This software generates a set of 
; random floating-point numbers, scales them into the range from 1.0 to 2.0, 
; and sorts them in ascending order.
; © 2024 Kenny Garcia

; This file is part of the "Random Float Array Processor" project.

; This software is open-source and distributed under the GNU General Public License. 
; Redistribution and modification are allowed under the terms of the license. 
; The program is provided "as-is" without any warranties, express or implied.

; For more details, refer to the GNU General Public License at <https://www.gnu.org/licenses/>.

; Author Information:
;   Author Name: Kenny Garcia
;   Author Email: kennygarcia15@csu.fullerton.edu
;   Author Section: 240-05
;   Author CWID: 887930782

global fill_random_array
extern rdrand, isnan

segment .data
segment .bss
    align 64
    storedata resb 832

segment .text
fill_random_array:
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

    xor         r13, r13                        ; r13 keeps track of the index of the loop
    mov         r14, rdi                        ; rdi contains the address of the random_number_array
    mov         r15, rsi                        ; rsi contains the count of the random_number_array

fill_loop:
    ; If the index reaches the count, end the loop
    cmp         r13, r15
    jge         fill_finished

    ; Generate a random number and put it in r12
    rdrand      r12

    ; Call isnan to check if the number is NaN
    call        isnan
    cmp         rax, 1                          ; Check if isnan returned 1 (indicating NaN)
    je          fill_loop                       ; If NaN, regenerate the number

    ; Move the random number into the array
    mov         [r14 + r13 * 8], r12

    ; Increase the index and repeat the loop
    inc         r13
    jmp         fill_loop

fill_finished:
    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

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








