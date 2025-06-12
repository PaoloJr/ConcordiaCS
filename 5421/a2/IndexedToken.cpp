#include "IndexedToken.h"
#include <cstring>
#include <iostream>
#include <string>

IndexedToken::IndexedToken(const char* text, int lineNumber) {
    token = text;
    lines.push_back(lineNumber);
}

IndexedToken::IndexedToken(std::string& inputToken, int lineNumber) {
    token = inputToken;
    lines.push_back(lineNumber);
}

/* 
other special member function have specifiers `= default`
they are in `IndexedToken.h` file
*/

void IndexedToken::appendLineNumber(size_t lineNumber) {
    lines.push_back(lineNumber);
}

const std::string& IndexedToken::getToken() const {
    return token;
}

const std::vector<int>& IndexedToken::getLineNumbers() const {
    return lines;
}

void IndexedToken::print(std::ostream& os) const {
    os << token << ": ";
    bool first = true;
    for (const auto& lineNum : lines) {
        if (!first) {
            os << ", ";
        }
        os << lineNum;
        first = false;
    }
    os << "\n";
}

int IndexedToken::compare(const char* other) const {
    return std::strcmp(token.c_str(), other);
}

// delegate to Token's compare method
int IndexedToken::compare(const IndexedToken& other) const {
    return token.compare(other.token);
}