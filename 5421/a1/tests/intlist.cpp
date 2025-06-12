#include "../IntList.h"
#include <iostream>
#include <sstream>

using namespace std;

// Function to test and print a result
void test(const char* testName, bool condition) {
    cout << testName << ": " << (condition ? "PASSED" : "FAILED") << endl;
}

// Function to capture output from print method
string captureOutput(const IntList& list) {
    ostringstream oss;
    list.print(oss);
    return oss.str();
}

int main() {
    cout << "=== INTLIST CLASS TESTS ===" << endl;

    // Test default constructor
    cout << "\n[Testing Default Constructor]" << endl;
    IntList list1;
    test("Default constructor creates empty list", list1.isEmpty());
    test("Default constructor sets size to 0", list1.getSize() == 0);

    // Test append method
    cout << "\n[Testing append Method]" << endl;
    list1.append(10);
    test("append adds element", list1.getSize() == 1);
    test("append stores correct value", list1.getElementAt(0) == 10);
    list1.append(20);
    test("append adds second element", list1.getSize() == 2);
    test("append maintains existing elements", list1.getElementAt(0) == 10);
    test("append stores second value correctly", list1.getElementAt(1) == 20);

    // Test resize (indirectly)
    cout << "\n[Testing resize Behavior]" << endl;
    // Add more elements to trigger resize
    list1.append(30);
    list1.append(40);
    list1.append(50);
    test("List grows as needed", list1.getSize() == 5);
    test("List maintains all elements after resize", 
         list1.getElementAt(0) == 10 && 
         list1.getElementAt(4) == 50);

    // Test copy constructor
    cout << "\n[Testing Copy Constructor]" << endl;
    IntList list2(list1);
    test("Copy constructor creates list of same size", list2.getSize() == list1.getSize());
    test("Copy constructor copies elements correctly", 
         list2.getElementAt(0) == 10 && 
         list2.getElementAt(4) == 50);

    // Test clear method
    cout << "\n[Testing clear Method]" << endl;
    list2.clear();
    test("clear empties the list", list2.isEmpty());
    test("clear resets size to 0", list2.getSize() == 0);

    // Test copy assignment operator
    cout << "\n[Testing Copy Assignment Operator]" << endl;
    IntList list3;
    list3 = list1;
    test("Copy assignment creates list of same size", list3.getSize() == list1.getSize());
    test("Copy assignment copies elements correctly", 
         list3.getElementAt(0) == 10 && 
         list3.getElementAt(4) == 50);

    // Test move constructor
    cout << "\n[Testing Move Constructor]" << endl;
    IntList list4((IntList(list1)));
    test("Move constructor creates list of correct size", list4.getSize() == 5);
    test("Move constructor preserves elements", 
         list4.getElementAt(0) == 10 && 
         list4.getElementAt(4) == 50);

    // Test move assignment operator
    cout << "\n[Testing Move Assignment Operator]" << endl;
    IntList list5;
    list5 = std::move(IntList(list1));
    test("Move assignment creates list of correct size", list5.getSize() == 5);
    test("Move assignment preserves elements", 
         list5.getElementAt(0) == 10 && 
         list5.getElementAt(4) == 50);

    // Test isFull method
    cout << "\n[Testing isFull Method]" << endl;
    IntList list6;
    int initialCapacity = list6.getCapacity();
    cout << "Initial capacity: " << initialCapacity << endl;
    
    // First append should trigger resize
    list6.append(1);
    cout << "first append size: " << list6.getSize() << "\n";
    cout << "first append capacity: " << list6.getCapacity() << "\n";
    test("capacity equals 2 after first resize", list6.getCapacity() == 2);
    test("after first append, list is not full", !list6.isFull());
    initialCapacity = list6.getCapacity();    
    
    // After second append
    list6.append(2);
    test("list is filled to capacity", list6.isFull());
    cout << "second append size: " << list6.getSize() << "\n";
    cout << "second append capacity: " << list6.getCapacity() << "\n";
    int beforeResizeCapacity = list6.getCapacity();
    
    // Third append will trigger resize
    list6.append(3);
    cout << "third append size: " << list6.getSize() << "\n";
    cout << "third append capacity: " << list6.getCapacity() << "\n";
    test("Capacity doubled after resize", list6.getCapacity() == beforeResizeCapacity * 2);

    // Test print method
    cout << "\n[Testing print Method]" << endl;
    IntList list7;
    list7.append(10);
    list7.append(20);
    list7.append(30);
    string output = captureOutput(list7);
    test("print outputs elements in correct format", output == "10, 20, 30");
    
    // Test getElementAt with invalid index
    cout << "\n[Testing getElementAt with invalid index]" << endl;
    IntList list8;
    bool exceptionThrown = false;
    try {
        list8.getElementAt(0); // Should throw exception
    } catch (const std::out_of_range&) {
        exceptionThrown = true;
    }
    test("getElementAt throws exception for invalid index", exceptionThrown);

    cout << "\n=== All intlist tests complete! ===\n\n" << endl;
    
    return 0;
}