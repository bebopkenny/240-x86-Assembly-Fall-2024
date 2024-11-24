#include <iostream>

extern "C" void series();  // Declare the series function (written in assembly)

int main() {
    // Greeting message
    std::cout << "Welcome to Taylor Series by Kenny Garcia" << std::endl;

    // Call the series function
    series();

    // Exit message
    std::cout << "Goodbye!" << std::endl;

    return 0;
}
