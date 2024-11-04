from nltk import CFG
from nltk.tokenize import word_tokenize
from nltk.parse.generate import generate

grammar = CFG.fromstring("""
    Month -> 'January'| 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December'
""")
toPrint = list(generate(grammar))
print(toPrint)


# Sample text
text = "Hello, world! This is a simple NLTK example."

# Tokenize the text
tokens = word_tokenize(text)

print(tokens)