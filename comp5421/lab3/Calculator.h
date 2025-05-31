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


#ifndef Calculator_H

#define Calculator_H

#include <iostream>
#include <fstream>
#include<string>
#include<sstream>

#define PI 3.14

using namespace std;

void constAndFunctionParams();
int add(int, int);
int subtract(int&, int&);
int multiply(const int&, const int&);

void dynamicMemoryAlloc();

class Calculator {
private:
	char* str;
	double result;
	int numberOfOperations;

public:
	//Constructors and Destructors

	Calculator();
	Calculator(double);

	// The Five Special Member Functions
	//Destructor
	~Calculator();
	
	//Copy Constructor
	Calculator(const Calculator&);

	//Copy Assingment Operator
	Calculator& operator=(const Calculator&);

	//Move Constructor 
	Calculator(Calculator&&);

	//Move Assignment Operator
	Calculator& operator=(Calculator&&);

	void add(double);
	void multiply(double);
	double getResult() const;
};


#endif