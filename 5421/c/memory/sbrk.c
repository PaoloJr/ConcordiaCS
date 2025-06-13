// using sbrk syscall
// more performant allocator in user-space that glibc
// not much granularity; can only slide the sbrk up etc.
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    // don't increment program break
    void *firstEnd = sbrk(0);
    printf("current program break: %p\n", firstEnd);

    // increment program break by 4096 bytes
    void *currentEnd = sbrk(0x1000);
    printf("new program break: %p\n", currentEnd);

    // use difference b/w firstEnd and currentEnd for an array
    int *myNewArray = (int*)firstEnd;

    myNewArray[100] = 2;
    myNewArray[101] = 3;
    myNewArray[102] = 4;

    printf("%d, %d, %d\n", myNewArray[100], myNewArray[101], myNewArray[102]);

}