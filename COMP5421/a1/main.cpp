#include <iostream>
#include "IndexerUI.h"

int main () {
    std::cout << "Starting Text File Indexer\n";
    // create the main application object
    IndexerUI indexer_ui;
    // start application loop
    indexer_ui.run();
    std::cout << "Program finished. \n";
    // exit successfully
    return 0;
}

