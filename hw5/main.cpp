#include <iostream>

extern "C" double series(double x, unsigned long n);

int main() {

    series(0.0, 0);  // Call series. Inputs and timing handled in assembly.;

    return 0;
}