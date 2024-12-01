## Report
[Python NLTK Project](../pa3/)

### _Phone Numbers_
[Phone Number Formats - Microsoft](https://learn.microsoft.com/en-us/globalization/locale/telephone-numbers) \
[Phone Number Formats by Country](https://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers#United_States,_Canada,_and_other_NANP_countries)

- Follows the North America Numbering Plan (NANP)
    - in the format NXX NXX-XXXX
    - where `N` represents digits `2` to `9`
    - the first 3-digit group is the area code
    - ignores the country-code with optional `+`
        - ex: `+1 999-999-9999`, `+44 999-999-9999`
            - the 10-digit number are valid NANP-numbers (it will detec/match), but the country codes (`+1` and `+44`) are ignored


```Python
Phone RegEx
    \(?[2-9][0-9]{2}\)?[-.\s]?[2-9][0-9]{2}[-.\s]?[0-9]{4}

Phone Grammar
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
```