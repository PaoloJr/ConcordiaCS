#include "Indexer.h"
#include <fstream>
#include <sstream>
#include <iostream> // for std::cout
using namespace std; // for cout etc.


Indexer::Indexer() {
    // DEBUG
    // cout << "Indexer: default ctor called, number of sections = " << NUM_SECTIONS << "\n";
}

/* 
other special member function have specifiers `= default` or `= delete`
they are in `Indexer.h` file
*/

void Indexer::processTextFile(const std::string& filename) {
    ifstream file(filename.c_str());

    if (!file.is_open()) {
        cerr << "File did not open: " << filename << "\n";
        return;
    }

    clear();
    
    cout << "Indexing file: " << filename << "...\n";
    int lineNumber = 1;
    int lineCount = 0;
    string line;
    
    // read file line by line
    while(getline(file, line)) {
        if (line.empty()) {
            lineNumber++;
            lineCount++;
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
        lineCount++;
    }
    int linesProcessed = lineCount;
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
    os << "\n===== Complete Index =====\n\n";
    bool found = false;

    for (size_t i = 0; i < NUM_SECTIONS; i++) {    
        if (!index[i].isEmpty()) {
            char sectionChar;
            
            if (i < 26) {
                sectionChar = toupper('a') + i;                
            } else {
                sectionChar = '#';
            }

            if (found) {
                os << "\n";
            }
            found = true;
            os << "----- Section '" << sectionChar << "' ----- \n";
            // call each section's print method
            index[i].print(os);
        }
    }
    if (!found) {
        os << " (empty index)";
    }

    os << "\n===== Done =====\n";
}

void Indexer::displayAll() const {
    print(cout);
}

// loop every token of every section --> O(n^2)
void Indexer::searchByLength(size_t length) const {
    cout << "\n===== Tokens of length " << length << " =====\n";
    bool found = false;

    // sections loop
   for (size_t i = 0; i < NUM_SECTIONS; i++) {
        if (!index[i].isEmpty()) {
            // tokens loop
            for (size_t j = 0; j < index[i].size(); j++) {
                const IndexedToken& token = index[i].getIndexedToken(j);

                size_t tokenLength = token.getToken().length();

                // DEBUG char ASCII values    
                // if (tokenLength >= 8 && tokenLength <= 10) {
                //     cout << "Debug - Token: '";
                //     // Print each character and its ASCII value
                //     for (size_t k = 0; k < tokenLength; k++) {
                //         char c = token.getToken().c_str()[k];
                //         cout << c << "(" << (int)c << ")";
                //     }
                //     cout << "', Length: " << tokenLength << "\n";
                // }
               
                // length check
                if (tokenLength == length) {
                    cout << "      ";
                    token.print(cout);
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
    int sectionIndex = (int)section;
    char displayChar = toupper(section); // keep original for display

    // DEBUG
    // std::cout << "Debug: section character ASCII value: " << sectionIndex << std::endl;
    
    // Use tolower() for case-insensitive section determination
    if (isalpha(section)) {
        // DEBUG
        // std::cout << "Debug: Using alpha section index: " << sectionIndex << std::endl;
        sectionIndex = toupper(section) - 'A';
    } else {
        sectionIndex = 26; // special characters section
        displayChar = '#';
        // DEBUG
        // std::cout << "Debug: Using special char section index: " << sectionIndex << std::endl;
    }
    
    if (sectionIndex < 0 || sectionIndex >= NUM_SECTIONS) {
        cout << "Invalid section: " << section << "\n";
        return;
    }

    // section header
    cout << "\n===== Section '" << displayChar << "' =====\n";

    if (index[sectionIndex].isEmpty()) {
        cout << "No tokens in this section\n";
    } else {
        index[sectionIndex].print(cout);
    }
}

// helper function for token count
const int Indexer::getTokenCount() const {
    int count = 0;
    // this was only counting size of each section
    // for (size_t i = 0; i < NUM_SECTIONS; i++) {
    //     count += index[i].size();
    // }
    for (size_t i = 0; i < NUM_SECTIONS; i++) {
        // get each section's token with line number count (occurences)
        for (size_t j = 0; j < index[i].size(); j++) {
            count += index[i].getIndexedToken(j).getLineNumbers().getSize();
        }
    }
    return count;
}
