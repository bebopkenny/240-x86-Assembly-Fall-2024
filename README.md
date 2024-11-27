# 240 x86 Assembly - Fall 2024  

**Open-source repository for CPSC 240 x86 Assembly homework assignments, providing helpful resources and examples for future students, especially those taking Professor Holliday's class.**

---

## Table of Contents

- [Introduction](#introduction)
- [Homework Assignments](#homework-assignments)
  - [Assignment 1: Hello World Program](#assignment-1-hello-world-program)
  - [Assignment 2: Average Driving Time](#assignment-2-average-driving-time)
  - [Assignment 3: Arrays](#assignment-3-arrays)
  - [Assignment 4: Non-deterministic Random Numbers](#assignment-4-non-deterministic-random-numbers)
  - [Assignment 5: Execution Speed](#assignment-5-execution-speed)
  - [Assignment 6: Pure Assembly](#assignment-6-pure-assembly)
- [License](#license)

---

## Introduction

Welcome to the **CPSC 240 x86 Assembly** repository! This repository serves as a resource hub for students taking Professor Holliday's class at Cal State Fullerton. Each assignment showcases essential assembly programming concepts, implemented in a hybrid of assembly, C++, and bash scripting. This repository aims to help future students understand x86 programming through practical, real-world examples.

---

## Homework Assignments

### Assignment 1: Hello World Program

**Preface**  
This assignment welcomes you to x86 Assembly Programming. It focuses on handling strings in x86 by creating a simple program where the user inputs their name, and the program says "Hello" to them.  

**Structure**  
- **welcome.cpp**: Manages user interaction.  
- **hello.asm**: Handles the logic of the greeting in x86.  
- **r.sh**: A bash script to compile and execute the program.  

---

### Assignment 2: Average Driving Time

**Prologue**  
This program calculates the average speed of a delivery van servicing a route between Fullerton, Santa Ana, and Long Beach. It introduces handling arithmetic operations in assembly language.  

**Highlights**  
- Process time and distance to calculate average speed.  
- A focus on modular programming and professional-grade code structure.  

---

### Assignment 3: Arrays

**Preface**  
This assignment dives deeper into key programming concepts:  
- Creating and manipulating arrays.  
- Implementing iteration.  
- Writing professional-grade programs.  

**Structure**  
- **main.cpp**: Manages program flow.  
- **manager.asm**: Oversees array processing.  
- **input_array.asm, display_array.asm, sum_array.asm**: Handle array input, display, and summation.  

**Special Notes**  
The program requires a polished and professional format. Make sure the program compiles and executes seamlessly with a bash script.  

---

### Assignment 4: Non-deterministic Random Numbers

**Goals**  
Learn how to generate truly random numbers using the `rdrand` instruction in x86. The program restricts random numbers to a specific range and validates them.  

**Purpose**  
- Generate up to 100 random numbers.  
- Filter out invalid numbers, such as `NaN`.  
- Scale random numbers within defined intervals.  

---

### Assignment 5: Execution Speed

**Goals**  
Measure the execution time of assembly functions, exploring CPU frequency and clock cycles.  

**Project Highlights**  
- Compute an approximation of \(e^x\) using the Taylor series:  
  \[
  e^x = \sum_{n=0}^{N} \frac{x^n}{n!}
  \]  
- Function `series` handles user input and timing, calling the `taylor` function to compute results.  
- The `taylor` function is highly modular and cohesive, making it reusable for future programs.  

**Bonus**  
Convert execution time (in clock cycles) to nanoseconds for extra credit.  

---

### Assignment 6: Pure Assembly

**Introduction**  
This assignment focuses on programming in **pure assembly**—developing software without the support of higher-level languages like C or C++.  

**Application Purpose**  
Compute the resistance (\(R\)) in an electric circuit using the formula:  
\[
R = \frac{F}{I}
\]  
Where:  
- \(F\) is the Electromotive Force (EMF) in Volts.  
- \(I\) is the Current in Amps.  

**Key Features**  
- Input EMF (\(F\)) and Current (\(I\)).  
- Output Resistance (\(R\)).  

**Educational Purpose**  
- Gain hands-on experience with **pure assembly** concepts.  
- Utilize **macros** to reduce repetitive code.  

**Macro Benefits**  
- Avoids activation records and `ret` instructions.  
- Efficient for reusing blocks of assembly code.  

**Suggestions**  
Experiment with macros to implement one of the following standard functions: `atof`, `ftoa`, or `strlen`. This will deepen your understanding of macros and their flexibility.  

---

## License

This repository is licensed under **GPL-3.0** for the overall program, with library functions carrying the **LGPL-3.0** license to ensure reusability in other projects.

---

**Feel free to fork, explore, and contribute to this repository! Happy coding!**  
