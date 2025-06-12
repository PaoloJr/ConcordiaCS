#include <iostream>
#include "IndexerUI.h"
// #include <mcheck.h>

// void test_asan() {
    // int* array = new int[10];
    // array[10000] = 123;  // out-of-bounds access
    // std::cout << "Testing ASAN, value: " << array[9] << std::endl;
    // delete[] array;
    // int *ptr = new int(42);
    // delete ptr;
    // *ptr = 100; // use after free
// }

int main () {
    std::cout << "Starting Text File Indexer\n";
    // mtrace();
    // test_asan();
    // create the main application object
    IndexerUI indexer_ui;
    // start application loop
    indexer_ui.run();
    std::cout << "Program finished. \n";
    // exit successfully
    return 0;
}