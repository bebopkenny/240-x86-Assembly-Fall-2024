#!/bin/bash

echo "Compile the source file main.c"
gcc -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

echo "Assemble the source file executive.asm"
nasm -f elf64 -o executive.o executive.asm

echo "Assemble the source file fill_random_array.asm"
nasm -f elf64 -o fill_random_array.o fill_random_array.asm

echo "Assemble the source file isnan.asm"
nasm -f elf64 -o isnan.o isnan.asm

echo "Assemble the source file normalize_array.asm"
nasm -f elf64 -o normalize_array.o normalize_array.asm

echo "Assemble the source file show_array.asm"
nasm -f elf64 -o show_array.o show_array.asm

echo "Compile the source file sort.c"
gcc -m64 -Wall -no-pie -o sort.o -std=c2x -c sort.c

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o program.out main.o executive.o fill_random_array.o isnan.o normalize_array.o show_array.o sort.o -std=c2x -Wall -z noexecstack -lm

echo "Execute the program"
chmod +x program.out
./program.out

echo "This bash script will now terminate."

