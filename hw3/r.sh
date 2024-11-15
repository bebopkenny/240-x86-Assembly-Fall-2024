#!/bin/bash

# Author: Kenny Garcia
# Program name: manager Driving Time
# Purpose: Calculate the manager speed and milage

echo "Remove old executable files if there are any"
rm -f *.out *.o *.lis  # Clean up old object files and listing files

echo "Assemble the source file sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Assemble the X86 file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Compile the C file main.c"
gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.c

echo "Compile the C++ file sort.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l sort.lis -o sort.o sort.cpp -std=c++2a

echo "Assemble the X86 file output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Assemble the X86 file input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the X86 file isinteger.asm"  # Add this line
nasm -f elf64 -l isinteger.lis -o isinteger.o isinteger.asm  # Add this line

echo "Link all object files"
gcc -m64 -o go.out manager.o main.o sum.o input_array.o output_array.o sort.o isinteger.o -fno-pie -no-pie  # Include isinteger.o

echo "Next the program 'manager Driving Time' will run"
./go.out