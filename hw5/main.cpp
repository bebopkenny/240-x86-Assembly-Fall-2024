// ====================================================================================
// Program Name: "Taylor Series Approximation". 
// This program calculates the Taylor series expansion to approximate the exponential 
// function e^x using user-provided inputs for the base x and the number of terms.
//
// Copyright (C) 2024  Kenny Garcia. 
//
// This program is free software: you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the Free Software Foundation,
// version 3 or (at your option) any later version.
//
// Taylor Series Approximation is distributed in the hope that it will be helpful,
// but WITHOUT ANY WARRANTY// without even the implied warranty of MERCHANTABILITY
// or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for details.
//
// A copy of the GNU General Public License v3 can be found at: <https://www.gnu.org/licenses/>.
//====================================================================================
//
// Author Information:
//   Author Name: Kenny Garcia
//   Author Email: kennygarcia15@csu.fullerton.edu
//   CWID: 887930782
//   Class: 240 Section 05
//
// Program Information:
//   Program Name: Taylor Series Approximation
//   Programming Languages: Main module in C++, supporting modules in x86 Assembly
//   Start Date: 2024-November-24
//   Last Updated: 2024-November-25
//   Files in the Program: main.cpp, series.asm, taylor.asm, r.sh
//   Status: Complete and verified for functional accuracy
//
// Purpose:
//   This program computes the approximation of e^x using the Taylor series expansion
//   up to a specified number of terms. The result is calculated efficiently and 
//   execution time is measured in CPU clock ticks for performance evaluation.
//====================================================================================

#include <iostream>

extern "C" double series(double x, unsigned long n);

int main() {
    std::cout << "Welcome to Taylor Series by Kenny Garcia." << std::endl;
    std::cout << "This software will compute any power of e that you may need." << std::endl;

    series(0.0, 0); // Call series. Inputs and timing handled in assembly

    std::cout << "Good-bye." << std::endl;

    return 0;
}