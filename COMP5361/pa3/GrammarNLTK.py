import os
import nltk
import re
from nltk import CFG

#  Set the NLTK data path to the virtual environment's nltk_data directory
nltk.data.path.append(os.path.join(os.path.dirname(__file__), 'nltk_data'))

# Get relative path of the script's directory
script_dir = os.path.dirname(os.path.relpath(__file__))
input_file = "./IO/datePhoneTimeIN.txt"
output_file = "./IO/datePhoneTimeOUT.txt"
input_path = os.path.join(script_dir, input_file)
output_path = os.path.join(script_dir, output_file)  


###########################
# REGEX SECTION
###########################


phone_regex = re.compile(r"\(?[2-9][0-9]{2}\)?[-.\s]?[2-9][0-9]{2}[-.\s]?[0-9]{4}") 
# phone_regex_nltk = r"\(?[2-9][0-9]{2}\)?[-.\s]?[2-9][0-9]{2}[-.\s]?[0-9]{4}"

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

# date_regex_nltk = r"""
#     \b
#     (
#         (?:
#             (?: (?:19|20)\d{2} ) [-/.] (?:0?[1-9]|1[0-2]) [-/.] (?:0?[1-9]|[12][0-9]|3[01])
#             |(?:0?[1-9]|[12][0-9]|3[01]) [-/.] (?:0?[1-9]|1[0-2]) [-/.] (?:19|20)\d{2}
#             |(?:0?[1-9]|1[0-2]) [-/.] (?:0?[1-9]|[12][0-9]|3[01]) [-/.] (?:19|20)\d{2}
#             |(?:19|20)\d{2} [-/.]? (?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) [-/.] (?:0?[1-9]|[12][0-9]|3[01])
#             |(?:0?[1-9]|[12][0-9]|3[01]) [-/.]? (?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) [-/.] (?:19|20)\d{2}
#             |(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) [-/.]? (?:0?[1-9]|[12][0-9]|3[01]) [-/.] (?:19|20)\d{2}
#             |(?:
#                 (?:Monday|Mon|Tuesday|Tue|Tues|Wednesday|Wed|Thursday|Thur|Thurs|Friday|Fri|Saturday|Sat|Sunday|Sun),?\s*)?
#             (?:January|Jan|February|Feb|March|Mar|April|Apr|May|June|Jun|July|Jul|August|Aug|September|Sept|Sep|October|Oct|November|Nov|December|Dec)\s+
#             \d{1,2}(?:st|nd|rd|th)?,?\s*\d{4}
#             )
#     )
#     \b
# """

time_regex = re.compile(r"\b(?:(?:[01]?\d|2[0-3]):[0-5]\d(?::[0-5]\d)?(?:\s?[APap][Mm])?)\b")
# time_regex_nltk = r"\b(?:(?:[01]?\d|2[0-3]):[0-5]\d(?::[0-5]\d)?(?:\s?[APap][Mm])?)\b"

###########################
# GRAMMAR SECTION
###########################

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
    monthFull -> 'J' 'a' 'n' 'u' 'a' 'r' 'y' | 'F' 'e' 'b' 'r' 'u' 'a' 'r' 'y' | 'M' 'a' 'r' 'c' 'h' | 'A' 'p' 'r' 'i' 'l'| 'M' 'a' 'y' | 'J' 'u' 'n' 'e' | 'J' 'u' 'l' 'y' | 'A' 'u' 'g' 'u' 's' 't' | 'S' 'e' 'p' 't' 'e' 'm' 'b' 'e' 'r' | 'O' 'c' 't' 'o' 'b' 'e' 'r' | 'N' 'o' 'v' 'e' 'm' 'b' 'e' 'r' | 'D' 'e' 'c' 'e' 'm' 'b' 'e' 'r' 
    monthPart -> 'J' 'a' 'n' | 'F' 'e' 'b' | 'M' 'a' 'r' | 'A' 'p' 'r' | 'M' 'a' 'y' | 'J' 'u' 'n' | 'J' 'u' 'l' | 'A' 'u' 'g' | 'S' 'e' 'p' | 'S' 'e' 'p' 't' | 'O' 'c' 't' | 'N' 'o' 'v' | 'D' 'e' 'c' 
    monthNum -> zero nonZeroDigit | one zeroOne | one two 
    weekday -> 'M' 'o' 'n' 'd' 'a' 'y' | 'M' 'o' 'n' | 'T' 'u' 'e' 's' 'd' 'a' 'y' | 'T' 'u' 'e' 's' | 'T' 'u' 'e' | 'W' 'e' 'd' 'n' 'e' 's' 'd' 'a' 'y' | 'W' 'e' 'd' | 'T' 'h' 'u' 'r' 's' 'd' 'a' 'y' | 'T' 'h' 'u' 'r' 's' | 'T' 'h' 'u' 'r' | 'F' 'r' 'i' 'd' 'a' 'y' | 'F' 'r' 'i' | 'S' 'a' 't' 'u' 'r' 'd' 'a' 'y' | 'S' 'a' 't' | 'S' 'u' 'n' 'd' 'a' 'y' | 'S' 'u' 'n' 
    dayNum -> zero nonZeroDigit | one digit | two digit | three zeroOne    
    nineteenTwenty -> '1' '9' | '2' '0' 
    digit -> '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' 
    nonZeroDigit -> '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' 
    zeroOne -> '0' | '1' 
    zero -> '0' |
    one -> '1' 
    two -> '2' 
    three -> '3' 
    delimiter -> '.' | '-' | '/' 
    daySuffix -> 's' 't' | 'n' 'd' | 'r' 'd' | 't' 'h' | 
    comma -> ',' |
    space -> " "
""")

time_grammar = CFG.fromstring("""
    S -> Time | TimeSeconds
    Time -> Hours Colon Minutes Space AMPM
    TimeSeconds -> Hours Colon Minutes Colon Seconds Space AMPM
    Hours -> HourFirst SecondDigit
    Minutes -> MinSecFirst SecondDigit
    Seconds -> MinSecFirst SecondDigit
    HourFirst -> '0' | '1' | '2'
    MinSecFirst -> '0' | '1' | '2' | '3' | '4' | '5' 
    SecondDigit -> '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
    AMPM -> 'A' 'M' | 'P' 'M' | 'a' 'm' | 'p' 'm' | 'a' 'M' | 'A' 'm' | 'p' 'M' | 'P' 'm' |
    Space -> ' ' |
    Colon -> ':'
""")


def detect_phone_number(sentence):
    phone_number = re.findall(phone_regex, sentence)
    # print(phone_number)
    return phone_number

def detect_date(sentence):
    date = re.findall(date_regex, sentence)
    # print(date)
    return date

def detect_time(sentence):
    time = re.findall(time_regex, sentence)
    # print(time)
    return time


phone_chart_parser = nltk.ChartParser(phone_grammar)
date_chart_parser = nltk.ChartParser(date_grammar)
time_chart_parser = nltk.ChartParser(time_grammar)

# phone_descent_parser = nltk.RecursiveDescentParser(phone_grammar)
# date_descent_parser = nltk.RecursiveDescentParser(date_grammar)
# time_descent_parser = nltk.RecursiveDescentParser(time_grammar)

chart_parser_text = "Using ChartParser:\n"
detected_phone_text = "Detected Phone Number: "
detected_date_text = "Detected Date: "
detected_time_text = "Detected Time: "
phone_not_detected_text = "PHONE NUMBER NOT DETECTED\n"
date_not_deteceted_text = "DATE NOT DETECTED\n"
time_not_detected_text = "TIME NOT DETECTED\n"
phone_tree_text = "PHONE TREE\n"
date_tree_text = "DATE TREE\n"
time_tree_text = "TIME TREE\n"

sentences = []
phone_numbers = []
dates = []
times = []

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

                    if "*****" in sentence:
                        write_file.write("\n")
                        write_file.write("\n")
                        write_file.write("-----*****NON-ACCEPTABLE-FORMATS-BELOW*****-----\n")
                        continue

                    write_file.write(f"Sentence: {sentence.strip()}\n")
                    if phone_number_found:
                        for phone_number in phone_number_found:
                            write_file.write(f"{detected_phone_text} {phone_number}\n")
                            phone_numbers.append(phone_number)
                    else:
                            write_file.write(phone_not_detected_text)
                    if date_found:
                        for date in date_found:
                            write_file.write(f"{detected_date_text} {date}\n")
                            dates.append(date)
                    else:
                            write_file.write(date_not_deteceted_text)
                    if time_found:
                        for time in time_found:
                             write_file.write(f"{detected_time_text}{time}\n")
                             times.append(time)
                    else:
                            write_file.write(time_not_detected_text)
                    write_file.write("\n")
                except ValueError as e:
                        print(f"Error parsing ling: {sentence.strip()}")
                        print(e)
                        # write_file(f"Error parsing line: {sentence.strip()}\n")
                        # write_file.write(f"{e}\n")

process_files(input_path, output_path)


# Print the input data before parsing
# print("Detected Dates:")
# for date in dates:
#     print(date)

# print("Detected Times:")
# for time in times:
#     print(time)


#####################################################################
# WRITE PARSE TREES TO FILE USING REGEX EXTRACTED FROM INPUT FILE
#####################################################################

with open('./IO/parseTrees.txt', 'w') as trees_output_file:
    # print("##########################################")
    # print("Parsing Phone Numbers")
    trees_output_file.write("##########################################\n")
    trees_output_file.write("Parsing Phone Numbers\n")
    for phone_number in phone_numbers:
        # print(f"{detected_phone_text} {phone_number}")
        # print(chart_parser_text)
        trees_output_file.write(f"{detected_phone_text} {phone_number}\n")
        trees_output_file.write(chart_parser_text)
        try:
            for tree in phone_chart_parser.parse(phone_number):
                # print(phone_tree_text)
                # print(tree)
                trees_output_file.write(phone_tree_text)
                trees_output_file.write(str(tree) + "\n")
        except ValueError as e:
                trees_output_file.write(f"Error parsing phone {phone_number} : {e}\n")
    
    # print("##########################################")
    # print("Parsing Dates")
    trees_output_file.write("##########################################\n")
    trees_output_file.write("Parsing Dates\n")
    for date in dates:
        # print(f"{detected_date_text} {date}")
        # print(chart_parser_text)
        trees_output_file.write(f"{detected_date_text} {date}\n")
        trees_output_file.write(chart_parser_text)
        try:
            for tree in date_chart_parser.parse(date):
                # print(date_tree_text)
                # print(tree)
                trees_output_file.write(date_tree_text)
                trees_output_file.write(str(tree) + "\n")
        except ValueError as e:
                trees_output_file.write(f"Error parsing date {date} : {e}\n")

    # print("##########################################")
    # print("Parsing Times")
    trees_output_file.write("##########################################\n")
    trees_output_file.write("Parsing Times\n")
    for time in times:
        # print(f"{detected_time_text} {time}")
        # print(chart_parser_text)
        trees_output_file.write(f"{detected_time_text} {time}\n")
        trees_output_file.write(chart_parser_text)
        try:
            for tree in time_chart_parser.parse(time):
                # print(time_tree_text)
                # print(tree)
                trees_output_file.write(time_tree_text)
                trees_output_file.write(str(tree) + "\n")
        except ValueError as e:
                trees_output_file.write(f"Error parsing date {time} : {e}\n")


###########################################
# PRINT PARSE TREES USING TEST SENTENCES
###########################################


input_parse_sentences = [
    "My phone number is (123) 456-7890 and my birthday is 12-31-2024 and I was born on Monday, January 31st, 2024 at 12:30:45 PM",
    "Sarah called me on April 25, 2025 at 12:30:45 pm at (555) 123   -    4567.",
    "The conference is scheduled for 15-03-2024 at 14:00 Am; please RSVP at 312-555.8900",
    "I visited the museum on Sunday, August 07, 2008 at 10: 00 AM and called the guide at 555-8901234",
    "Please contact our support team at (206)   555-7890 before 31/1/2024 at 16:30:0",
    "The wedding is set for Saturday, June 22nd, 2026 at 5 : 00 pM - the planner's number is 415.555.3456",
    "I started my new job on 12.9 2022 at 09:00am and got my work phone: (702) 555-9012",
    "The concert will be held on Thursday, April 18 2024 at 19:30; for tickets call 888-555-6543",
    "She graduated on 28 -05 2019 at 11:00pm and changed her number to 617-555-4321",
    "The package was delivered on 03.11.2023 at 08:45:00; tracking support: (800) 555-7654",
    "Mark your calendar for Friday, July 26, 2029 at 18:00 and call the venue at 213.555.8765",
    "The interview is scheduled for 05-02-2024 at 23 PM; recruiter: (408) 555-2345",
    "We moved to our new house on Monday    October 15, 2023 at 14:00pm and got a landline: 925-555-6789",
    "The grand opening is on 21/08/2027 at 09am; information desk: (619) 555-1098",
    "I adopted my cat on April 11, 2023 at 10:15:00 pm; vet's number is 707.555.3210",
    "The festival begins on 04.05.2028 at 13:0:0; ticket office: (503) 555-4567",
    "She retired on Wednesday, 31st December, 2020 at 17:00 am and left her contact: 650-555-8901",
    "The charity event is on 08-09-2024 at 15:00 pm; organizer's number: (415) 555-2468",
    "I took my driving test on Tuesday, 17 July  2018 at 09:00am; instructor's phone: 510 555-1357",
    "The art exhibition opens on 12/01/2024 at 11:0; gallery number: (212) 555-9876",
    "We celebrated our anniversary on Monday, 2023 June 30 at 20:00AM and booked the restaurant at 831-555-6420",
    "Call me on Monday, April 9, 2020 at 9:00 AM at 999-999-9999",
    "My appointment is scheduled for 2020/02/02 at 14:30, and my phone number is (999) 999-9999"
]

# phone_tokenizer = nltk.RegexpTokenizer(phone_regex_nltk)
# date_tokenizer = nltk.RegexpTokenizer(date_regex_nltk) 
# time_tokenizer = nltk.RegexpTokenizer(time_regex_nltk)

with open('./IO/parseTrees_samples.txt', 'w') as trees_output_samples_file:
    for sentence in input_parse_sentences:
        # phone_tokens = phone_tokenizer.tokenize(sentence)
        # print("phone_tokens: " + " ".join(phone_tokens))
        # date_tokens = date_tokenizer.tokenize(sentence)
        # print("date_tokens: " + " ".join(date_tokens))
        # time_tokens = time_tokenizer.tokenize(sentence)
        # print("time_tokens: " + " ".join(time_tokens))

        # print("##########################################")
        # print(f"Sentence: {sentence}")
        trees_output_samples_file.write("##########################################\n")
        trees_output_samples_file.write(f"Sentence: {sentence}\n")

        trees_output_samples_file.write("Parsing Phone Numbers\n")
        phone_matches = re.findall(phone_regex, sentence)
        # print("phone_matches" + "".join(phone_matches))
        if phone_matches:
            for phone in phone_matches:
                result_phone = ''.join(phone)
                # print(f"{detect_phone_number} {phone_token}")
                trees_output_samples_file.write(f"{detected_phone_text} {result_phone}\n")
        else:
                # print(phone_not_detected_text)  
                trees_output_samples_file.write(phone_not_detected_text)  
        
        trees_output_samples_file.write("Parsing Dates\n")
        date_matches = re.findall(date_regex, sentence)
        # print("date_matches" + "".join(date_matches))
        if date_matches:
            for date in date_matches:
                result_date = ''.join(date)
                # print(f"{detected_date_text} {result_date}")
                trees_output_samples_file.write(f"{detected_date_text} {result_date}\n")
        else: 
                # print(date_not_deteceted_text)
                trees_output_samples_file.write(date_not_deteceted_text)

        trees_output_samples_file.write("Parsing Times\n")
        time_matches = re.findall(time_regex, sentence)
        # print("time matches" + "".join(time_matches))
        if time_matches:  
            for time in time_matches:
                result_time = ''.join(time)
                # print(f"{detected_time_text} {time_token}")
                trees_output_samples_file.write(f"{detected_time_text} {result_time}\n")
        else:
                # print(time_not_detected_text)
                trees_output_samples_file.write(time_not_detected_text)
        # print("##########################################")
        trees_output_samples_file.write("##########################################\n")

        if phone_matches:
            for phone in phone_matches:
                for tree in phone_chart_parser.parse(phone):
                    # print(phone_tree_text)
                    # print(tree)
                    trees_output_samples_file.write(chart_parser_text)
                    trees_output_samples_file.write(phone_tree_text)
                    trees_output_samples_file.write(str(tree) + "\n")
        else:
            trees_output_samples_file.write("NO PHONE TREE\n")
        if date_matches:
            for date in date_matches:
                result = ''.join(date)
                for tree in date_chart_parser.parse(result):
                    # print(date_tree_text)
                    # print(tree)
                    trees_output_samples_file.write(chart_parser_text)
                    trees_output_samples_file.write(date_tree_text)
                    trees_output_samples_file.write(str(tree) + "\n")
        else: 
             trees_output_samples_file.write("NO DATE TREE\n")
        if time_matches:
            for time in time_matches:
                time = time.replace('-', '').replace('.', '')
                for tree in time_chart_parser.parse(time):
                    # print(time_tree_text)
                    # print(tree)
                    trees_output_samples_file.write(chart_parser_text)
                    trees_output_samples_file.write(time_tree_text)
                    trees_output_samples_file.write(str(tree) + "\n")
        else:
            trees_output_samples_file.write("NO TIME TREE\n")