import nltk
from nltk import CFG
from nltk.tokenize import word_tokenize
from nltk.parse.generate import generate

grammar = CFG.fromstring("""
    Month -> 'January'|'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December'
""")
list = list(generate(grammar))
# print(list)



# Sample text
text = "Hello, world! This is a simple NLTK example. Written in November!"
# Tokenize the text
tokens = word_tokenize(text)
# print(tokens)

inputFile = "../IO/datePhoneIN_nltk.txt"
outputFile = "../IO/datePhoneOUT_nltk.txt"

readFile = open("../IO/datePhoneIN_nltk.txt")
readFileLines = readFile.readlines()

try:
    with open(outputFile, 'x') as f:
        f.write(readFileLines)
except FileExistsError:
    print(f"File '{outputFile}' already exists.")
    print("Overwriting contents...")
    with open(outputFile, 'w') as f:  # Open in 'w' mode to overwrite
        f.writelines(readFileLines)