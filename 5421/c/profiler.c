/*
gcc -g -pg -O0 profiler.c -o profiler -lm
gprofng collect app ./ELF
this will output to `test.[num].er/`
gprof display text test.[num].er/
*/
#include <stdio.h>
#include <math.h>

void heavy_computation() {
    double sum = 0;
    for (int i = 0; i < 10000000; i++) {
        sum += sqrt(i) * log(i+1);
    }
    printf("Result: %f\n", sum);
}

int main() {
    printf("Starting computation...\n");
    heavy_computation();
    printf("Finished computation.\n");
    return 0;
}