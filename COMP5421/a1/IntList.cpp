#include "IntList.h"


IntList::IntList() {
    capacity = 2;
    pData = new int[capacity];
}

IntList::IntList(const IntList& other) {
    if (this != &other) {

    }
}

IntList& IntList::operator = (const IntList& other) {

}

IntList::IntList(IntList&& other) {
    pData = other.pData;
    other.pData = nullptr;
    other.capacity = 0;
    other.size = 0;
}

IntList& IntList::operator = (IntList&& other) {
    if (this != &other) {

    }
}

IntList::~IntList() {
    delete[] pData;
}

void IntList::resize() {
    
   capacity == 0 ? 2 : capacity * 2;
}

void IntList::append(int lineNumber) {

}

void IntList::clear() {
    delete[] pData;
    pData = nullptr;
    capacity = 0;
    size = 0;
}

int IntList::getSize() const {
    return size;
}

bool IntList::isEmpty() const {
    if (size == 0) {
        return true;
    } else {
        return false;
    }
}

bool IntList::isFull() const {
    if (size == capacity) {
        return true;
    } else {
        return false;
    }
}

void IntList::print(std::ostream& os) const {
    for (size_t i = 0; i < size; i++) {
        os << pData[i];
        if (i < size - 1) {
            os << ", ";
        }
    }
}

int IntList::getElementAt(size_t index) const {
    if (index >= size) {
        throw std::out_of_range("Index out of range");
    }
    return pData[index];
}
