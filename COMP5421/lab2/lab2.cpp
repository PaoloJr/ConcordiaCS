/*
Topics:
Pointers (continued)
Reference Variables
cctype functions
C-style strings
C-string functions (cstring)
File I/O
*/

#include <iostream>
#include <cstring>
#include <cctype>
#include <fstream>
#include <string>

using namespace std;

void cStringFunctions() {

	char word1[30] = "Montreal", word2[30] = "Canada";
	//	char word1[30] = "Montreal", word2[30] = "montreal";

	//	cin >> word1;
	//	cin >> word2;

		// Length
	int length1 = strlen(word1);
	cout << "length of word1 is :" << length1 << "\n";

	int length2 = strlen(word2);
	cout << "length of word2 is :" << length2 << "\n";


	// Compare
	int compareResult = strcmp(word1, word2);
	if (compareResult == 0) {
		cout << "word1 and word2 are same \n";
	}
	else if (compareResult < 0) {
		cout << "word1 is smaller than word2\n";
	}
	else {
		cout << "word1 is bigger than word2\n";
	}

	// concatenation

	if (strlen(word1) + strlen(word2) < 30) {
		// strcat_s(word1, word2);
		cout << "word1 : " << word1 << "\n";
		cout << "word2 : " << word2 << "\n";
	}
	else {
		cout << "The strings cannot be concatenated !!! \n";
	}


	//copy
	char copyWord1[30];
	// strcpy_s(copyWord1, word1);
	cout << "The copied word1 is : " << copyWord1 << "\n";
}

void pointersRevisit() {
	int a = 10;
	int& b = a;

	cout << a << "\n" << b << "\n";

	b = 20;

	cout << a << "\n" << b;


	int* ptr1 = &a;
	int** ptr2 = &ptr1;
	int*** ptr3 = &ptr2;

	cout << "pointer 2 value : " << **ptr2 << "\n";
	cout << "pointer 1 pointer address : " << ptr1 << "\n";
	cout << "pointer 2 pointer address : " << ptr2 << "\n";
	cout << "pointer 3 pointer address : " << ptr3 << "\n";
	cout << "Variable A address : " << &a << "\n";

}

void charStrings() {
	char c = '1';

	if (isalpha(c)) {
		cout << "variable c is an alphabet !! \n";
	}
	else {
		cout << "variable c is NOT an alphabet !! \n";
	}

	if (isdigit(c)) {
		cout << "variable " << c << " is a digit !! \n";
	}
	else {
		cout << "variable c is NOT a digit !! \n";
	}

	cout << c << '\n';

	char arr[20] = "avi";
	// '\0'
	cout << arr << "\n";
	//arr[0] = 'A';
	arr[0] = toupper(arr[0]);
	cout << arr << '\n';

	arr[0] = toupper(arr[0]);
	cout << arr << '\n';

	arr[0] = tolower(arr[0]);
	cout << arr << '\n';



	char* strPtr = (char*)"this is a string pointer";
	cout << strPtr << '\n';
	strPtr[0] = 'T';
	cout << strPtr;

}

int fileIO() {

	const char* file1 = (char*)"data1.txt";

	ofstream fileOutputStream(file1);
	// ofstream fileOutputStream(file1, ios::app);
	// fileOutputStream.open(file1);

	if (!fileOutputStream) {
		cerr << "Error: File cannot be opened !!!";

		return 1;
	}

	fileOutputStream << "This is a new file with words!!!\n";

	cout << " Enter words you want to add to file. (enter \"end\" to exit)";
	while (true) {
		char word[50];
		cin >> word;

		if (strcmp(word, "end") == 0) {
			break;
		}

		fileOutputStream << word << "\n";

	}

	cout << "\nInsert into file is complete, closing the outputstream now!!! \n";

	fileOutputStream.close();

	ifstream fileInputStream;
	fileInputStream.open(file1);

	if (!fileInputStream) {
		cerr << "Error: Cannot open the file input stream for " << file1 << "\n";
		return 1;
	}


	cout << "\n\nContent of fileInputStream are : \n";

	while (!fileInputStream.eof()) {
		//string str;
		//getline(fileInputStream, str);
		//cout << str<<endl;

		char input[100];
		fileInputStream >> input;
		//fileInputStream.getline(input, 100);
		cout << input<<endl;
	}

	cout << "\n Reading from the file is complete, closing the inputstream now!!! \n";
	fileInputStream.close();

	return 0;
}

int main()
{
	charStrings();
	cStringFunctions();
	fileIO();

	return 0;
} 