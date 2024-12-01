import os
import nltk
import re
from nltk import CFG, ChartParser

#  Set the NLTK data path to the virtual environment's nltk_data directory
nltk.data.path.append(os.path.join(os.path.dirname(__file__), 'nltk_data'))

# Get relative path of the script's directory
script_dir = os.path.dirname(os.path.relpath(__file__))
input_file = "./IO/datePhoneIN_nltk.txt"
output_file = "./IO/datePhoneOUT_nltk.txt"
input_path = os.path.join(script_dir, input_file)
output_path = os.path.join(script_dir, output_file)                       

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

time_grammar = CFG.fromstring("""
    S -> 
""")

phone_regex = re.compile(r"\(?[2-9][0-9]{2}\)?[-.\s]?[2-9][0-9]{2}[-.\s]?[0-9]{4}")  

date_regex = re.compile(r'''
    \b
    (
        (?:
            (?: (?:19|20)\d{2} ) [-/.] (?:0?[1-9]|1[0-2]) [-/.] (?:0?[1-9]|[12][0-9]|3[01])
            |(?:0?[1-9]|[12][0-9]|3[01]) [-/.] (?:0?[1-9]|1[0-2]) [-/.] (?:19|20)\d{2}
            |(?:0?[1-9]|1[0-2]) [-/.] (?:0?[1-9]|[12][0-9]|3[01]) [-/.] (?:19|20)\d{2}
            |(?:19|20)\d{2} [-/.]? (?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) [-/.] (?:0?[1-9]|[12][0-9]|3[01])
            |(?:0?[1-9]|[12][0-9]|3[01]) [-/.]? (?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) [-/.] (?:19|20)\d{2}
            |(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) [-/.]? (?:0?[1-9]|[12][0-9]|3[01]) [-/.] (?:19|20)\d{2}
            |(?:
                (?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun),?\s*)?
            (?:January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec)\s+
            \d{1,2}(?:st|nd|rd|th)?,?\s*\d{4}
        )
    )
    \b
    ''', re.VERBOSE | re.IGNORECASE)

time_regex = re.compile(r"")

# phone_tokenizer = nltk.RegexpTokenizer(phone_regex)
# date_tokenizer = nltk.RegexpTokenizer(date_regex) 
# time_tokenizer = nltk.RegexpTokenizer(time_regex)

phone_number_parser = nltk.ChartParser(phone_grammar)
date_parser = nltk.ChartParser(date_grammar)
# time_parser = nltk.ChartParser(time_grammer)

parse_phone = nltk.RecursiveDescentParser(phone_grammar)
parse_date = nltk.RecursiveDescentParser(date_grammar)
# parse_time = nltk.RecursiveDescentParser(time_grammar)

def detect_date(sentence):
    date = re.findall(date_regex, sentence)
    # print(date)
    return date

def detect_phone_number(sentence):
    phone_number = re.findall(phone_regex, sentence)
    # print(phone_number)
    return phone_number

def detect_time(sentence):
    time = re.findall(time_regex, sentence)
    # print(time)
    return time

def process_files(input_path, output_path):
    if not os.path.isfile(input_path):
        print('Input file does not exist! Please create it.')
    else:
        with open(input_path, 'r') as read_file, open(output_path, 'w') as write_file:
            read_file_lines = read_file.readlines()
            for sentence in read_file_lines:
                try:
                    # detect phone number and date
                    phone_number_found = detect_phone_number(sentence)
                    date_found = detect_date(sentence)
                    time_found = detect_time(sentence)
                    # phone_tokens = phone_tokenizer.tokenize(sentence)
                    # date_tokens = date_tokenizer.tokenize(sentence)

                    if "*****" in sentence:
                        write_file.write("\n")
                        write_file.write("\n")
                        write_file.write("-----*****NON-ACCEPTABLE-FORMATS-BELOW*****-----\n")
                        continue

                    write_file.write(f"Sentence: {sentence.strip()}\n")
                    if phone_number_found:
                    # if phone_tokens:
                        # for phone_number in phone_numbers:
                        for phone_number in phone_number_found:
                        # for phone_number in phone_tokens:
                            write_file.write(f"Detected Phone Number: {phone_number}\n")
                    else:
                            write_file.write("NO PHONE DETECTED\n")
                    if date_found:
                    # if date_tokens:
                        for date in date_found:
                        # for date in date_tokens:
                            write_file.write(f"Detected Date: {date}\n")
                    else:
                            write_file.write("NO DATE DETECTED\n")
                    if time_found:
                        for time in time_found:
                             write_file.write(f"Detected Time: {time}\n")
                    else:
                            write_file.write(f"NO TIME DETECTED\n")
                    write_file.write("\n")
                except ValueError as e:
                        print(f"Error parsing ling: {sentence.strip()}")
                        print(e)
                        # write_file(f"Error parsing line: {sentence.strip()}\n")
                        # write_file.write(f"{e}\n")

process_files(input_path, output_path)
