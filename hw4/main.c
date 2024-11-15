#include <stdio.h>

extern char* executive();

int main() {
    printf("Welcome to Random Number Programmed by Code Goblin.\n");
    printf("Starting the executive function...\n");

    // Call executive and store the returned name
    char* name = executive();

    // Print the name in the final message
    printf("\nOh, %s. We hope you enjoyed your arrays. Do come again.\n", name);
    printf("A zero will be returned to the operating system.\n");

    return 0;
}

