import os
import nltk
from nltk import CFG
from nltk.tokenize import word_tokenize
from nltk.parse.generate import generate

# Get absolute path of the script's directory
script_dir = os.path.dirname(os.path.relpath(__file__))

inputFile = "./IO/datePhoneIN_nltk.txt"
outputFile = "./IO/datePhoneOUT_nltk.txt"

input_path = os.path.join(script_dir, inputFile)
output_path = os.path.join(script_dir, outputFile)

def process_files(input_path, output_path):
    if not os.path.isfile(input_path):
        print('Input file does not exist! Please create it.')
    else:
        with open(input_path, 'r') as readFile:
            readFileLines = readFile.readlines()
            # regex-like function goes here
        if os.path.exists(os.path.dirname(output_path)):
            print(f"File or directory '{output_path}' already exists.")
            print("Overwriting contents...")
            with open(output_path, 'w') as f: 
                f.writelines(readFileLines)
        else:
            print(f"Output directory does not exist: {os.path.dirname(output_path)}")

process_files(input_path, output_path)


grammar = CFG.fromstring("""
    Month -> 'January'|'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December'
""")
list = list(generate(grammar))
print(list)



# Sample text
# text = "Hello, world! This is a simple NLTK example. Written in November!"
# Tokenize the text
# tokens = word_tokenize(text)
# print(tokens)