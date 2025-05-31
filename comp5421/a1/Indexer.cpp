#include "Indexer.h"
#include <iostream> // for std::cout
using namespace std; // for cout

Indexer::Indexer() {
    cout << "Indexer: default ctor called, number of sections = " << NUM_SECTIONS << "\n";
}

/* 
other special member function have specifiers `= default` or `= delete`
they are in `Indexer.h` file
*/

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

// loop every token of every section --> O(n^2)
void Indexer::searchByLength(size_t length) const {
    cout << "Tokens of length: " << length << ":\n";
    bool found = false;

    // sections loop
   for (size_t i = 0; i < NUM_SECTIONS; i++) {
        if (!index[i].isEmpty()) {
            // tokens loop
            for (size_t j = 0; j < index[i].size(); j++) {
                const IndexedToken& token = index[i].getIndexedToken(j);

                // length check
                if (token.getToken().length() == length) {
                    token.print(cout);
                    cout << "\n";
                    found = true;
                }
            }
        }
    }
    if (!found) {
        cout << "No tokens of length " << length << " found\n";
    }
}

// direct access O(1)
void Indexer::displaySection(char section) const {
    // calculate section index (0-25 for a-z/A-Z, 26 for other)
    int sectionIndex;
    char displayChar;
    
    if (section >= 'a' && section <= 'z') {
        sectionIndex = section - 'a';
        displayChar = section;
    } else if (section >= 'A' && section <= 'Z') {
        sectionIndex = section - 'A';
        displayChar = section;
    } else {
        sectionIndex = 26;
        displayChar = '#';
    }
    
    if (sectionIndex < 0 || sectionIndex >= NUM_SECTIONS) {
        cout << "Invalid section: " << section << "\n";
        return;
    }

    // section header
    cout << "===== Section '" << displayChar << "' =====\n";

    if (index[sectionIndex].isEmpty()) {
        cout << "No tokens in this section\n";
    } else {
        index[sectionIndex].print(cout);
    }

}
