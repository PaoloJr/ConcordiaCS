// using mmap syscall
// asks kernel for any region of memory is accessible
// more granularity
// can suggest which region(s) to allocate
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

int main() {
    // NULL, 0x1000 - for requesting some number of bytes in any memory region
    // PROT_READ, PROT_WRITE - read and write (executable) protected
    // MAP_PRIVATE - copy on write protection
    // MAP_ANONYMOUS - memory comes back only to this process  
    void *newMemory = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
     if (NULL == newMemory) {
        perror("mmap: ");
        return -1;
     }

     printf("newly allocated memory %p\n", newMemory);

     int *myNewArray = (int*)newMemory;

     myNewArray[100] = 2;
     myNewArray[101] = 3;
     myNewArray[102] = 4;

     printf("%d, %d, %d\n", myNewArray[100], myNewArray[101], myNewArray[102]);

     // free memory
     munmap(newMemory, 0x1000);
}