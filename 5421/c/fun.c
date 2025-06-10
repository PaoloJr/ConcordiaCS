#include <stdio.h>
#include<unistd.h>
#include<string.h>

int main() {
    char hello[] = "Hello World";
    char newl[]  = "newline below";
    char sysc[] = "syscall\n";
    printf("%s_first\n", hello);
    // for buffer flush immediately
    fflush(stdout);
    /*
        0 = STDIN
        1 = STDOUT
        2 = STDERR
    */
    write(1, sysc, 8);
    write(1, hello, strlen(hello)); 
    write(1, "\n", 1);
    write(1, newl, strlen(newl));
    write(1, "\n", 1);
    return 0;
}