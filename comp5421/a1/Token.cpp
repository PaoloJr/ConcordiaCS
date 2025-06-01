#include "Token.h"
#include <cstring>
#include <iostream> // for std::cout
using namespace std; // for cout

Token::Token() {
    text = new char[1];
    text[0] = '\0';
}

Token::~Token() {
    delete[] text;
}

Token::Token(const char* str) { // removed the `= ""` in the parameter
    if (str == nullptr || strcmp(str, "") == 0) {
        text = new char[1];
        text[0] = '\0';
    } else {
        int len = strlen(str);
        // consider null-terminator
        text = new char[len + 1];
        strcpy(text,str);
    }
}

Token::Token(const Token& other) {
    text = new char[strlen(other.text) + 1];
    strcpy(text, other.text);
}

Token& Token::operator=(const Token& other) {
    if (this != &other) {
        delete[] text;
        text = new char[strlen(other.text) + 1];
        strcpy(text, other.text);
    }
    return *this; // dereference to get object
}

Token::Token(Token&& other) noexcept {
    text = other.text;
    other.text = new char[1];
    other.text[0] = '\0';
}

Token& Token::operator=(Token&& other) noexcept {
    if (this != &other) {
        delete[] text;
        text = other.text;
        other.text = new char[1];
        other.text[0] = '\0';
    }
    return *this;
}

char Token::getFirstChar() const {
    return text[0];
}

char* Token::c_str() const {
    return this->text;
}

size_t Token::length() const {
    return strlen(text);
}

void Token::print(std::ostream& os) const {
    os << text;
}

int Token::compare(const Token& other) const {
    return strcmp(this->text, other.text);
}
