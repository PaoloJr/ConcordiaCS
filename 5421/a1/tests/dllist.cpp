#include "../DLList.h"
#include "../IndexedToken.h"
#include <iostream>
#include <cassert>
#include <string>
using namespace std;

void testDefaultConstructor();
void testAddBefore();
void testRemove();
void testGetIndexedToken();
void testClear();
void testSize();
void testIsEmpty();
void testCopyConstructor();
void testCopyAssignment();
void testMoveConstructor();
void testMoveAssignment();
void testPrint();

int main() {
    cout << "Running DLList tests..." << endl;
    
    testDefaultConstructor();
    testAddBefore();
    testRemove();
    testGetIndexedToken();
    testClear();
    testSize();
    testIsEmpty();
    testCopyConstructor();
    testCopyAssignment();
    testMoveConstructor();
    testMoveAssignment();
    testPrint();
    
    cout << "\n=== All dllist tests passed! ===\n\n" << endl;
    return 0;
}

// Test default constructor
void testDefaultConstructor() {
    cout << "Testing default constructor... ";
    
    DLList list;
    assert(list.isEmpty());
    assert(list.size() == 0);
    
    cout << "Passed!" << endl;
}

// Test addBefore method
void testAddBefore() {
    cout << "Testing addBefore method... ";
    
    DLList list;
    
    // Test adding to empty list
    IndexedToken token1("apple", 1);
    list.addBefore(token1, 0);
    assert(list.size() == 1);
    assert(!list.isEmpty());
    assert(list.getIndexedToken(0).compare("apple") == 0);
    
    // Test adding to beginning of non-empty list
    IndexedToken token2("banana", 2);
    list.addBefore(token2, 0);
    assert(list.size() == 2);
    assert(list.getIndexedToken(0).compare("banana") == 0);
    assert(list.getIndexedToken(1).compare("apple") == 0);
    
    // Test adding to middle of list
    IndexedToken token3("cherry", 3);
    list.addBefore(token3, 1);
    assert(list.size() == 3);
    assert(list.getIndexedToken(0).compare("banana") == 0);
    assert(list.getIndexedToken(1).compare("cherry") == 0);
    assert(list.getIndexedToken(2).compare("apple") == 0);
    
    // Test adding to end of list
    IndexedToken token4("date", 4);
    list.addBefore(token4, 3);
    assert(list.size() == 4);
    assert(list.getIndexedToken(3).compare("date") == 0);
    
    // Test exception for invalid position
    bool exceptionThrown = false;
    try {
        list.addBefore(token1, 5); // Position 5 is out of range
    } catch(const out_of_range&) {
        exceptionThrown = true;
    }
    assert(exceptionThrown);
    
    cout << "Passed!" << endl;
}

// Test remove method
void testRemove() {
    cout << "Testing remove method... ";
    
    DLList list;
    IndexedToken token1("apple", 1);
    IndexedToken token2("banana", 2);
    IndexedToken token3("cherry", 3);
    list.addBefore(token1, 0);
    list.addBefore(token2, 0);
    list.addBefore(token3, 0);
    
    // Remove from middle
    list.remove(1);
    assert(list.size() == 2);
    assert(list.getIndexedToken(0).compare("cherry") == 0);
    assert(list.getIndexedToken(1).compare("apple") == 0);
    
    // Remove from beginning
    list.remove(0);
    assert(list.size() == 1);
    assert(list.getIndexedToken(0).compare("apple") == 0);
    
    // Remove last element
    list.remove(0);
    assert(list.isEmpty());
    assert(list.size() == 0);
    
    // Test exception for invalid position
    list.addBefore(token1, 0);
    bool exceptionThrown = false;
    try {
        list.remove(1); // Position 1 is out of range
    } catch(const out_of_range&) {
        exceptionThrown = true;
    }
    assert(exceptionThrown);
    
    cout << "Passed!" << endl;
}

// Test getIndexedToken method
void testGetIndexedToken() {
    cout << "Testing getIndexedToken method... ";
    
    DLList list;
    IndexedToken token1("apple", 1);
    IndexedToken token2("banana", 2);
    list.addBefore(token1, 0);
    list.addBefore(token2, 0);
    
    // Test regular access
    assert(list.getIndexedToken(0).compare("banana") == 0);
    assert(list.getIndexedToken(1).compare("apple") == 0);
    
    // Test exception for invalid position
    bool exceptionThrown = false;
    try {
        list.getIndexedToken(2); // Position 2 is out of range
    } catch(const out_of_range&) {
        exceptionThrown = true;
    }
    assert(exceptionThrown);
    
    // Test const version
    const DLList& constList = list;
    assert(constList.getIndexedToken(0).compare("banana") == 0);
    
    cout << "getIndexedToken() passed!" << endl;
}

// Test clear method
void testClear() {
    cout << "Testing clear method... ";
    
    DLList list;
    IndexedToken token1("apple", 1);
    IndexedToken token2("banana", 2);
    list.addBefore(token1, 0);
    list.addBefore(token2, 0);
    
    list.clear();
    assert(list.isEmpty());
    assert(list.size() == 0);
    
    cout << "clear() passed!" << endl;
}

// Test size and isEmpty methods
void testSize() {
    cout << "Testing size method... ";
    
    DLList list;
    assert(list.size() == 0);
    
    IndexedToken token("apple", 1);
    list.addBefore(token, 0);
    assert(list.size() == 1);
    
    list.remove(0);
    assert(list.size() == 0);
    
    cout << "size() passed!" << endl;
}

void testIsEmpty() {
    cout << "Testing isEmpty method... ";
    
    DLList list;
    assert(list.isEmpty());
    
    IndexedToken token("apple", 1);
    list.addBefore(token, 0);
    assert(!list.isEmpty());
    
    list.remove(0);
    assert(list.isEmpty());
    
    cout << "isEmpty() passed!" << endl;
}

// Test copy constructor
void testCopyConstructor() {
    cout << "Testing copy constructor... ";
    
    DLList list1;
    IndexedToken token1("apple", 1);
    IndexedToken token2("banana", 2);
    list1.addBefore(token1, 0);
    list1.addBefore(token2, 0);
    
    DLList list2(list1);
    assert(list2.size() == 2);
    assert(list2.getIndexedToken(0).compare("banana") == 0);
    assert(list2.getIndexedToken(1).compare("apple") == 0);
    
    // Modify original to verify deep copy
    list1.remove(0);
    assert(list1.size() == 1);
    assert(list2.size() == 2); // Should remain unchanged
    
    cout << "copy ctor passed!" << endl;
}

// Test copy assignment
void testCopyAssignment() {
    cout << "Testing copy assignment operator... ";
    
    DLList list1;
    IndexedToken token1("apple", 1);
    IndexedToken token2("banana", 2);
    list1.addBefore(token1, 0);
    list1.addBefore(token2, 0);
    
    DLList list2;
    IndexedToken token3("cherry", 3);
    list2.addBefore(token3, 0);
    
    list2 = list1; // Copy assignment
    assert(list2.size() == 2);
    assert(list2.getIndexedToken(0).compare("banana") == 0);
    assert(list2.getIndexedToken(1).compare("apple") == 0);
    
    // Modify original to verify deep copy
    list1.remove(0);
    assert(list1.size() == 1);
    assert(list2.size() == 2); // Should remain unchanged
    
    cout << "copy assignment passed!" << endl;
}

// Test move constructor
void testMoveConstructor() {
    cout << "Testing move constructor... ";
    
    DLList list1;
    IndexedToken token1("apple", 1);
    IndexedToken token2("banana", 2);
    list1.addBefore(token1, 0);
    list1.addBefore(token2, 0);
    
    DLList list2(move(list1));
    assert(list2.size() == 2);
    assert(list2.getIndexedToken(0).compare("banana") == 0);
    assert(list2.getIndexedToken(1).compare("apple") == 0);
    
    // Original list should be empty after move
    assert(list1.isEmpty());
    assert(list1.size() == 0);
    
    cout << "move ctor passed!" << endl;
}

// Test move assignment
void testMoveAssignment() {
    cout << "Testing move assignment operator... ";
    
    DLList list1;
    IndexedToken token1("apple", 1);
    IndexedToken token2("banana", 2);
    list1.addBefore(token1, 0);
    list1.addBefore(token2, 0);
    
    DLList list2;
    IndexedToken token3("cherry", 3);
    list2.addBefore(token3, 0);
    
    list2 = move(list1); // Move assignment
    assert(list2.size() == 2);
    assert(list2.getIndexedToken(0).compare("banana") == 0);
    assert(list2.getIndexedToken(1).compare("apple") == 0);
    
    // Original list should be empty after move
    assert(list1.isEmpty());
    assert(list1.size() == 0);
    
    cout << "move assignment passed!" << endl;
}

// Test print method
void testPrint() {
    std::cout << "Testing print method..." << std::endl;
    
    DLList list;
    IndexedToken token1("apple", 1);
    token1.appendLineNumber(3);
    IndexedToken token2("banana", 2);
    list.addBefore(token1, 0);
    list.addBefore(token2, 0);
    
    std::cout << "Print output:" << std::endl;
    list.print(std::cout);
    std::cout << std::endl;
    
    std::cout << "print() finished." << std::endl;
}