#include "DLList.h"

DLList::Node::Node(const IndexedToken& data, Node* prv, Node* nxt) {
    this->data = data;
    this->next = nxt;
    this->prev = prv;
}

DLList::DLList() {
    head = nullptr;
    tail = nullptr;
    nodeCount = 0;
}

DLList::~DLList() {
    delete[] this;
}

// other special member functions

void DLList::addBefore(IndexedToken data, size_t pos) {
    if (pos > nodeCount) {
        throw std::out_of_range("Position out of range");
    }
    if (isEmpty() || pos == 0) {
        Node* newNode = new Node(data, nullptr, head);
    }
}

size_t DLList::size() const {
    return nodeCount;
}

bool DLList::isEmpty() const {
    if (nodeCount == 0) {
        return true;
    } else {
        return false;
    }
}

void DLList::print(std::ostream& os) const {
// todo
}

