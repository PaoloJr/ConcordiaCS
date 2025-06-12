#include "../Token.h"
#include <iostream>
#include <string.h>

using namespace std;

// Function to test and print a result
void test(const char* testName, bool condition) {
    cout << testName << ": " << (condition ? "PASSED" : "FAILED") << endl;
}

int main() {
    cout << "=== TOKEN CLASS TESTS ===" << endl;

    // Test default constructor
    cout << "\n[Testing Default Constructor]" << endl;
    Token t1;
    test("Default ctor creates empty token", t1.length() == 0);
    test("Default ctor creates null-terminated string", t1.c_str()[0] == '\0');

    // Test parameterized constructor
    cout << "\n[Testing Parameterized Constructor]" << endl;
    Token t2("hello");
    test("Parameterized ctor sets correct text", strcmp(t2.c_str(), "hello") == 0);
    test("Parameterized ctor sets correct length", t2.length() == 5);
    
    // Test with empty string
    Token t3("");
    test("Parameterized ctor with empty string creates empty token", t3.length() == 0);
    
    // Test with nullptr
    Token t4(nullptr);
    test("Parameterized ctor with nullptr creates empty token", t4.length() == 0);

    // Test copy constructor
    cout << "\n[Testing Copy Constructor]" << endl;
    Token t5(t2);
    test("Copy ctor creates identical token", strcmp(t5.c_str(), t2.c_str()) == 0);
    test("Copy ctor creates independent memory", t5.c_str() != t2.c_str());

    // Test copy assignment operator
    cout << "\n[Testing Copy Assignment Operator]" << endl;
    Token t6;
    t6 = t2;
    test("Copy assignment creates identical token", strcmp(t6.c_str(), t2.c_str()) == 0);
    test("Copy assignment creates independent memory", t6.c_str() != t2.c_str());

    // Test move constructor
    cout << "\n[Testing Move Constructor]" << endl;
    Token t7(Token("world"));
    test("Move ctor creates correct token", strcmp(t7.c_str(), "world") == 0);

    // Test move assignment operator
    cout << "\n[Testing Move Assignment Operator]" << endl;
    Token t8;
    t8 = std::move(Token("test"));
    test("Move assignment creates correct token", strcmp(t8.c_str(), "test") == 0);

    // Test getFirstChar
    cout << "\n[Testing getFirstChar]" << endl;
    test("getFirstChar returns correct char", t2.getFirstChar() == 'h');
    test("getFirstChar for empty token returns null char", t1.getFirstChar() == '\0');

    // Test length
    cout << "\n[Testing length]" << endl;
    test("length returns correct size", t2.length() == 5);
    test("length for empty token returns 0", t1.length() == 0);

    // Test compare
    cout << "\n[Testing compare]" << endl;
    Token t9("apple");
    Token t10("banana");
    test("compare with lexicographically smaller token", t9.compare(t10) < 0);
    test("compare with lexicographically larger token", t10.compare(t9) > 0);
    test("compare with identical token", t2.compare(t5) == 0);

    // Test print
    cout << "\n[Testing print]" << endl;
    cout << "Print test (should show 'hello'): ";
    t2.print(cout);
    cout << endl;

    cout << "\n=== All token tests complete! ===\n\n" << endl;
    
    return 0;
}