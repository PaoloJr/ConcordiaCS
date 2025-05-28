#include <iostream>
using namespace std;

int main() {
    // pointers section
    cout << "pointers section\n";
    int x = 10;
    int* y = &x;
    cout << "x (the object) = "<<x<<"\n";
    cout << "int* y (the address of y - &x) = "<<y<<"\n";
    cout << "*y (the dereferenced pointer) = "<<*y<<"\n";
    
    // references section
    cout << "\nreferences section\n";
    int& z = x;
    cout << "z (the variable z - object x) = "<<z<<"\n";
    cout << "&z (the address of z - reference to x) = "<<&z<<"\n";

    // other
    cout << "\nother section\n";
    int a;
    cout <<"a (other var) = "<<a<<"\n";
}