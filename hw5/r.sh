# ====================================================================================
# Program Name: "Taylor Series Approximation". 
# This program calculates the Taylor series expansion to approximate the exponential 
# function e^x using user-provided inputs for the base x and the number of terms.
#
# Copyright (C) 2024  Kenny Garcia. 
#
# This program is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software Foundation,
# version 3 or (at your option) any later version.
#
# Taylor Series Approximation is distributed in the hope that it will be helpful,
# but WITHOUT ANY WARRANTY# without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for details.
#
# A copy of the GNU General Public License v3 can be found at: <https:#www.gnu.org/licenses/>.
#====================================================================================
#
# Author Information:
#   Author Name: Kenny Garcia
#   Author Email: kennygarcia15@csu.fullerton.edu
#   CWID: 887930782
#   Class: 240 Section 05
#
# Program Information:
#   Program Name: Taylor Series Approximation
#   Programming Languages: Main module in C++, supporting modules in x86 Assembly
#   Start Date: 2024-November-24
#   Last Updated: 2024-November-25
#   Files in the Program: main.cpp, series.asm, taylor.asm, r.sh
#   Status: Complete and verified for functional accuracy
#
# Purpose:
#   This program computes the approximation of e^x using the Taylor series expansion
#   up to a specified number of terms. The result is calculated efficiently and 
#   execution time is measured in CPU clock ticks for performance evaluation.
#====================================================================================

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

