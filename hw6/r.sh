#!/bin/bash

nasm -f elf64 -o driver.o driver.asm
nasm -f elf64 -o faraday.o faraday.asm
nasm -f elf64 -o atof.o atof.asm
nasm -f elf64 -o ftoa.o ftoa.asm
nasm -f elf64 -o strlen.o strlen.asm

ld -o program.out driver.o faraday.o atof.o ftoa.o strlen.o -lc --dynamic-linker=/lib64/ld-linux-x86-64.so.2

chmod +x program.out
./program.out
