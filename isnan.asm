global isnan

section .text
isnan:
    ; r12 contains the number to check (interpreted as a 64-bit double)
    movq        xmm0, r12               ; Move the 64-bit integer in r12 to xmm0 (floating-point register)
    ucomisd     xmm0, xmm0              ; Compare xmm0 with itself (unordered comparison)

    ; Check if the comparison is unordered (indicating NaN)
    jp          nan_detected            ; Jump if parity flag is set (indicates unordered comparison)

    ; The number is not NaN
    mov         rax, 0                  ; Set rax to 0 to indicate not NaN
    ret

nan_detected:
    mov         rax, 1                  ; Set rax to 1 to indicate NaN
    ret
