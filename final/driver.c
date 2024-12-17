// Author name: Kenny Garcia
// Author email: kennygarcia15@csu.fullerton.edu
// Course and section: CPSC240-5
// Today’s date: Dec 17, 2024

#include <stdio.h>

extern double manager();

int main() {
    printf("Welcome to the Variance Calculator by Kenny Garcia!\n");

    double variance = manager();
    printf("The variance of the dataset is: %.5lf\n", variance);

    printf("A zero will be returned to the operating system.\n");
    return 0;
}
