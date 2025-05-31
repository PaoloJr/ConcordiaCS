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

Topics:
    Auto Type
    Macros
    Const Keyword (Variables, Functions)
    Function Param Types (Pass-by-Value, Pass-by-Reference, Pass-by-Const-Reference)
    Dynamic Memory Allocation (new, delete, new[], delete[])
    File-reading (getline, reading tokens, sstream, string to char* etc.)
    Header and Implementation files (function declaration-definition, class declaration-definition, #ifndef #endif #define)
    The Five Special Member Functions
        Destructor
        Copy Constructor
        Copy Assignment Operator
        Move Constructor
        Move Assignment Operator
    ->(arrow) vs .(dot) usage
*/

#include "Calculator.h"


int main()
{
     
    // auto variable types
    auto a = 10l;
    cout << "Variable a : " << a << "\n";  
    cout << "Type of Variable a : " << typeid(a).name() << "\n";

    //Macro
    cout << "Macro PI : " << PI << "\n";

//    constAndFunctionParams();
 
     
//    dynamicMemoryAlloc();

    cout << "\n\n Start of The 5 special Members ----------\n";

    Calculator c1; // default constructor
    cout << c1.getResult() << "\n";

    Calculator c2{ 10 }; // param constructor
    cout << c2.getResult() << "\n";

    Calculator* ptr = &c2;
//    cout << (*ptr).getResult() << "\n";
    cout << ptr->getResult() << "\n";


    //copy constructor
    Calculator c3(c2); 
    cout << c3.getResult() << "\n";

    //move constructor
    Calculator c4 = move(c3);
    cout << "c3 : " << c3.getResult() << "\n";
    cout << "c4 : " << c4.getResult() << "\n";

    // copy Assignment operator
    c3 = c4;
    cout << "c3 : " << c3.getResult() << "\n";
    cout << "c4 : " << c4.getResult() << "\n";

    c4.add(20);

    // move Assignment operator
    c3 = move(c4);
    cout << "c3 : " << c3.getResult() << "\n";
    cout << "c4 : " << c4.getResult() << "\n";


    return 0;
}