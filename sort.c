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