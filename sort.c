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

#include <stdint.h>

// Function to sort an array of 64-bit floating-point numbers
void sort(double *array, int count) {
    int i, j;
    double temp;

    // Simple Bubble Sort implementation
    for (i = 0; i < count - 1; i++) {
        for (j = 0; j < count - i - 1; j++) {
            if (array[j] > array[j + 1]) {
                // Swap the elements
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}