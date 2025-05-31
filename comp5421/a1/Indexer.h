#ifndef INDEXER_H
#define INDEXER_H

#include "DLList.h"
#include "Token.h"

/*
purpose:
to manage the complete text indexing workflow, storing the resulting
index as an array of 27 alphabetically sorted sections, each implemented
using a `DLList`
*/

class Indexer {
    public:
        static const int NUM_SECTIONS = 27;

        // default initial ctor; initializes 27 empty sections
        Indexer();

        // destructor = default
        ~Indexer() = default;

        // copy ctor, = delete, for efficiency
        Indexer(const Indexer& source) = delete;
        
        // copy assignment, = delete, for efficiency
        Indexer& operator = (const Indexer& source) = delete;
        
        // move ctor, = default, for efficiency
        Indexer(Indexer&& source) noexcept = default;
        
        // move assignment, = default, for efficiency
        Indexer& operator = (Indexer&& source) noexcept = default;

        /* If filename does not open successfully,
        displays an error message and returns;
        otherwise, clears index, reads file contents
        line by line, tokenizes each line, and passes
        each token along with the line number to
        processToken.
        */
        void processTextFile(const std::string& filename);

        // empty the entire index
        void clear();

        // check if index is empty
        bool isEmpty() const;

        // display entire index, calling each section's print
        void print(std::ostream& os) const;

        // print(std::cout)
        void displayAll() const;
        
        // display tokens of a specified length
        // doc shows listByLength???
        void searchByLength(size_t length) const;
        
        // display tokens in a specified section
        void displaySection(char section) const;
        
    private:
        // stores index; all 27 sections
        DLList index[NUM_SECTIONS];
        std::string currentFileName;
        
        /*
        Locates the correct section and checks if the
        supplied token already exists in that sec-
        tion; if it does, calls addLine(line) on the
        IndexedToken that stores the token; other-
        wise, constructs a brand new IndexedToken
        and inserts it in sorted order into the section.
        */
        void processToken(const char* text, int lineNumber);
        
        void processToken(Token token, int lineNumber);
};

#endif  // INDEXER_H