#ifndef INDEXEDTOKEN_H
#define INDEXEDTOKEN_H

#include "Token.h"
#include "IntList.h"
#include <cstddef> // for `size_t` type
#include <ostream> // for std::ostream

/*
purpose:
aggregates a token and its list of line numbers (IntList),
representing a complete index for the token
*/

class IndexedToken {
    private:
        // the token
        Token token;
        // list of line numbers
        IntList lines;

    public:
        // default ctor
        // doc did not show any default ctor???
        IndexedToken() = default;
        
        /*
        parameterized ctors; each initialize the `token` and add
        the first `lineNumber` to `lines` list
        */
        IndexedToken(const char* text, int lineNumber);
        IndexedToken(Token token, int lineNumber);

        // copy ctor; = default
        IndexedToken(const IndexedToken& it) = default;

        // move constructor; = default
        IndexedToken(IndexedToken&& it) noexcept = default;

        // copy assignment operator; = default
        IndexedToken& operator = (const IndexedToken& it) = default;

        // move assignment operator; = default
        IndexedToken& operator = (IndexedToken&& rhs) = default;

        // destructor; = default
        ~IndexedToken() = default;

        // appends `lineNumber` to the `lines` list
        void appendLineNumber(size_t lineNumber);

        // returns `token` by `const Token&`
        const Token& getToken() const;

        // returns `lines` by `const IntList&`
        const IntList& getLineNumbers() const;

        // writes `token` followed by `lines` to `os`
        void print(std::ostream& os) const;

        // compares `token`'s text with a c-string (delegates to `std::strcmp`)
        int compare(const char* other) const;

        // compares `token` with `other.token` (delegates to `Token::compare`)
        int compare(const IndexedToken& other) const;
};

#endif