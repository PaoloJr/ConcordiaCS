#ifndef INDEXEDTOKEN_H
#define INDEXEDTOKEN_H

#include <cstddef> // for `size_t` type
#include <ostream> // for std::ostream
#include <string>
#include <vector>

/*
purpose:
aggregates a token and its list of line numbers (IntList),
representing a complete index for the token
*/

class IndexedToken {
    private:
        // the token using std::string
        std::string token;
        // list of line numbers using std::vector
        std::vector<int> lines;

    public:
        // default ctor
        IndexedToken() = default;
        
        /*
        parameterized ctors; each initialize the `token` and add
        the first `lineNumber` to `lines` list
        */
        IndexedToken(const char* text, int lineNumber);
        IndexedToken(std::string& token, int lineNumber);

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

        // returns `token` by `const string&`
        const std::string& getToken() const;

        // returns `lines` by `const vector<int>&`
        const std::vector<int>& getLineNumbers() const;

        // writes `token` followed by `lines` to `os`
        void print(std::ostream& os) const;

        // compares `token`'s text with a c-string (delegates to `std::strcmp`)
        int compare(const char* other) const;

        // compares `token` with `other.token` (delegates to `Token::compare`)
        int compare(const IndexedToken& other) const;
};

#endif