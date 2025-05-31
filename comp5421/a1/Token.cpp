#include "Token.h"
#include <cstring>
#include <iostream> // for std::cout
using namespace std; // for cout

Token::Token() {
    cout << "Token: default ctor called\n";
    text = new char[1];
    text[0] = '\0';
}

Token::~Token() {
    cout << "Token: destructor called\n";
    delete[] text;
}

Token::Token(const char* str) { // removed the `= ""` in the parameter
    cout << "Token: parameterized ctor called\n";
    if (str == "" || str == nullptr) {
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
    cout << "Token: copy ctor called\n";
    text = new char[strlen(other.text) + 1];
    strcpy(text, other.text);
}

Token& Token::operator=(const Token& other) {
    cout << "Token: copy assignment operator called\n";
    if (this != &other) {
        delete[] text;
        text = new char[strlen(other.text) + 1];
        strcpy(text, other.text);
    }
    return *this; // dereference to get object
}

Token::Token(Token&& other) {
    cout << "Token: move ctor called\n";
    text = other.text;
    other.text = new char[1];
    other.text[0] = '\0';
}

Token& Token::operator=(Token&& other) {
    cout << "Token: move assignment operator called\n";
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
