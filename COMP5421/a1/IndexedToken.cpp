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

IndexedToken::IndexedToken(const IndexedToken& it) = default;
IndexedToken::IndexedToken(IndexedToken&& it) noexcept = default;
IndexedToken& IndexedToken::operator = (const IndexedToken& it) = default;
IndexedToken& IndexedToken::operator = (IndexedToken&& rhs) = default;
IndexedToken::~IndexedToken() = default;

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
    os << " ";
    lines.print(os);
}

int IndexedToken::compare(const char* other) const {
    return std::strcmp(token.c_str(), other);
}

int IndexedToken::compare(const IndexedToken& other) const {
    return token.compare(other.token);
}