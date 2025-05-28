#ifndef INTLIST_H
#define INTLIST_H

#include <cstddef> // for `size_t` type
#include <ostream> // for `std::ostream`

/*
purpose:
to represent and manage a dynamically growing sequence of integers,
specifically intended for storing line numbers associated with a token
*/

class IntList {
    private:
        // pointer to the dynamic array
        int* pData;
        // number of elements currently stored
        size_t size;
        // size of the dynamic array currently allocated
        size_t capacity;

        // resizes array capacity; starts at 2, then doubles
        void resize();

    public:
        // default ctor; initializes to empty state
        IntList();

        // copy ctor (deep copy)
        IntList(const IntList& other);

        // copy assignment operator (deep copy, handles self-assignment)
        IntList& operator = (const IntList& other);

        /* 
        move ctor; transfers ownership of the dynamic arry from `other`, leaving
        `other` in a valid, empty state (i.e., sets `other.pData` to `nullptr`, and both
        `other.count` and `other.capacity` to 0)
        */
        IntList(IntList&& other) noexcept;

        /*
        move assignment operator; handles self-assignment, release's current array, and takes
        ownership of `other`'s array, leaving `other` in a valid, empty state
        */
        IntList& operator = (IntList&& other);

        // destructor; frees the allocated array
        ~IntList();

        // appends `lineNumber` to the end of the list, resizing the dynamic array if necessary
        void append(int lineNumber);

        // removes all elements and de-allocates memory
        void clear();

        // returns `size`, the number of integers stored
        int getSize() const;
        
        // checks if `size` is 0
        bool isEmpty() const;

        // checks if `size` is equal to `capacity`
        bool isFull() const;

        // write the list contents to the stream `os`
        void print(std::ostream& os) const;

        /*
        returns element at the specified 0-bases `index`
        throws `std::out_of_range` if `index` is invalid    
        */
        int getElementAt(size_t index) const;            
};

#endif