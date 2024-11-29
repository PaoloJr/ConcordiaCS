import os
import nltk
# import re
from nltk import CFG, ChartParser
from nltk.tokenize import word_tokenize, line_tokenize, RegexpTokenizer, regexp_tokenize
from nltk.parse.generate import generate

#  Set the NLTK data path to the virtual environment's nltk_data directory
nltk.data.path.append(os.path.join(os.path.dirname(__file__), 'nltk_data'))

# Get relative path of the script's directory
script_dir = os.path.dirname(os.path.relpath(__file__))
inputFile = "./IO/datePhoneIN_nltk.txt"
outputFile = "./IO/datePhoneOUT_nltk.txt"
input_path = os.path.join(script_dir, inputFile)
output_path = os.path.join(script_dir, outputFile)

phone_grammar = CFG.fromstring("""
S -> phoneNumber
phoneNumber -> areaCode delimiter prefixNumber delimiter lineNumber
areaCode -> leftParenth nonZeroOne digit digit rightParenth
prefixNumber -> nonZeroOne digit digit
lineNumber -> digit digit digit digit
leftParenth -> '(' |
rightParenth -> ')' |
nonZeroOne -> '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
digit -> '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
delimiter -> '.' | '-' | ' ' |
""")

phone_regex = "\\(?"
+ "[2-9][0-9]{2}"
+ "\\)?"
+ "[-.\\s]?"   
+ "[2-9][0-9]{2}"
+ "[-.\\s]?"           
+ "[0-9]{4}"

date_regex = "\\b"
+ "(?:" 
+ "(?:((19|20)\\d{2})[-/.](0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01]))"
+ "|((0?[1-9]|[12][0-9]|3[01])[-/.](0?[1-9]|1[0-2])[-/.]((19|20)\\d{2}))"
+ "|((0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\\d{2}))"
+ "|((19|20)\\d{2})[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.](0?[1-9]|[12][0-9]|3[01])"
+ "|((0?[1-9]|[12][0-9]|3[01])[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]((19|20)\\d{2}))"
+ "|((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]?(0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\\d{2}))"
+ "|(?:"
+ "(?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun),?\\s*)?"
+ "(?:January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec)\\s+"
+ "(\\d{1,2}(?:st|nd|rd|th)?)"
+ ",?\\s*(\\d{4})"
+ ")\\b"

date_grammar = CFG.fromstring("""
    S -->  dateWithDelimiter | dateString 
    dateWithDelimiter -->  year delimiter monthNum delimiter dayNum | year delimiter monthPart delimiter dayNum | monthNum delimiter dayNum delimiter year | monthPart delimiter dayNum delimiter year | dayNum delimiter monthNum delimiter year |  dayNum delimiter monthPart delimiter year |  
    dateString --> weekday comma space monthFull space dayNum daySuffix comma space year | weekday comma space monthPart dayNum daySuffix comma space year 
    year -->  nineteenTwenty digit digit 
    monthFull --> 'January' | 'February' | 'March' | 'April'| 'May' | 'June' | 'July' | 'August' | 'September' | 'October' | 'November' | 'December' 
    monthPart --> 'Jan' | 'Feb' | 'Mar' | 'Apr' | 'May' | 'Jun' | 'Jul' | 'Aug' | 'Sep' | 'Sept' | 'Oct' | 'Nov' | 'Dec' 
    monthNum --> zero nonZeroDigit | one zeroOne | one two 
    weekday --> 'Monday' | 'Mon' | 'Tuesday' | 'Tues' | 'Tue' | 'Wednesday' | 'Wed' | 'Thursday' | 'Thurs' | 'Thur' | 'Friday' | 'Fri' | 'Saturday' | 'Sat' | 'Sunday' | 'Sun' 
    dayNum --> zero nonZeroDigit | one digit | two digit | three zeroOne    
    nineteenTwenty --> 19 | 20 
    digit --> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 
    nonZeroDigit --> 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 
    zeroOne --> 0 | 1 
    zero --> 0 |
    one --> 1 
    two --> 2 
    three --> 3 
    delimiter --> '.' | '-' | '/' 
    daySuffix --> 'st' | 'nd' | 'rd' | 'th' | 
    comma --> ',' |
    space --> " "
""")

phone_grammar.start()
phone_grammar.productions()
# list(generate(phone_grammar))
# print(list)

def process_files(input_path, output_path):
    if not os.path.isfile(input_path):
        print('Input file does not exist! Please create it.')
    else:
        with open(input_path, 'r') as readFile:
            readFileLines = readFile.readlines()
            matches = []
            parser = ChartParser(phone_grammar)
            for line in readFileLines:
                tokens = word_tokenize(line)
                try:
                    for tree in parser.parse(tokens):
                        # check if parse tree matches phone_number rules
                        for subtree in tree.subtrees():
                            if subtree.label() == 'phoneNumber':
                                phone_number = ' '.join(tokens[subtree.leaves()[0]:subtree.leaves()[-1]+1])
                                matches.append(phone_number)
                                #  debugging
                                print(f"Match found: {phone_number}")
                                # assume only want first match for now
                                break
                except ValueError as e:
                        # print(f"Error parsing ling: {line.strip()}")
                        print(e)

        if os.path.exists(os.path.dirname(output_path)):
            print(f"File or directory '{output_path}' already exists.")
            print("Overwriting contents...")
        else:
            os.makedirs(os.path.dirname(output_path))
        
        with open(output_path, 'w') as f:
            for match in matches:
                f.write(match + '\n')

process_files(input_path, output_path)
