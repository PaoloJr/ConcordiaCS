#ifndef DLLIST_H
#define DLLIST_H

#include "IndexedToken.h"
#include <ostream> // for `std::ostream` && `size_t`

/*
purpose:
to manage a section of `IndexedToken` objects using an internal
doubly-linked list structure
*/

class DLList {
    private:
        // represents a node storing an `IndexedToken`
        class Node {
            private:
                // pointer to previous node
                Node* prev;
                // stores the `IndexedToken` data in `this` node`
                IndexedToken data;
                // pointer to next node
                Node* next;
             public:
                // ctor; initializes `prev` pointer, `next` pointer and node `data`
                Node(const IndexedToken& data, Node* prv, Node* nxt);

                // not in doc???
                // added to help with accessing objects
                friend class DLList;
        };
        // pointer to the first node of the DLList
        Node* head;
        // pointer to the last node of the DLList
        Node* tail;
        // tracks total nodes
        size_t nodeCount;

        // helper to return the node at position `pos`
        Node* getNodeAt(size_t pos);

    public:
        /* 
        default ctor; initializes and empty linked list,
        setting both `head` and `tail` to `nullptr`        
        */
        DLList();

        // destructor; deletes all nodes
        ~DLList();

        // copy ctor; deep copies `dll` into `this` linked list
        DLList(const DLList& dll);

        /* 
        copy assignment; deletes the current linked list,
        replacing it with deep copy of `dll`        
        */
        DLList& operator = (const DLList& dll);

        /*
        move ctor; transfers ownership of nodes from `dll`
        to `this` list, leaving `dll` in a stable state
        */ 
        DLList(DLList&& dll) noexcept;

        /*
        move assignment; deletes the current linked list, then
        transfers ownership of nodes from `dll` to `this` list, leaving `dll`
        in a stable state
        */
        DLList& operator = (DLList&& dll) noexcept;

        /* 
        inserts `data` before the node at position `pos` (0-based,
        throws `std::out_of_range)
        */
        void addBefore(IndexedToken data, size_t pos);

        /* 
        removes the node at position `pos` (0-based,
        throws `std::out_of_range)
        */
        bool remove(size_t pos);

        /* 
        returns a reference to `data` at position `pos` (0-based,
        throws `std::out_of_range)
        */
        IndexedToken& getIndexedToken(size_t pos);

        /* 
        returns a `const` reference to `data` at position `pos` (0-based,
        throws `std::out_of_range)
        */
        const IndexedToken& getIndexedToken(size_t pos) const;

        // removes all nodes
        void clear();

        // returns `nodeCount`
        size_t size() const;

        // check if list is empty
        bool isEmpty() const;

        // calls `print(os) on `data` stored in each node
        void print(std::ostream& os) const;
};

#endif