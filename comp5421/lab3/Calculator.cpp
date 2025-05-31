/*
*
Author: Avi Lad [TA]
COMP 5421
Compiled on Visual Studio C++

Lab-2

Files :
    Lab2.cpp
    Calculator.h
    Calculator.cpp
*/

#include "Calculator.h"

// default constructor
Calculator::Calculator() : result(0), numberOfOperations(0) {
    cout << "Default Constructor Called!! \n";
}
//Calculator::Calculator() { Calculator(0); }

//parameterized constructor
Calculator::Calculator(double res) : result(res), numberOfOperations(0){
    str = new char[20];
    cout << "Parameterized Constructor Called!! \n";

} 

//Destructor
Calculator::~Calculator() {
    delete[] str;
    cout << "\n!!! Destructor is Called for Calculator class!!! \n";
}

//Copy Constructor
Calculator::Calculator(const Calculator& other) : result(other.result), numberOfOperations(other.numberOfOperations) {
    cout << "Copy Constructor Called!! \n";
}

//Copy Assingment Operator
Calculator& Calculator::operator=(const Calculator& other) {
    cout << "Copy Assignment Operator Called!! \n";

    if (this != &other) {
        //Battery b;
        //b = other.b;
        result = other.result;
        numberOfOperations = other.numberOfOperations;
    }

    return *this;
}

//Move Constructor
Calculator::Calculator(Calculator&& other) : result(other.result), numberOfOperations(other.numberOfOperations) {
    cout << "Move Constructor Called!! \n";
    other.result = 0.0;
    numberOfOperations = 0;
}

//Move Assignment Operator
Calculator& Calculator::operator=(Calculator&& other ) {
    cout << "Move Assignment Operator Called!! \n";

    if (this != &other) {
        result = other.result;
        numberOfOperations = other.numberOfOperations;

        other.result = 0.0;
        other.numberOfOperations = 0;
    }

    return *this;
}


void Calculator::add(double x) {
    result += x;
    numberOfOperations++;
}

void Calculator::multiply(double x) {
    result *= x;
    numberOfOperations++;
}
double Calculator::getResult() const {
    return result;
}


void dynamicMemoryAlloc() {
    cout << "\n\n Start of Dynamic Memory Topics --------- \n";

    // static allocation on stack
    // int a = 10;

    int* num = new int{ 10 };
    cout << "Value at pointer num : " << *num << "\n";

    delete num;

    //    cout << "Value at pointer num : " << *num << "\n";  // error


    char* strPtr = new char[10] {"Montreal"};
    //    char* strPtr = new char[10];
    //    char copyval[] = "Montreal";
    //    strcpy(strPtr, copyval);

    cout << "Value at pointer strPtr : " << strPtr << "\n";

    delete[] strPtr;


    // fileTokens


    string fileName = "tokens.txt";

    ifstream file(fileName.c_str());

    if (!file) {
        cerr << "!!! Error opening file !!!!\n\n";
        exit(1);
    }

    cout << "File Contents are as below : \n";
    int lineNumber = 0;
    string line;
    while (getline(file, line)) {
        lineNumber++;

        stringstream strm(line);
        string word;
        cout << lineNumber << ":  ";
        while (strm >> word) {
            cout << word << ", ";
            //            createToken(word.c_str(), lineNumber);
        }
        cout << "\n";
    }


    file.close();

    cout << "\n!!!! End of Dynamic Memory Topics --------\n\n";



}


void constAndFunctionParams() {
    cout << "\n\n Start of Const and Function Params Topics --------- \n";

    const int constNum = 20;
    // constNum = 30; //error
    cout << "Variable constNum : " << constNum << "\n";

    const int arr[] = { 1, 2, 3 };
    // arr = { 3,4,5 };  // error
    // arr[0] = 10;     //error

    int a = 10, b = 15;


    //pass-by-value
    int sum = add(a, b);

    cout << "Variable a : " << a << "\n";
    cout << "Variable b : " << b << "\n";
    cout << "Variable sum : " << sum << "\n";


    //pass-by-reference
    int difference = subtract(a, b);

    cout << "Variable a : " << a << "\n";
    cout << "Variable b : " << b << "\n";
    cout << "Variable difference : " << difference << "\n";

    //pass-by-const-reference
    int product = multiply(a, b);

    cout << "Variable a : " << a << "\n";
    cout << "Variable b : " << b << "\n";
    cout << "Variable product : " << product << "\n";


}

// pass-by-value
int add(int a, int b) {
    a = 50;
    b = 40;
    return a + b;
}

// pass-by-reference
int subtract(int& a, int& b) {
    a = 100;
    b = 90;
    return a - b;
}

// pass-by-const-reference
int multiply(const int& a, const int& b) {
    //a = 5; //error
    //b = 5; //error
    return a * b;
}