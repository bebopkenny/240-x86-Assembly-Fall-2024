#!/bin/bash

# Author: Kenny Garcia
# Program name: Average Driving Time
# Purpose: Calculate the average speed and milage

echo "Remove old executable files if there are any"
rm -f *.out *.o *.lis  # Added to clean up object files and listing files

echo "Assemble the X86 file average.asm"
nasm -f elf64 -l average.lis -o average.o average.asm

echo "Compile the C file driver.c"
gcc -c -m64 -Wall -fno-pie -no-pie -o driver.o driver.c

echo "Link the two 'O' files driver.o average.o"
gcc -m64 -o go.out average.o driver.o -fno-pie -no-pie

echo "Next the program 'Average Driving Time' will run"
./go.out