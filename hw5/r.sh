#!/bin/bash

echo "Assemble the source file series.asm"
nasm -f elf64 -l series.lis -o series.o series.asm

echo "Assemble the source file taylor.asm"
nasm -f elf64 -l taylor.lis -o taylor.o taylor.asm

echo "Compile the source file main.cpp"
g++ -m64 -Wall -no-pie -o main.o -std=c++20 -c main.cpp

echo "Link the object modules to create an executable file"
g++ -m64 -no-pie -o taylor_series.out series.o taylor.o main.o -std=c++20 -Wall -z noexecstack -lm

echo "Execute the program"
chmod +x taylor_series.out
./taylor_series.out

echo "This bash script will now terminate."

