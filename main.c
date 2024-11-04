// Program Title: "Random Float Array Processor". This software generates a set of 
// random floating-point numbers, scales them into the range from 1.0 to 2.0, 
// and sorts them in ascending order.
// © 2024 Kenny Garcia

// This file is part of the "Random Float Array Processor" project.

// This software is open-source and distributed under the GNU General Public License. 
// Redistribution and modification are allowed under the terms of the license. 
// The program is provided "as-is" without any warranties, express or implied.

// For more details, refer to the GNU General Public License at <https://www.gnu.org/licenses/>.

// Author Information:
//   Author Name: Kenny Garcia
//   Author Email: kennygarcia15@csu.fullerton.edu
//   Author Section: 240-05
//   Author CWID: 887930782

#include <stdio.h>

extern char* executive();

int main() {
    printf("Welcome to Random Products, LLC.\n");
    printf("This software is maintained by Kenny Garcia\n");

    // Call executive and store the returned name
    char* name = executive();

    // Print the name in the final message
    printf("\nOh, %s. We hope you enjoyed your arrays. Do come again.\n", name);
    printf("A zero will be returned to the operating system.\n");

    return 0;
}

