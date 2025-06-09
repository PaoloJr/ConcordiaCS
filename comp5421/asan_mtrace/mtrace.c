#include <stdio.h>
#include <stdlib.h>
#include <mcheck.h>
int main() {
    char *string;
    /*
    mtrace is the very first line of execution in main
    declarations can be before mtrace
    */ 
    mtrace(); 
    string = malloc(100 * sizeof(char));
    return 0;
}