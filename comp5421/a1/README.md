## Assignment #1 (Text File Indexer)
**Paolo Junior Angeloni (25976944)** \
COMP5421 \
June 2nd, 2024

---
## setup and execution
- requires `g++` compiler with C++11 support
- execution is done via `makefile` found in `/`
- compile program: run `make` from `/`
- this will output a `TextIndexer` binary file
- to run program (includes compilation step), type `make run` from `/`
- clean up compiled files: `make clean`

**to run command directly**
`g++ -std=c++11 -Wall -g -o TextIndexer Token.cpp IntList.cpp IndexedToken.cpp DLList.cpp Indexer.cpp IndexerUI.cpp main.cpp`
- `std=C++`: uses C++11 standard
- `-Wall`: display all warnings during compilation
- `-g`: adds debug symbols (useful for debugging with `gdb`)
- `-o [output_file_name]`: set a binary file name output

**selecting `.txt` files**
- the `.txt` sample files (`milo.txt` & `chuck.txt`)  are in `/samples/` directory
- during program execution, when selecting option 1 (`Index a text file`), you must enter the relative path (ex: `samples/milo.txt`) to run the indexer on the file

## additional features implemented
- **Test Suite**: Developed individual test files for each class to validate functionality
- **Custom Assertions**: Implemented both C-style assertions and visual validation tests
- **Test Runner**: Created a make-based test execution system with individual and batch-testing options
- test suite is found in `/tests/` directory
- includes files for:
    - `Token.cpp` --> `/tests/token.cpp`
    - `IndexedToken.cpp` --> `/tests/indexedtoken.cpp`
    - `IntList.cpp` --> `/tests/intlist.cpp`
    - `DLList.cpp` --> `/tests/dllist.cpp`
    - `Indexer.cpp` --> `/tests/indexer.cpp`

**to run tests**
- `cd tests && make run`
- can also run an individual class test
    - ex: `make run-token`
- clean up compiled files: `make clean`
- some tests are implemented using custom functions or (C-style) asserts; this was good practice for me.
- most tests output `Pass` or `Fail` or crash (if using `assert`)
- other tests (ex: `print()`) will display output to console (`cout`) for inspection

## bugs/limitations found in documentation
\*required minor modifications

`Token.h`
- the parameterized constructor was initially `Token(str: const char* =“”);` 
- this had to be changed to `Token(const char* str);` to avoid ambiguity with the default constructor `Token()`

`IndexedToken.h`
- the default constructor was missing
- it was added as `IndexedToken() = default;`

`DLList.h`
- could not access the `private: getNodeAt(size_t pos)`
- added `friend class DLList;` to `class Node public:` for controlled access to the private properties of `Node` (`next`, `prev`, `data`)
- `getNodeAt(size_t pos)` method is only called from `DLList` throughout the lifecycle of the program
- `class Node`, therefore `getNodeAt(size_t pos)`, still remains private to `DLList`
- it is accessible by `DLList` only, maintaining encapsulation

`Indexer.h`
- document shows `void listByLength(size_t length) const`
- `IndexerUI` calls `searchByLength(size_t length) const`
- the method was renamed to `searchByLength(size_t length) const` for consistency
- document shows `void ViewBySection(char section) const`
- `IndexerUI` calls `displaySection(char section) const`
- the method was renamed to `displaySection(char section) const` for consistency

`IndexerUI.cpp` \
originally:
```cpp
void IndexerUI::processViewSection() {
    // ...
    char sectionChar = getSectionChar();
    int sectionIndex = getSectionIndexFromChar(sectionChar);
    index.displaySection(sectionIndex);
}
```
- this is problematic given the `index.displaySection()` takes a `char` and not an `int`

as such, it was updated to:
```cpp
void IndexerUI::processViewSection() {
    // ...
    char sectionChar = getSectionChar();
    index.displaySection(sectionChar);
}
```

## notes
- `Rule of Five` implemented: destructor, copy ctor, copy assignment, move ctor and move assignment
- for clarity, special member functions (constructors) with the ` = default` or ` = delete` specifiers, were declared only in their respective `.h` files
- ex: `IndexedToken.cpp` and `Indexer.cpp`
- `IntList` has a helper function `const int IntList::getCapacity() const`
    - it is used in the test suite only for validating the `isFull()` and `resize()` methods
- `Indexer` has a helper function `const int getTokenCount() const;` for use in outputting the total tokens counted
- added optional `DEBUG` print statements especially in `DLList` to check for `out_of_range` errors (they are commented out)
- various methods that were overloaded (using different parameters), convert the parameter(s) and call the other method (delegation)
    - this allows for interface flexibility and reduces duplication
**examples:**
```cpp
// Indexer
void Indexer::processToken(const char* text, int lineNumber) {
    // ...
}

void Indexer::processToken(Token token, int lineNumber) {
    // ...
    // delegate to const char* overload
    processToken(token.c_str(), lineNumber);
} 

// ==========

// IndexedToken (as per instructions)
int IndexedToken::compare(const char* other) const {
    return std::strcmp(token.c_str(), other);
}
// delegate to Token's compare method
int IndexedToken::compare(const IndexedToken& other) const {
    return token.compare(other.token);
}
```




