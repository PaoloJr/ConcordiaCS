#include "DLList.h"
#include <iostream> // for std::cout
using namespace std; // for cout

DLList::Node::Node(const IndexedToken& data, Node* prv, Node* nxt) {
    this->data = data;
    this->next = nxt;
    this->prev = prv;
}

DLList::Node* DLList::getNodeAt(size_t pos) {
    if (pos >= nodeCount) {
        cout << "getNodeAt: Position out of range: pos=" << pos << ", nodeCount=" << nodeCount;
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

DLList::DLList(const DLList& dll) {
    nodeCount = 0; // no nodes yet
    head = nullptr; // empty list, for now
    tail = nullptr; // initialize tail 
    
    if (dll.isEmpty()) return;
    
    // with at lease one node
    Node* current = dll.head;
    head = new Node (current->data, nullptr, nullptr);
    nodeCount = 1;
    tail = head; // for a single node
    
    // copy remaining nodes
    Node* lastNode = head;
    current = current->next; // move to next node
    while(current) {
        Node* newNode = new Node(current->data, nullptr, nullptr);
        lastNode->next = newNode;
        newNode->prev = lastNode;
        lastNode = newNode; // update lastNode
        tail = newNode; // update tail
        current = current->next; // move to next node
        nodeCount++;
    }
}

DLList& DLList::operator = (const DLList& dll) {
    if (this != &dll) { // ex: this = list1, dll = list2
        clear(); // clear list1 existing nodes
        
        nodeCount = 0; // no nodes yet
        head = nullptr; // empty list, for now
        tail = nullptr; // initialize tail 
        
        if (dll.isEmpty()) return *this;
        
        // with at lease one node
        Node* current = dll.head;
        head = new Node (current->data, nullptr, nullptr);
        nodeCount = 1;
        // for a single node
        tail = head;
        
        // copy remaining nodes
        Node* lastNode = head;
        current = current->next; // move to next node
        while(current) {
            Node* newNode = new Node(current->data, nullptr, nullptr);
            lastNode->next = newNode;
            newNode->prev = lastNode;
            lastNode = newNode; // update lastNode
            tail = newNode; // update tail
            current = current->next; // move to next node
            nodeCount++;
        }
    }
    return *this;
}

DLList::DLList(DLList&& dll) noexcept {
    head = dll.head;
    tail = dll.tail;
    nodeCount = dll.nodeCount;
    
    dll.head = nullptr;
    dll.tail = nullptr;
    dll.nodeCount = 0;
}

DLList& DLList::operator = (DLList&& dll) noexcept {
    if (this != &dll) {
        clear();
        head = dll.head;
        tail = dll.tail;
        nodeCount = dll.nodeCount;
        
        dll.head = nullptr;
        dll.tail = nullptr;
        dll.nodeCount = 0;
    }
    return *this;
}

void DLList::addBefore(IndexedToken data, size_t pos) {
    if (pos > nodeCount) {
        cout << "addBefore: Position out of range: pos=" << pos << ", nodeCount=" << nodeCount;
        throw std::out_of_range("Position out of range");
    }
    if (isEmpty() || pos == 0) {  // add to front of the list
        Node* newNode = new Node(data, nullptr, head);
        if (head) {
            head->prev = newNode;
        } else {
            tail = newNode;
        }
        head = newNode;
    } else if (pos == nodeCount) { // add to end of list
        Node* newNode = new Node(data, tail, nullptr);
        tail->next = newNode;
        tail = newNode;
    } else { // add to middle of list
        Node* currentNode = getNodeAt(pos);
        Node* newNode = new Node(data, currentNode->prev, currentNode);
        currentNode->prev->next = newNode;
        currentNode->prev = newNode;         
    }
    nodeCount++;
}

bool DLList::remove(size_t pos) {
    if (pos >= nodeCount) {
        cout << "remove: Position out of range: pos=" << pos << ", nodeCount=" << nodeCount;
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

IndexedToken& DLList::getIndexedToken(size_t pos) {
    if (pos >= nodeCount) {
        cout << "getIndexedToken: Position out of range: pos=" << pos << ", nodeCount=" << nodeCount;
        throw std::out_of_range("Position out of range");
    }
    return getNodeAt(pos)->data;
}

const IndexedToken& DLList::getIndexedToken(size_t pos) const {
    if (pos >= nodeCount) {
        cout << "getIndexedToken_const: Position out of range: pos=" << pos << ", nodeCount=" << nodeCount;
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
    for (Node* temp = head; temp != nullptr; temp = temp->next) {
        if (temp != nullptr) {
            os << "      ";
            temp->data.print(os);
        }
    }
}

