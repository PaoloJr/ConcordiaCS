#include "../Indexer.h"
#include <iostream>
#include <cassert>
#include <sstream>
#include <fstream>
using namespace std;

void testDefaultConstructor();
void testProcessTextFile();
void testClear();
void testIsEmpty();
void testSearchByLength();
void testDisplaySection();
void testPrint();
void testGetTokenCount();

int main() {
    cout << "Running Indexer tests..." << endl;
    
    testDefaultConstructor();
    testProcessTextFile();
    testClear();
    testIsEmpty();
    testSearchByLength();
    testDisplaySection();
    testPrint();
    testGetTokenCount();
    
    cout << "\n=== All indexer tests passed! ===\n\n" << endl;
    return 0;
}

// Test default constructor
void testDefaultConstructor() {
    cout << "\nTesting default constructor... " << endl;
    
    Indexer indexer;
    assert(indexer.isEmpty());
    
    cout << "default ctor passed!" << endl;
}

// Test processTextFile method
void testProcessTextFile() {
    cout << "\nTesting processTextFile method... " << endl;
    
    // Create a temporary test file
    string testFileName = "../samples/test_file.txt";
    ofstream testFile(testFileName);
    
    if (!testFile.is_open()) {
        cerr << "Failed to create test file" << endl;
        return;
    }
    
    testFile << "Hello world\n";
    testFile << "Testing the indexer\n";
    testFile << "#hashtag test\n";
    testFile.close();
    
    Indexer indexer;
    indexer.processTextFile(testFileName);
    
    // Verify indexer is not empty after processing
    assert(!indexer.isEmpty());
    
    // Clean up test file
    remove(testFileName.c_str());
    
    cout << "processTextFile() passed!" << endl;
}

// Test clear method
void testClear() {
    cout << "\nTesting clear method... " << endl;
    
    // Create indexer and add content
    Indexer indexer;
    
    // Create a temporary test file
    string testFileName = "../samples/test_file.txt";
    ofstream testFile(testFileName);
    testFile << "Sample text" << endl;
    testFile.close();
    
    indexer.processTextFile(testFileName);
    assert(!indexer.isEmpty());
    
    // Clear and verify empty
    indexer.clear();
    assert(indexer.isEmpty());
    
    // Clean up
    remove(testFileName.c_str());
    
    cout << "clear() passed!" << endl;
}

// Test isEmpty method
void testIsEmpty() {
    cout << "\nTesting isEmpty method... " << endl;
    
    Indexer indexer;
    assert(indexer.isEmpty());
    
    // Create temporary file
    string testFileName = "../samples/test_file.txt";
    ofstream testFile(testFileName);
    testFile << "Sample text" << endl;
    testFile.close();
    
    // Process and verify not empty
    indexer.processTextFile(testFileName);
    assert(!indexer.isEmpty());
    
    // Clear and verify empty
    indexer.clear();
    assert(indexer.isEmpty());
    
    // Clean up
    remove(testFileName.c_str());
    
    cout << "isEmpty() passed!" << endl;
}

// Test searchByLength method
void testSearchByLength() {
    cout << "\nTesting searchByLength method... " << endl;
    
    // Create indexer with specific content
    Indexer indexer;
    
    string testFileName = "../samples/test_file.txt";
    ofstream testFile(testFileName);
    testFile << "cat dog hello world" << endl;
    testFile.close();
    
    indexer.processTextFile(testFileName);
    
    cout << "Searching for tokens with length 3..." << endl;
    cout << "Expected tokens: 'cat', 'dog'" << endl;
    
    // Simply print the output to see results
    cout << "Actual output:" << endl;
    indexer.searchByLength(3);
        
    // Clean up
    remove(testFileName.c_str());
    
    cout << "searchByLength() completed." << endl;
}

// Test displaySection method
void testDisplaySection() {
    cout << "\nTesting displaySection method..." << endl;
    
    // Create indexer with content in different sections
    Indexer indexer;
    
    string testFileName = "../samples/test_file.txt";
    ofstream testFile(testFileName);
    testFile << "apple banana cat #hashtag" << endl;
    testFile.close();
    
    indexer.processTextFile(testFileName);
    
    // Simply print the section output
    cout << "Expected: Section 'A' should contain 'apple'" << endl;
    cout << "Actual output:" << endl;
    indexer.displaySection('A');
    
    // Clean up
    remove(testFileName.c_str());
    
    cout << "displaySection() completed." << endl;
}

// Test print method
void testPrint() {
    cout << "\nTesting print method... " << endl;
    
    Indexer indexer;
    
    string testFileName = "../samples/test_file.txt";
    ofstream testFile(testFileName);
    testFile << "apple\nbanana\ncat" << endl;
    testFile.close();
    
    indexer.processTextFile(testFileName);
    
    // Simply print the output
    cout << "Expected: Sections 'A' (apple: 1), 'B' (banana: 2), and 'C' (cat: 3)" << endl;
    cout << "Actual output:" << endl;
    indexer.print(cout);
    
    // Clean up
    remove(testFileName.c_str());
    
    cout << "print() finished!" << endl;
}

// Test getTokenCount method
void testGetTokenCount() {
    cout << "\nTesting getTokenCount method... " << endl;
    
    Indexer indexer;
    
    // Empty indexer should have 0 tokens
    assert(indexer.getTokenCount() == 0);
    
    // Create test file with known number of tokens
    string testFileName = "../samples/test_file.txt";
    ofstream testFile(testFileName);
    testFile << "apple banana" << endl;
    testFile << "apple cat" << endl; // "apple" appears twice
    testFile.close();
    
    indexer.processTextFile(testFileName);
    
    // Should count 4 token occurrences (apple appears twice)
    assert(indexer.getTokenCount() == 4);
    
    // Clean up
    remove(testFileName.c_str());
    
    cout << "getTokenCount() passed!" << endl;
}