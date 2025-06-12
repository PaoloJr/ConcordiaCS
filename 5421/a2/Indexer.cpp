#include "Indexer.h"
#include <fstream>
#include <sstream>
#include <iostream> // for std::cout

Indexer::Indexer() {
    // DEBUG
    // cout << "Indexer: default ctor called, number of sections = " << NUM_SECTIONS << "\n";
}

/* 
other special member function have specifiers `= default` or `= delete`
they are in `Indexer.h` file
*/

void Indexer::processTextFile(const std::string& filename) {
    std::ifstream file(filename.c_str());

    if (!file.is_open()) {
        std::cerr << "File did not open: " << filename << "\n";
        return;
    }

    currentFileName = filename;

    clear();
    
    std::cout << "Indexing file: " << filename << "...\n";
    int lineNumber = 1;
    int lineCount = 0;
    std::string line;
    
    // read file line by line
    while(getline(file, line)) {
        if (line.empty()) {
            lineNumber++;
            lineCount++;
            continue;
        }
        // stringstream for tokenization
        std::istringstream iss(line);
        std::string token;
        
        // extract tokens using whitespace delimiter
        while (iss >> token) {
            processToken(token.c_str(), lineNumber);
        }
        lineNumber++;
        lineCount++;
    }
    int linesProcessed = lineCount;
    int tokensProcessed = getTokenCount();
    std::cout << currentFileName << " indexed successfully " << "(" << linesProcessed << " lines, " << tokensProcessed << " tokens processed)\n";
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
    // could also use `for (const auto& token : index[sectionIndex])` ...
    for (auto it = index[sectionIndex].begin(); it != index[sectionIndex].end(); it++) {
        
        /* 
        if token/text already exists, add line number and return
        if chars are equal (strcmp)
        */ 
        if (it->compare(text) == 0) {
            it->appendLineNumber(lineNumber);
            return;
        }

        /*
        if token/text does not already exist, create a new one and insert in sorted order
        if chars are not equal (strcmp)
         */
        if (it->compare(text) > 0) {
            IndexedToken newToken(text, lineNumber);
            index[sectionIndex].insert(it, newToken);
            return;
        }
    }

    // add token/text at the end of the section
    IndexedToken newToken(text, lineNumber);
    index[sectionIndex].push_back(newToken);
}

void Indexer::processToken(std::string& token, int lineNumber) {
    if (token.empty()) {
        return;
    }

    // delegate to const char* overload
    processToken(token.c_str(), lineNumber);
} 

void Indexer::clear() {
    // loop through each list and call its clear()
    for (auto& section : index) {
        section.clear();
    }
}

bool Indexer::isEmpty() const {
    // loop through each DLList and call its isEmpty()
    for (auto& section : index) {
        // if any one DLList (section) is not empty, return false
        if (!section.empty()) {
            return false;
        }
    }
    // all sections are empty
    return true;
}

void Indexer::print(std::ostream& os) const {
    os << "\n===== Complete Index for: " << (currentFileName.empty() ? "No file loaded" : currentFileName) << " =====\n\n";
    bool found = false;

    int i = 0;
    for (auto& section : index) {    
        if (!section.empty()) {
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
            // index[i].print(os);
            // could also use `for (const auto& token : index[sectionIndex])`...
            for (auto token = section.begin(); token != section.end(); token++) {
                std::cout << "      ";
                token->print(std::cout);
            }
        }
        i++;
    }
    if (!found) {
        os << " (empty index)";
    }
    os << "\n===== Done =====\n";
}

void Indexer::displayAll() const {
    print(std::cout);
}

// loop every token of every section --> O(n^2)
void Indexer::searchByLength(size_t length) const {
    std::cout << "\n===== Tokens of length " << length << " =====\n";
    bool found = false;

    // sections loop
   for (auto& section : index) {
        if (!section.empty()) {
            // tokens loop
            // could also use `for (const auto& token : section)` ...
            for (auto it = section.begin(); it != section.end(); it++) {
                const IndexedToken& token = *it;
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
                    std::cout << "      ";
                    token.print(std::cout);
                    found = true;
                }
            }
        }
    }
    if (!found) {
        std::cout << "No tokens of length " << length << " found\n";
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
        std::cout << "Invalid section: " << section << "\n";
        return;
    }

    // section header
    std::cout << "\n===== Section '" << displayChar << "' =====\n";

    if (index[sectionIndex].empty()) {
        std::cout << "No tokens in this section\n";
    } else {
        // could also use `for (const auto& token : index[sectionIndex])`...
        for (auto it = index[sectionIndex].begin(); it != index[sectionIndex].end(); it++) {
            std::cout << "      ";
            it->print(std::cout);
        }
    }
}

// helper function for token count
const int Indexer::getTokenCount() const {
    int count = 0;
    for (const auto& section : index) {
        // get each section's token with line number count (occurences)
        for (const auto& token : section) {
            count += token.getLineNumbers().size();
        }

    }
    return count;
}
