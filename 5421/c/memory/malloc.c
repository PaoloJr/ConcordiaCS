// using malloc (glibc) user-space allocator
// complex linked-list structure backend
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    // get 1024 bytes
    char* myHeap = malloc(1024);

    // if memory is returned, write some string to it
    if (NULL != myHeap) {
        strcpy(myHeap, "\nHello there, memory!\n");
    }
    // %p for pointer format
    printf("%p", myHeap);
    // %s for string format
    printf("%s", myHeap);
    // give back to allocator 
    free(myHeap);
    return 0;
}