import os
import nltk
import re
from nltk import CFG, ChartParser
from nltk.tokenize import word_tokenize, line_tokenize, RegexpTokenizer, regexp_tokenize
from nltk.parse.generate import generate

#  Set the NLTK data path to the virtual environment's nltk_data directory
nltk.data.path.append(os.path.join(os.path.dirname(__file__), 'nltk_data'))

# Get relative path of the script's directory
script_dir = os.path.dirname(os.path.relpath(__file__))
input_file = "./IO/datePhoneIN_nltk.txt"
output_file = "./IO/datePhoneOUT_nltk.txt"
input_path = os.path.join(script_dir, input_file)
output_path = os.path.join(script_dir, output_file)

phone_regex = re.compile(r"\(?[2-9][0-9]{2}\)?[-.\s]?[2-9][0-9]{2}[-.\s]?[0-9]{4}")  
# phone_regex = RegexpTokenizer(r'\(?[2-9][0-9]{2}\)?[-.\s]?[2-9][0-9]{2}[-.\s]?[0-9]{4}')                        

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

# date_regex = "\\b"
# + "(?:" 
# + "(?:((19|20)\\d{2})[-/.](0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01]))"
# + "|((0?[1-9]|[12][0-9]|3[01])[-/.](0?[1-9]|1[0-2])[-/.]((19|20)\\d{2}))"
# + "|((0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\\d{2}))"
# + "|((19|20)\\d{2})[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.](0?[1-9]|[12][0-9]|3[01])"
# + "|((0?[1-9]|[12][0-9]|3[01])[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]((19|20)\\d{2}))"
# + "|((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]?(0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\\d{2}))"
# + "|(?:"
# + "(?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun),?\\s*)?"
# + "(?:January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec)\\s+"
# + "(\\d{1,2}(?:st|nd|rd|th)?)"
# + ",?\\s*(\\d{4})"
# + ")\\b"

date_regex = re.compile(r'''
    (\b
        (?: 
            (?:
                ((19|20)\d{2})[-/.](0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01]))
                |((0?[1-9]|[12][0-9]|3[01])[-/.](0?[1-9]|1[0-2])[-/.]((19|20)\d{2}))
                |((0?[1-9]|1[0-2])[-/.](0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\d{2}))
                |((19|20)\d{2})[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.](0?[1-9]|[12][0-9]|3[01])
                |((0?[1-9]|[12][0-9]|3[01])[-/.]?(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]((19|20)\d{2}))
                |((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[-/.]?(0?[1-9]|[12][0-9]|3[01])[-/.]((19|20)\d{2}))
            |(?:
                (?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun),?\s*)?
                (?:January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec)\s+
                (\d{1,2}(?:st|nd|rd|th)?),?\s*(\d{4})
        )
    \b)
    ''', re.VERBOSE|re.IGNORECASE
)

date_grammar = CFG.fromstring("""
    S ->  dateWithDelimiter | dateString 
    dateWithDelimiter ->  year delimiter monthNum delimiter dayNum | year delimiter monthPart delimiter dayNum | monthNum delimiter dayNum delimiter year | monthPart delimiter dayNum delimiter year | dayNum delimiter monthNum delimiter year |  dayNum delimiter monthPart delimiter year |  
    dateString -> weekday comma space monthFull space dayNum daySuffix comma space year | weekday comma space monthPart dayNum daySuffix comma space year 
    year ->  nineteenTwenty digit digit 
    monthFull -> 'January' | 'February' | 'March' | 'April'| 'May' | 'June' | 'July' | 'August' | 'September' | 'October' | 'November' | 'December' 
    monthPart -> 'Jan' | 'Feb' | 'Mar' | 'Apr' | 'May' | 'Jun' | 'Jul' | 'Aug' | 'Sep' | 'Sept' | 'Oct' | 'Nov' | 'Dec' 
    monthNum -> zero nonZeroDigit | one zeroOne | one two 
    weekday -> 'Monday' | 'Mon' | 'Tuesday' | 'Tues' | 'Tue' | 'Wednesday' | 'Wed' | 'Thursday' | 'Thurs' | 'Thur' | 'Friday' | 'Fri' | 'Saturday' | 'Sat' | 'Sunday' | 'Sun' 
    dayNum -> zero nonZeroDigit | one digit | two digit | three zeroOne    
    nineteenTwenty -> 19 | 20 
    digit -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 
    nonZeroDigit -> 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 
    zeroOne -> 0 | 1 
    zero -> 0 |
    one -> 1 
    two -> 2 
    three -> 3 
    delimiter -> '.' | '-' | '/' 
    daySuffix -> 'st' | 'nd' | 'rd' | 'th' | 
    comma -> ',' |
    space -> " "
""")

# phone_grammar.start()
# phone_grammar.productions()
# list(generate(phone_grammar))
# print(list)

def detect_phone_number(sentence):
    phone_number = re.findall(phone_regex, sentence)
    # phone_number = regexp_tokenize(sentence, phone_regex)
    # return phone_regex.tokenize(sentence)
    return phone_number

def detect_date(sentence):
    date = re.findall(date_regex, sentence)
    # print(date)
    return [''.join(filter(None, match)) for match in date]
    # print(date_regex.tokenize(sentence))
    # return date_regex.tokenize(sentence)

def process_files(input_path, output_path):
    if not os.path.isfile(input_path):
        print('Input file does not exist! Please create it.')
    else:
        with open(input_path, 'r') as read_file, open(output_path, 'w') as write_file:
            read_file_lines = read_file.readlines()
            for line in read_file_lines:
                try:
                    for sentence in read_file_lines:
                        # detect phone number and date
                        phone_numbers = detect_phone_number(sentence)
                        dates = detect_date(sentence)
                        
                        # print(f"Sentence: \"{sentence}\"")
                        write_file.write(f"Sentence: :\" {sentence}")
                        for phone_number in phone_numbers:
                            # print(f"Detected Phone Number: {phone_number}")
                            write_file.write(f"Detected Phone Number: {phone_number}\n")
                        for date in dates:
                            # print(f"Detected Date: {date}")
                            write_file.write(f"Detected Date: {date}\n")
                        # print()
                        write_file.write("\n")
                except ValueError as e:
                        # print(f"Error parsing ling: {line.strip()}")
                        # print(e)
                        write_file(f"Error parsing line: {line.strip()}\n")
                        write_file.write(f"{e}\n")

process_files(input_path, output_path)
