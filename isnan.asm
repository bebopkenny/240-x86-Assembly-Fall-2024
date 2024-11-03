global isnan

section .text
isnan:
    ; r12 contains the number to check (interpreted as a 64-bit double)
    mov         rax, r12                ; Copy the number to rax
    and         rax, 0x7FF0000000000000 ; Mask to extract the exponent bits
    cmp         rax, 0x7FF0000000000000 ; Check if exponent bits indicate NaN
    jne         not_nan                 ; If not equal, it’s not NaN

    ; Check if the fraction bits are non-zero (indicating NaN)
    mov         rax, r12                ; Copy the number to rax again
    and         rax, 0x000FFFFFFFFFFFFF ; Mask to extract the fraction bits
    test        rax, rax                ; Test if the fraction bits are non-zero
    jz          not_nan                 ; If zero, it’s not NaN

    ; The number is NaN
    mov         rax, 1                  ; Set rax to 1 to indicate NaN
    ret

not_nan:
    mov         rax, 0                  ; Set rax to 0 to indicate not NaN
    ret
