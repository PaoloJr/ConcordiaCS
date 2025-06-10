/*
Introduction to C++
Topics:
Variables
Console I/O
Methods
Method Overloading
Type-Casting
Pointers
Structures
Classes
Constructor & Destructors
Constructor Overloading
*/

#include<iostream>
using namespace std;

void intro();
void hello(int e);
void hello(float e);
void hello(char e);
void pointer();
void structsAndClasses();

class Vehicle {
private:
	int price;
	long mileage;
	char type;

public:
	Vehicle() {

	}

	Vehicle(int price, long mileage, char type) {
		cout << "!! Contructor is called !!!!";
		this->price = price;
		this->mileage = mileage;
		this->type = type;
	}

	~Vehicle() {
		cout << " !! Destructor is called !!!";
	}

	int getPrice() {
		return price;
	}

	long getMileage() {
		return mileage;
	}

	char getType() {
		return type;
	}
};

struct Car {
	int price;
	long mileage;
};

int main() {

	intro();
	structsAndClasses();
	pointer();

	return 0;
}

void intro(){
	int i = 10;
	long l;
	float f = 1.1;
	double d;
	char c = 'A';
	bool b;


	//cout << "Hello!!!"<< " 123 "<<i<<"\n";

	hello(float(i));

	//cin >> i >> f>>c;

	//cout << "Hello!!!" << " 123 " << i << "\n";
	hello(char(i));

	//cout << "Hello!!!" << " 123 " << f << "\n";
	hello(f);

	//cout << "Hello!!!" << " 123 " << c << "\n";
	hello(c);

}

void structsAndClasses() {

	Vehicle v1(1, 2, 'A');
	cout << "Vehicle 1 : " << v1.getPrice() << " , " << v1.getMileage() <<" , "<<v1.getType()<<"\n";

	Car c1;
	c1.price = 1000;
	c1.mileage = 100000;

	cout << "Car 1 : " << c1.price <<" , " << c1.mileage <<"\n";

	Car c2 = {20, 200};
	cout << "Car 1 : " << c2.price << " , " << c2.mileage << "\n";

	cout << "\n\nEnd of structs and Classes function!!!!\n\n\n";
}

void pointer() {
	int a = 10;

	cout << "Variable A : " << a << "\n";

	int *b, *c;

	b = &a;
	cout << " Pointer B value: " << b << "\n";
	cout << " Value at the location pointed by Pointer B : " << *b << "\n";


	a = 25;

	cout << "\n Variable A : " << a << "\n";
	cout << " Pointer B value: " << b << "\n";
	cout << " Value at the location pointed by Pointer B : " << *b << "\n";
	cout << "End of Pointers Function!!! \n\n\n";


	*b = 50;

	cout << "\n Variable A : " << a << "\n";
	cout << " Pointer B value: " << b << "\n";
	cout << " Value at the location pointed by Pointer B : " << *b << "\n";
	cout << "End of Pointers Function!!! \n\n\n";


	int z = 111;
	b = &z;
	cout << "\n Variable A : " << a << "\n";
	cout << "\n Variable Z : " << z << "\n";
	cout << " Pointer B value: " << b << "\n";
	cout << " Value at the location pointed by Pointer B : " << *b << "\n";


	int arr[] = { 1,2,3 };
	int *d = &(arr[0]);
	cout << "\narray:  ";
	cout << *d << ", " << *(d+1) << ", " << *(d+2) << ", ";
	cout << "End of Pointers Function!!! \n\n\n";

}

void hello(int i) {
	cout << "Hello!!!" << " 123 " << i << "\n";
}

void hello(float d) {
	cout << "Float!!!" << " 123 " << d << "\n";
}

void hello(char d) {
	cout << "Char!!!" << " 123 " << d << "\n";
}

/*

int b = a;

--------------
0 |		10			int a
-------------
1 |
--------------
2 |     
--------------
3 |     10			int b
--------------

int *b = &a;

--------------
0 |		10			int a
-------------
1 |
--------------
2 |
--------------
3 |     0			int *b
--------------

cout<<*b;
int c = *b;
// c==10

*/