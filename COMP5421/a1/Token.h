#ifndef TOKEN_H
#define TOKEN_H

#include <cstddef> // for `size_t` type
#include <ostream> // for `std::ostream`

/*
purpose:
to represent a single lexical token (a word or sequence of non-whitespace characters)
as a C-style null-terminated string
*/

class Token {
    private:
        // pointer to dynamically allocated c-string
        char* text;

    public:
        /* 
        default ctor; constucts empty token by allocating
        a one-character array containing only the null byte (`\0`),
        ensuring text is never `nullptr`
        */
        Token();

        // destructor; de-allocates text
        ~Token();

        /* 
        parameterized constructor; handles null or empty `str`
        by allocating "\0". otherwise, performs a deep copy of `str`
        */
        Token(const char* str); // removed the `= ""` in the parameter

        // copy ctor; deep copies `other.text` to text using `strcpy`
        Token(const Token& other);

        // copy assignment operator (deep copy, handles self-assignment)
        Token& operator = (const Token& other);

        /* 
        move ctor; transfers ownership of the `other.text` to `this` object, leaving `other`
        as valid empty token (pointing to "\0")
        */
        Token(Token&& other) noexcept;

        /*
        move assignment operator. handles self-assignment and transfers ownership,
        leaving the moved-from object `other` as valid emtpy token
        */
        Token& operator = (Token&& other) noexcept;

        // returns text[0]
        char getFirstChar() const;

        // returns `this` token's `text` as a `const char*`
        char* c_str() const;

        // returns the length of token's `text` using `strlen`
        size_t length() const;

        // writes the token `text` to the output stream `os`
        void print(std::ostream& os) const;

        // performs case-sensitive comparison using `std::strcmp`. returns `<0`, `0`, or `>0`
        int compare(const Token& other) const;
};

#endif