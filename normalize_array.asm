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

global normalize_array
extern rdrand

segment .data 
segment .bss
    align 64
    storedata resb 832
segment .text
normalize_array:
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

normalize_loop:
    ; If the index reach the count, end the loop
    cmp         r13, r15
    jge         normalize_finished

    ; Normalize an element of the array
    mov         r12, [r14 + r13 * 8]            ; Temporary copy the element into r12.                  0x9c75b07eadac83b9 
    shl         r12, 12                         ; Shift the hex number 3 place to the left.             0x5b07eadac83b9 
    shr         r12, 12                         ; Shift the hex number 3 place to the right.            0x0005b07eadac83b9 
    mov         rax, 0x3FF0000000000000          
    or          r12, rax                        ; OR the hex number with the mask
    mov         [r14 + r13 * 8], r12            ; Move the normalized hex number back into the array    0x3ff5b07eadac83b9

    ; Inrease the index and repeat the loop
    inc         r13      
    jmp         normalize_loop

normalize_finished:
    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ;Restore the original values to the GPRs
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