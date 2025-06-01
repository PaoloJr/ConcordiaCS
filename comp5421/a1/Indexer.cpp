#include "Indexer.h"
#include <fstream>
#include <sstream>
#include <iostream> // for std::cout
using namespace std; // for cout etc.


Indexer::Indexer() {
    cout << "Indexer: default ctor called, number of sections = " << NUM_SECTIONS << "\n";
}

/* 
other special member function have specifiers `= default` or `= delete`
they are in `Indexer.h` file
*/

void Indexer::processTextFile(const std::string& filename) {
    ifstream file(filename.c_str());

    if (!file.is_open()) {
        cerr << "error opening file: " << filename << "\n";
        exit(1);
    }

    clear();
    
    cout << "Indexing file: " << filename << "...\n";
    int lineNumber = 0;
    string line;
    // read file line by line
    while(getline(file, line)) {
        if (line.empty()) {
            lineNumber++;
            continue;
        }
        // stringstream for tokenization
        istringstream iss(line);
        string token;
        
        // extract tokens using whitespace delimiter
        while (iss >> token) {
            processToken(token.c_str(), lineNumber);
        }
        lineNumber++;
    }
    int linesProcessed = lineNumber;
    int tokensProcessed = getTokenCount();
    cout << "File indexed successfully " << "(" << linesProcessed << " lines, " << tokensProcessed << " tokens processed)\n";
    file.close();
}

void Indexer::processToken(const char* text, int lineNumber) {
    // skip empty tokens
    if (!text || text[0] == '\0') {
        return;
    }
    
    int sectionIndex;
    char firstChar = text[0];
    
    // get token's section (case-insensitive)
    if (isalpha(firstChar)) {
        sectionIndex = tolower(firstChar) - 'a';
    } else {
        sectionIndex = 26; // special chars section
    }
    
    // loop through the relevant section
    for (size_t i = 0; i < index[sectionIndex].size(); i++) {
        IndexedToken& existingToken = index[sectionIndex].getIndexedToken(i);
        
        /* 
        if token/text already exists, add line number and return
        if chars are equal (strcmp)
        */ 
        if (existingToken.compare(text) == 0) {
            existingToken.appendLineNumber(lineNumber);
            return;
        }

        /*
        if token/text does not already exist, create a new one and insert in sorted order
        if chars are not equal (strcmp)
         */
        if (existingToken.compare(text) > 0) {
            IndexedToken newToken(text, lineNumber);
            index[sectionIndex].addBefore(newToken, i);
            return;
        }
    }

    // add token/text at the end of the section
    IndexedToken newToken(text, lineNumber);
    index[sectionIndex].addBefore(newToken, index[sectionIndex].size());
}

void Indexer::processToken(Token token, int lineNumber) {
    if (token.length() == 0) {
        return;
    }

    // delegate to const char* overload
    processToken(token.c_str(), lineNumber);
} 

void Indexer::clear() {
    // loop through each DLList and call its clear()
    for (size_t i = 0; i < NUM_SECTIONS; i++) {
        index[i].clear();
    }
}

bool Indexer::isEmpty() const {
    // loop through each DLList and call its isEmpty()
    for (size_t i = 0; i < NUM_SECTIONS; i++) {
        // if any one DLList (section) is not empty, return false
        if (!index[i].isEmpty()) {
            return false;
        }
    }
    // all sections are empty
    return true;
}

void Indexer::print(std::ostream& os) const {
    os << "--- Complete Index --- {\n";
    bool found = false;

    for (size_t i = 0; i < NUM_SECTIONS; i++) {
        
        if (!index[i].isEmpty()) {
            char sectionChar;
            
            if (i < 26) {
                sectionChar = 'a' + i;                
            } else {
                sectionChar = '#';
            }

            if (found) {
                os << ",\n";
            }
            found = true;
            os << "--- Section '" << sectionChar << "' --- \n";
            // call each section's print method
            index[i].print(os);
        }
    }
    if (!found) {
        os << " (empty index)";
    }

    os << "\n";
}

void Indexer::displayAll() const {
    print(cout);
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
    char displayChar = section; // keep original for display
    
       // Use tolower() for case-insensitive section determination
    if (isalpha(section)) {
        sectionIndex = tolower(section) - 'a';
    } else {
        sectionIndex = 26; // special characters section
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

// added for token count
int Indexer::getTokenCount() const {
    int count = 0;
    for (size_t i = 0; i < NUM_SECTIONS; i++) {
        count += index[i].size();
    }
    return count;
}
