#include "Indexer.h"
#include <iostream> // for std::cout
using namespace std; // for cout

/*
special member functions are using the `=default` and `=delete` attributes
they are in the `Indexer.h` file
*/
Indexer::Indexer() {
// todo
}

void Indexer::processTextFile(const std::string& filename) {
    if (! &filename) {
        cout << "error opening file!";
        return;
    } else {
        // index.clear();
    }
}

void Indexer::processToken(const char* test, int lineNumber) {
// todo
}

void Indexer::processToken(Token token, int lineNumber) {
// todo
}    


void Indexer::clear() {
    delete[] index;
}

bool Indexer::isEmpty() const {
    return index->isEmpty();
}

void Indexer::print(std::ostream& os) const {
// todo
}

void Indexer::displayAll() const {
    print(std::cout);
}

void Indexer::searchByLength(size_t length) const {
   for (size_t i = 0; i < NUM_SECTIONS; i++) {
// todo   
}
}

void Indexer::displaySection(char section) const {
// todo
}
