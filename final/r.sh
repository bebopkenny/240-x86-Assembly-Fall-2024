# Author name: Kenny Garcia
# Author email: kennygarcia15@csu.fullerton.edu
# Course and section: CPSC240-5
# Today’s date: Dec 17, 2024

#!/bin/bash

echo "Assembling the manager.asm file..."
nasm -f elf64 -o manager.o manager.asm

echo "Assembling the variance.asm file..."
nasm -f elf64 -o variance.o variance.asm

echo "Compiling the driver.c file..."
gcc -c -m64 -Wall -no-pie -o driver.o driver.c

echo "Linking all object files to create an executable..."
gcc -m64 -no-pie -o final_program.out manager.o variance.o driver.o -lm

echo "Running the program..."
chmod +x final_program.out
./final_program.out

echo "This script will now terminate."

