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


global executive
extern fgets, printf, strlen, stdin, atoi, fill_random_array, show_array, normalize_array, sort

max_size equ 60

segment .data
    user_name db "Please enter your name: ", 0
    user_title db "Please enter your title (Mr, Ms, Sargent, Chief, Project Leader, etc): ", 0
    user_greeting db "Nice to meet you %s %s", 10, 10, 0
    prompt1 db "This program will generate 64-bit IEEE float numbers.", 10, 0
    prompt2 db "How many numbers do you want? Today’s limit is 100 per customer: ", 0
    prompt_array db "Your numbers have been stored in an array. Here is that array.", 10, 10, 0
    prompt_array_normalize db 10, "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array.", 10, 10, 0
    array_sorted db 10, "The array will now be sorted.", 10, 0  ; Added sorting message
    user_closing db "Goodbye %s. You are welcome any time.", 10, 0

segment .bss
    name resb max_size          ; Buffer to store the user's name
    title resb max_size         ; Buffer to store the user's title
    array_count resb max_size         ; Buffer to store the number input as a string
    randomize_array resq 100      ; Array to store up to 100 random numbers

segment .text
executive:
    ; Back up registers and set up the stack frame
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf                              ; Save flags

    ; Prompt for the user's name and read input
    mov rdi, user_name
    call printf                        ; Print "Please enter your name:"
    lea rdi, [name]              ; Load address of name buffer
    mov rsi, max_size                  ; Maximum size of input
    mov rdx, [stdin]                   ; Standard input file descriptor
    call fgets                         ; Read the user's name
    mov rdi, name
    call strlen                        ; Get the length of the name
    mov byte [name + rax - 1], 0 ; Replace newline with null terminator

    ; Prompt for the user's title and read input
    mov rdi, user_title
    call printf                        ; Print "Please enter your title:"
    lea rdi, [title]             ; Load address of title buffer
    mov rsi, max_size                  ; Maximum size of input
    mov rdx, [stdin]                   ; Standard input file descriptor
    call fgets                         ; Read the user's title
    mov rdi, title
    call strlen                        ; Get the length of the title
    mov byte [title + rax - 1], 0 ; Replace newline with null terminator

    ; Print the welcome message
    mov rdi, user_greeting
    mov rsi, title               ; Load the title for the message
    mov rdx, name                ; Load the name for the message
    call printf                        ; Print "Nice to meet you [Title] [Name]"

    ; Print the first instruction
    mov rdi, prompt1
    call printf                        ; Print the program's first instruction

    ; Prompt for the number of random numbers and read input
    mov rdi, prompt2
    call printf                        ; Print "How many numbers do you want?"
    lea rdi, [array_count]             ; Load address of array_count buffer
    mov rsi, max_size                  ; Maximum size of input
    mov rdx, [stdin]                   ; Standard input file descriptor
    call fgets                         ; Read the number input
    mov rdi, array_count
    call strlen                        ; Get the length of the input
    mov byte [array_count + rax - 1], 0 ; Replace newline with null terminator

    ; Convert the input string to an integer
    mov rdi, array_count
    call atoi                          ; Convert string to integer
    mov r15, rax                       ; Store the number in r15

    ; Print the first array message
    mov rdi, prompt_array
    call printf                        ; Print "Your numbers have been stored..."

    ; Generate random numbers and store them in the array
    mov rdi, randomize_array       ; Address of the array
    mov rsi, r15                       ; Number of random numbers to generate
    call fill_random_array             ; Fill the array with random numbers

    ; Display the array of random numbers
    mov rdi, randomize_array
    mov rsi, r15
    call show_array                    ; Print the array

    ; Normalize the array
    mov rdi, randomize_array
    mov rsi, r15
    call normalize_array               ; Normalize the numbers in the array

    ; Print the normalization message
    mov rdi, prompt_array_normalize
    call printf                        ; Print the message about normalization

    ; Display the normalized array
    mov rdi, randomize_array
    mov rsi, r15
    call show_array                    ; Print the normalized array

    ; Print the sorting message
    mov rdi, array_sorted
    call printf                        ; Print "The array will now be sorted"

    ; Sort the array
    mov rdi, randomize_array
    mov rsi, r15
    call sort                          ; Sort the array in ascending order

    ; Display the sorted array
    mov rdi, randomize_array
    mov rsi, r15
    call show_array                    ; Print the sorted array

    ; Print the goodbye message
    mov rdi, user_closing
    mov rsi, title               ; Load the user's title for the message
    call printf                        ; Print "Goodbye [Title]. You are welcome..."

    ; Restore registers
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ; Return the address of name
    lea rax, [name]
    ret