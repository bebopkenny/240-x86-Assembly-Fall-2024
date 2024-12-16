section .text
global atof
atof:
    mov rax, 0               ; Initialize the result to 0
    ; Parse the string in RDI (should include parsing logic)
    ; Example: Convert "4.3" to float
    ; Temporary: Set xmm0 to 4.3 directly for debugging
    mov rax, 0x4010C00000000000 ; 4.3 in IEEE-754 format
    movq xmm0, rax
    ret










; ;********************************************************************
; ; Program name: atof
; ; Description: Converts an ASCII string to a floating-point number
; ; Function Prototype: double atof(const char* str);
; ; Input: 
; ;   rdi - Address of the input string
; ; Output: 
; ;   xmm0 - Floating-point value represented by the string
; ;********************************************************************

; global atof
; section .data
;     ten dq 10.0          ; Constant 10.0 for division/multiplication
;     neg_one dq -1.0      ; Constant -1.0 for sign handling
;     zero dq 0.0          ; Constant 0.0 for initialization

; section .bss
; ; No uninitialized data needed

; section .text
; atof:
;     push rbp                 ; Save base pointer
;     mov rbp, rsp             ; Establish stack frame
;     xor rax, rax             ; Clear rax
;     xor rcx, rcx             ; Counter for decimals
;     movsd xmm0, qword [zero] ; Initialize xmm0 to 0.0 (final result)
;     movsd xmm1, qword [ten]  ; Load constant 10.0 into xmm1
;     mov rsi, rdi             ; Copy address of the string to rsi
;     xor rdx, rdx             ; Clear rdx for sign flag (0 = positive, 1 = negative)

; ;===== Step 1: Skip leading spaces =====
; skip_spaces:
;     mov al, byte [rsi]       ; Load the current character
;     cmp al, ' '              ; Compare with space
;     jne check_sign
;     inc rsi                  ; Move to the next character
;     jmp skip_spaces

; ;===== Step 2: Check for a sign =====
; check_sign:
;     mov al, byte [rsi]       ; Load the current character
;     cmp al, '-'              ; Is it a minus sign?
;     jne check_plus
;     mov rdx, 1               ; Set sign flag to negative
;     inc rsi                  ; Move to the next character
;     jmp parse_integer
; check_plus:
;     cmp al, '+'              ; Is it a plus sign?
;     jne parse_integer
;     inc rsi                  ; Move to the next character

; ;===== Step 3: Parse the integer part =====
; parse_integer:
;     mov al, byte [rsi]       ; Load the current character
;     cmp al, '0'              ; Check if character is less than '0'
;     jl check_decimal
;     cmp al, '9'              ; Check if character is greater than '9'
;     jg check_decimal

;     sub al, '0'              ; Convert ASCII to integer (0-9)
;     cvtsi2sd xmm2, rax       ; Convert integer to double in xmm2
;     mulsd xmm0, xmm1         ; Multiply current result by 10.0
;     addsd xmm0, xmm2         ; Add the new digit to the result
;     inc rsi                  ; Move to the next character
;     jmp parse_integer

; ;===== Step 4: Parse the decimal part =====
; check_decimal:
;     cmp byte [rsi], '.'      ; Check for a decimal point
;     jne apply_sign           ; No decimal point, proceed to sign
;     inc rsi                  ; Move past the decimal point

; parse_fraction:
;     mov al, byte [rsi]       ; Load the current character
;     cmp al, '0'              ; Check if character is less than '0'
;     jl apply_sign
;     cmp al, '9'              ; Check if character is greater than '9'
;     jg apply_sign

;     sub al, '0'              ; Convert ASCII to integer
;     cvtsi2sd xmm2, rax       ; Convert to double
;     divsd xmm2, xmm1         ; Divide by 10^n (incrementally)
;     addsd xmm0, xmm2         ; Add to the result
;     mulsd xmm1, qword [ten]  ; Multiply xmm1 by 10 for next decimal place
;     inc rsi                  ; Move to the next character
;     jmp parse_fraction

; ;===== Step 5: Apply the sign =====
; apply_sign:
;     cmp rdx, 1               ; Check if the number is negative
;     jne done
;     movsd xmm2, qword [neg_one]
;     mulsd xmm0, xmm2         ; Multiply by -1 to apply the sign

; ;===== Step 6: Return result =====
; done:
;     pop rbp                  ; Restore base pointer
;     ret
