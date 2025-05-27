#include <iostream>
using namespace std;

int main() {
    int x = 10;
    cout << "x (the object) = "<<x<<"\n";
    cout << "x (the address) = "<<&x<<"\n";
    x = 20;
    cout << "x (updated) = "<<x<<"\n";
    int* y = &x;
    cout << "int* y (the address) = "<<y<<"\n";
    cout << "*y (the object, dereferencing) = "<<*y<<"\n";
    cout << "&y (address of the pointer variable) = "<<&y<<"\n";
    int z;
    cout <<"z (other var) = " <<z<<"\n";
}