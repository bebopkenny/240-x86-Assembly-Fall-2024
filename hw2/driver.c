//Author information
//  Author name: Kenny Garcia
//  Author email: kennygarcia15@csu.fullerton.edu
//  Section: 03
//  CWID: 887930782

#include <stdio.h>

extern int isfloat();

extern double calc_average(); 

int main() {
    double average_speed;  // Variable to store the average speed

    printf("Welcome to Average Driving Time maintained by Kenny Garcia\n");
    
    average_speed = calc_average();  // Call the assembly function and capture the returned value
    
    // Print the returned value in the required format
    printf("The driver has received this number %.8lf and will keep it for future use. Have a great day.\n", average_speed);
    
    printf("A zero will be sent to the operating system as a signal of a successful execution.\n");
    
    return 0;
}

