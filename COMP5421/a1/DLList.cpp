#include "DLList.h"
#include <iostream> // for std::

DLList::Node::Node(const IndexedToken& data, Node* prv, Node* nxt) {
    this->data = data;
    this->next = nxt;
    this->prev = prv;
}

DLList::Node* DLList::getNodeAt(size_t pos) {
    if (pos >= nodeCount) {
        throw std::out_of_range("Position out of range");
    }
    Node* current = head;
    for (size_t i = 0; i < pos; i++) {
        current = current->next;
    }
    return current;
}

DLList::DLList() {
    head = nullptr;
    tail = nullptr;
    nodeCount = 0;
}

DLList::~DLList() {
    clear();
}

// other special member functions

void DLList::addBefore(IndexedToken data, size_t pos) {
    if (pos > nodeCount) {
        throw std::out_of_range("Position out of range");
    }
    if (isEmpty() || pos == 0) {
        Node* newNode = new Node(data, nullptr, head);
        if (head) {
            head->prev = newNode;
        } else {
            tail = newNode;
        }
        head = newNode;
    } else {
        Node* currentNode = getNodeAt(pos);
        Node* newNode = new Node(data, currentNode->prev, currentNode);
        currentNode->prev->next = newNode;
        currentNode->prev = newNode; 
    }
    nodeCount++;
}

bool DLList::remove(size_t pos) {
    if (pos >= nodeCount) {
        throw std::out_of_range("Position out of range");
    }
    Node* nodeToRemove = getNodeAt(pos);
    if (nodeToRemove == head) {
        head = head->next;
        // check if new head is not null
        if (head) {
            head->prev = nullptr;
        } else {
            tail = nullptr;
        }
    } else if (nodeToRemove == tail) {
        tail = tail->prev;
        tail->next = nullptr;
    } else {
        nodeToRemove->prev->next = nodeToRemove->next;
        nodeToRemove->next->prev = nodeToRemove->prev;
    }
    delete nodeToRemove;
    nodeCount--;
    return true;
}

const IndexedToken& DLList::getIndexedToken(size_t pos) {
    if (pos >= nodeCount) {
        throw std::out_of_range("Position out of range");
    }
    return getNodeAt(pos)->data;
}

const IndexedToken& DLList::getIndexedToken(size_t pos) const {
    if (pos >= nodeCount) {
        throw std::out_of_range("Position out of range");
    }
    // to get const version of IndexedToken&
    Node* current = head;
    for (size_t i = 0; i < pos; i++) {
        current = current->next;
    }
    return current->data;
}

void DLList::clear() {
    while (head != nullptr) {
        Node* oldHead = head;
        head = head->next;
        delete oldHead;
    }
    tail = nullptr;
    nodeCount = 0;
}

size_t DLList::size() const {
    return nodeCount;
}

bool DLList::isEmpty() const {
    return nodeCount == 0;
}

void DLList::print(std::ostream& os) const {
    os << '[';
    for (Node* temp = head; temp != nullptr; temp = temp->next) {
        temp->data.print(os);
        if (temp->next != nullptr) {
            os << ' ';
        }
    }
    os << ']';
}

