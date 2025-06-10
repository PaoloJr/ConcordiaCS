#include "IndexedToken.h"
#include "IntList.h"
#include <cstring>

IndexedToken::IndexedToken(const char* text, int lineNumber) {
    token = text;
    lines.append(lineNumber);
}

IndexedToken::IndexedToken(Token inputToken, int lineNumber) {
    token = inputToken;
    lines.append(lineNumber);
}

/* 
other special member function have specifiers `= default`
they are in `IndexedToken.h` file
*/

void IndexedToken::appendLineNumber(size_t lineNumber) {
    lines.append(lineNumber);
}

const Token& IndexedToken::getToken() const {
    return token;
}

const IntList& IndexedToken::getLineNumbers() const {
    return lines;
}

void IndexedToken::print(std::ostream& os) const {
    token.print(os);
    os << ": ";
    lines.print(os);
}

int IndexedToken::compare(const char* other) const {
    return std::strcmp(token.c_str(), other);
}

// delegate to Token's compare method
int IndexedToken::compare(const IndexedToken& other) const {
    return token.compare(other.token);
}