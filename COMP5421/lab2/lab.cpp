#include <iostream>
#include <cstring>
#include <cctype>
#include <fstream>

using namespace std;

void cStringFunctions() {
	char word1[30] = "Montreal", word2[20] = "montreal";


	// length
	int length1 = strlen(word1);
	cout << "length of word1 is: " << length1 << '\n';

	int length2 = strlen(word2);
	cout << "length of word is: " << length2 << '\n';

	// compare
	int compareResult = strcmp(word1, word2);
	if (compareResult == 0) {
		cout << ""<<word1<<" and "<<word2<<" are the same \n";
	} else if (compareResult < 0) {
		cout << ""<<word1<<" is smaller than "<<word2<<" \n";
	} else {
		cout << ""<<word1<<" is larger";
	}

	// concatenation
	if (strlen(word1) + strlen(word2) < 29) {
		// strcat_s(word1, word2);
		cout << "word1: " << word1 << "\n";
	}

	// copy
}


void charStrings() {
	char c = '1';

	if (isalpha(c)) {
		cout << "variable "<<c<<" is an alphabet \n";
	} else {
		cout << "variable "<<c<<" is not an alphabet \n";
	}
	
	if (isdigit(c)) {

	}
}

int fileIO() {
	const char* file1 = (char*)"data1.txt";
	ofstream fileOutputStream(file1);

	// nullptr is like null in Java
	if (!fileOutputStream) {
		// cerr is console error
		cerr << "Error: File cannot be opened";
		return 1;
	}

	fileOutputStream << "This is a new file !!! \n String 1";
	
	cout << "Enter words you want to add to the the file. (enter \"end\" to exit)";
	// could also use the `while(true){...}`
	do {
		char word[50];
		cin >> word;

		if (strcmp(word, "end") == 0) {
			break;
		}

		fileOutputStream << word << "\n";

	} while (true);

	cout << "\n Insert into file is complete, closing the output stream now \n";

	// close the file to avoid data overwrite!
	// fileOutputStream.close();

	ifstream fileInputStream(file1, ios::app);
	// fileInputStream.open(file1);

	if (!fileInputStream) {
		cerr << "Error: Cannot open the file for "<<file1 << "\n";
		return 1;
	}

	// used for String class in C++
	// cout << "Content of fileInputStream are: \n";
	// cout << fileInputStream.getline(str, 1000);
	
	while (fileInputStream.eof()) {
		char input[100];
		fileInputStream >> input;
		cout << input;
	}

	cout << "\n Reading from the file is complete, closing the inputstream now \n";

	fileInputStream.close();
	// will print the first characters until there is a whitespace
	// cout << "Content of fileInputStream: " << input << "\n";

	return 0;
}

int main() {
	// charStrings();
	// cStringFunctions();
	return fileIO();
	
	char c = 'a';
	char arr[4] = {'1','2','3'};
	// compiler adds '\0' for null-termination at the end of the arr
	// we would need to add a size to the array of at least 4 (for the above example) to have the correct output
	cout << c <<'\n';
	cout << arr <<'\n';
	// this will re-assign the value of the array at index 0
	arr[0] = 'A';

}