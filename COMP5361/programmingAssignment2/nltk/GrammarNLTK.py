import nltk
from nltk import CFG
from nltk.tokenize import word_tokenize
from nltk.parse.generate import generate

grammar = CFG.fromstring("""
    Month -> 'January'|'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December'
""")
list = list(generate(grammar))
print(list)



# Sample text
text = "Hello, world! This is a simple NLTK example. Written in November!"
# Tokenize the text
tokens = word_tokenize(text)
print(tokens)