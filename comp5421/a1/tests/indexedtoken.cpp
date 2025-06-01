#include "../IndexedToken.h"
#include <iostream>
#include <sstream>
#include <string.h>

using namespace std;

// Function to test and print a result
void test(const char* testName, bool condition) {
    cout << testName << ": " << (condition ? "PASSED" : "FAILED") << endl;
}

// Function to capture output from print method
string captureOutput(const IndexedToken& token) {
    ostringstream oss;
    token.print(oss);
    return oss.str();
}

int main() {
    cout << "=== INDEXEDTOKEN CLASS TESTS ===" << endl;

    // Test constructor with C-string and line number
    cout << "\n[Testing Constructor with C-string]" << endl;
    IndexedToken token1("hello", 5);
    test("Constructor with C-string sets token correctly", strcmp(token1.getToken().c_str(), "hello") == 0);
    test("Constructor adds line number", token1.getLineNumbers().getSize() == 1);
    test("Constructor stores correct line number", token1.getLineNumbers().getElementAt(0) == 5);

    // Test constructor with Token object and line number
    cout << "\n[Testing Constructor with Token object]" << endl;
    Token t("world");
    IndexedToken token2(t, 10);
    test("Constructor with Token sets token correctly", strcmp(token2.getToken().c_str(), "world") == 0);
    test("Constructor adds line number", token2.getLineNumbers().getSize() == 1);
    test("Constructor stores correct line number", token2.getLineNumbers().getElementAt(0) == 10);

    // Test appendLineNumber method
    cout << "\n[Testing appendLineNumber Method]" << endl;
    token1.appendLineNumber(15);
    test("appendLineNumber adds to list", token1.getLineNumbers().getSize() == 2);
    test("appendLineNumber preserves first line", token1.getLineNumbers().getElementAt(0) == 5);
    test("appendLineNumber adds correct line", token1.getLineNumbers().getElementAt(1) == 15);
    
    // Add more line numbers
    token1.appendLineNumber(25);
    token1.appendLineNumber(35);
    test("appendLineNumber works for multiple additions", token1.getLineNumbers().getSize() == 4);
    test("Line numbers are stored correctly", 
         token1.getLineNumbers().getElementAt(0) == 5 &&
         token1.getLineNumbers().getElementAt(3) == 35);

    // Test getToken method
    cout << "\n[Testing getToken Method]" << endl;
    const Token& retrievedToken = token1.getToken();
    test("getToken returns correct token", strcmp(retrievedToken.c_str(), "hello") == 0);

    // Test getLineNumbers method
    cout << "\n[Testing getLineNumbers Method]" << endl;
    const IntList& lines = token1.getLineNumbers();
    test("getLineNumbers returns correct size", lines.getSize() == 4);
    test("getLineNumbers returns correct line numbers",
         lines.getElementAt(0) == 5 &&
         lines.getElementAt(1) == 15 &&
         lines.getElementAt(2) == 25 &&
         lines.getElementAt(3) == 35);

    // Test print method
    cout << "\n[Testing print Method]" << endl;
    string output = captureOutput(token1);
    cout << "Print output: [" << output << "]" << endl;
    test("print outputs token and line numbers", 
         output.find("hello") != string::npos &&
         output.find("5") != string::npos &&
         output.find("15") != string::npos);

    // Test compare with C-string
    cout << "\n[Testing compare with C-string]" << endl;
    test("compare with equal string returns 0", token1.compare("hello") == 0);
    test("compare with lexicographically smaller string returns >0", token1.compare("apple") > 0);
    test("compare with lexicographically larger string returns <0", token1.compare("zebra") < 0);

    // Test compare with IndexedToken
    cout << "\n[Testing compare with IndexedToken]" << endl;
    IndexedToken token3("hello", 20);
    IndexedToken token4("apple", 30);
    IndexedToken token5("zebra", 40);
    
    test("compare with equal token returns 0", token1.compare(token3) == 0);
    test("compare with lexicographically smaller token returns >0", token1.compare(token4) > 0);
    test("compare with lexicographically larger token returns <0", token1.compare(token5) < 0);

    cout << "\nAll IndexedToken tests complete!" << endl;
    
    return 0;
}