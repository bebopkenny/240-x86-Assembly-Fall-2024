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

global isnan

segment .text
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
