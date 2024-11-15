## RegEx Grammar
_**Phone Numbers**_
- Follows the North America Numbering Plan (NANP)
    - in the format NXX NXX-XXXX
    - where `N` represents digits `2` to `9`
    - the first 3-digit group is the area code

    **Phone Number Grammar**
    > S --> phoneNumber \
    > phoneNumber --> areaCode delimiter prefixNumber delimiter lineNumber \
    > areaCode --> leftParenth nonZeroOne digit digit rightParenth \
    > prefixNumber --> nonZeroOne digit digit \
    > lineNumber --> digit digit digit digit \
    > leftParenth --> `(` | $\lambda$ \
    > rightParenth --> `)` | $\lambda$ \
    > nonZeroOne --> 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 \
    > digit -->  0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 \
    > delimiter --> `.` | `-` | `(space)` | $\lambda$

    this phone-number grammar WILL support / detect / match `NANP` phone numbers like:
    - `(514) 999 9999`
    - `(514)9999999`
    - `(514)999 9999`
    - `(514) 9999999`
    - `(514) 999-9999`
    - `(514)-999-9999`
    - `(514).999.9999`
    - `(514).999-9999`
    - `(514)-999.9999`
    - `(514.999.9999`
    - `514).999.9999`
    - `5149999999`
    - `514 999 9999`
    - `514 9999999`
    - `514-9999999`
    - `514.9999999`
    - `514999 9999`
    - `514 999-9999`
    - `514 999.9999`
    - `514.999.9999`
    - `514-999-9999`
    - `514.999-9999`
    - `514-999.9999`

    
    this phone-number grammar does NOT support / detect / match phone numbers with:
    - country codes --> numbers beginning with `+1`, `+2` etc
        - ex: `+1 514-999-9999`
        - it will however match a NANP-appropriate number even though a country-code (with the optional `+`) was entered (effectively, it ignores the country-code)
            - ex: `+44 514-999-9999`
    - multiple space delimiters between the digit-groups
        - ex: `(515)   999   9999`
    - the slash delimiter --> `\` or `/`
        - ex: `514\999\9999` or `514/999/9999` 
    - phone number that do not follow the North American Numbering Plan (NANP)
        - the first digit of the area code AND prefix number must be a digit from `2 to 9`
        - examples: 
            - `014 999 9999` --> this one has a `0` in the first digit of the area code
            - `514 099 9999` --> this one has a `0` in the first digit of the prefix number

---

_**Dates**_
- Follows numerous formats like:
    - `YYYY/MM/DD` or `YYYY/MMM/DD` 
    - `MM/DD/YYYY` or `MMM/DD/YYYY`
    - `DD/MM/YYYY` or `DD/MMM/YYYY`
    - (where `MMM` is the 3-character month)
    - the date can also be in full-word format; like `Monday December 31st, 2020`
    - the year can be from `1900` to `2099`
    - the month can be numeric, from `01` to `12` or by name, `January / Jan` to `Decemeber / Dec`
    - separator / delimiters can be a period, forward-slash or space
    - full or partial weekday --> `Monday / Mon` etc.
    - the day number can have optional suffix (`st, nd, rd, th`)
    - acceptable delimiters (depending on format) are the dot (`.`), comma (`,`), forward-slash (`/`) or the dash / hyphen `-`

    **Dates Grammar** \
    > S -->  dateWithDelimiter | dateInWords \
    > dateWithDelimiter -->  \
    > dateInWords -->  \
    > year -->  nineTwenty digit digit \
    > monthsFull --> January | February | March | April | May | June | July | August | September | October | November | December \
    > monthPart --> Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Sept | Oct | Nov | Dec \
    > monthNum --> zero nonZeroDigit | one zeroOne | one two \
    > weekdayFull --> Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday \
    > weekdayPart --> Mon | Tues | Tue | Wed | Thur | Thurs | Fri | Sat | Sun \
    > dayNum --> zero nonZeroDigit | one digit | two digit | three zeroOne  \  
    > nineteenTwenty --> `19` | `20` \
    > digit --> O | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 \
    > nonZeroDigit --> 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 \
    > zeroOne --> `0` | `1` \
    > zero --> `0` | $\lambda$ \
    > one --> `1` \
    > two --> `2` \
    > three --> `3` \
    > delimiters --> `.` | `-` | `/` \
    > daySuffix --> `st` | `nd` | `rd` | `th` | $\lambda$ \
    > comma --> `,` | $\lambda$ \
    > space --> `(space)` | $\lambda$


    this dates-grammar does not support / detect / match dates like:
    - 


[Date Formats by Country](https://en.wikipedia.org/wiki/List_of_date_formats_by_country)\
[Phone Number Formats by Country](https://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers#United_States,_Canada,_and_other_NANP_countries)