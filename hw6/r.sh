#====================================================================================
# Program Name: "Electricity Resistance Calculator". 
# This program calculates the resistance in a direct current circuit using the formula
# Resistance = EMF / Current, based on user-provided inputs for EMF (voltage) and Current.
#
# Copyright (C) 2024  Kenny Garcia. 
#
# This program is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software Foundation,
# version 3 or (at your option) any later version.
#
# Electricity Resistance Calculator is distributed in the hope that it will be helpful,
# but WITHOUT ANY WARRANTY# without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for details.
#
# A copy of the GNU General Public License v3 can be found at: <https://www.gnu.org/licenses/>.
#====================================================================================
#
# Author Information:
#   Author Name: Kenny Garcia
#   Author Email: kennygarcia15@csu.fullerton.edu
#   CWID: 887930782
#   Class: 240 Section 05
#
# Program Information:
#   Program Name: Electricity Resistance Calculator
#   Programming Languages: Main module in x86 Assembly
#   Start Date: 2024-December-05
#   Last Updated: 2024-December-17
#   Files in the Program: driver.asm, faraday.asm, atof.asm, ftoa.asm, r.sh
#   Status: Complete and verified for functional accuracy
#
# Purpose:
#   This program calculates the resistance in a DC circuit using user-provided inputs
#   for the EMF (in volts) and the current (in amps). The program validates inputs, 
#   computes the resistance, and displays the results. It also outputs a message 
#   confirming the calculation and returns a zero status to the operating system.
#====================================================================================


#!/bin/bash

# Assemble driver.asm into an object file
nasm -f elf64 -o driver.o driver.asm

# Assemble faraday.asm into an object file
nasm -f elf64 -o faraday.o faraday.asm

# Assemble atof.asm (ASCII to Float conversion) into an object file
nasm -f elf64 -o atof.o atof.asm

# Assemble ftoa.asm (Float to ASCII conversion) into an object file
nasm -f elf64 -o ftoa.o ftoa.asm

# Link all object files into a single executable program
ld -o program.out driver.o faraday.o atof.o ftoa.o

# Make the output program executable
chmod +x program.out

# Run the program
./program.out

