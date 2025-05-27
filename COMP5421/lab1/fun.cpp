#include <iostream>
using namespace std;

int main() {
    int x = 10;
    cout << "x (the object) = "<<x<<"\n";
    cout << "&x (the address) = "<<&x<<"\n";
    int& z = x;
    cout << "z (object in x) = "<<z<<"\n";
    int* y = &x;
    cout << "int* y (the address) = "<<y<<"\n";
    cout << "*y (the object, dereferencing) = "<<*y<<"\n";
    cout << "&y (address of the pointer variable) = "<<&y<<"\n";
    int a;
    cout <<"a (other var) = " <<a<<"\n";
}