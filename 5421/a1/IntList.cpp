#include "IntList.h"
#include <iostream> // for std::cout
using namespace std; // for cout

IntList::IntList() {
    capacity = 0;
    size = 0;
    pData = nullptr;
}

IntList::IntList(const IntList& other) {
    this->capacity = other.capacity;
    this->size = other.size;
    
    if (capacity > 0) {
        this->pData = new int[capacity];

        for (size_t i = 0; i < size; i++) {
        this->pData[i] = other.pData[i];
        }
    } else {
        this->pData = nullptr;
    }
}

IntList& IntList::operator = (const IntList& other) {
    if (this != &other) {
        delete[] pData;
        this->capacity = other.capacity;
        this->size = other.size;
        
        if (capacity > 0) {
            this->pData = new int[capacity];
            for (size_t i = 0; i < size; i++) {
                this->pData[i] = other.pData[i];
            }
        } else {
            this->pData = nullptr;
        }
    }
    return *this;
}

IntList::IntList(IntList&& other) noexcept {
    pData = other.pData;
    other.pData = nullptr;
    other.capacity = 0;
    other.size = 0;
}

IntList& IntList::operator = (IntList&& other) {
    if (this != &other) {
        delete[] pData;
        pData = other.pData;
        size = other.size;
        capacity = other.capacity;

        other.pData = nullptr;
        other.size = 0;
        other.capacity = 0;
    }
    return *this;
}

IntList::~IntList() {
    // can just call clear() as well
    delete[] pData;
}

void IntList::resize() {
    size_t newCapacity = capacity == 0 ? 2 : capacity * 2;

    int* newData = new int[newCapacity];

    for (size_t i = 0; i < size; i++) {
        newData[i] = pData[i];
    }

    delete[] pData;

    pData = newData;
    capacity = newCapacity;
}

void IntList::append(int lineNumber) {
    if (isFull()) {
        resize();
    }
    pData[size] = lineNumber;    
    size++;
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

// helper function used in tests only
const int IntList::getCapacity() const {
    return this->capacity;
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
    os << "\n";
}

int IntList::getElementAt(size_t index) const {
    if (index >= size) {
        throw std::out_of_range("Index out of range");
    }
    return pData[index];
}
