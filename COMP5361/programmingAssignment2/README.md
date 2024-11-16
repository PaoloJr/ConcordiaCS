## RegEx Grammar
[Java RegEx implementation](https://github.com/PaoloJr90/ConcordiaCS/tree/main/COMP5361/programmingAssignment2)
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

    **Phone Number Grammar**
    > S --> phoneNumber \
    > phoneNumber --> `areaCode` `delimiter` `prefixNumber` `delimiter` `lineNumber` \
    > areaCode --> `leftParenth` `nonZeroOne` `digit` `digit` `rightParenth` \
    > prefixNumber --> `nonZeroOne` `digit` `digit` \
    > lineNumber --> `digit` `digit` `digit` `digit` \
    > leftParenth --> `(` | $\lambda$ \
    > rightParenth --> `)` | $\lambda$ \
    > nonZeroOne --> 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 \
    > digit -->  0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 \
    > delimiter --> `.` | `-` | `(space)` | $\lambda$

   **this phone-number grammar will support / detect / match `NANP` phone numbers like:**
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

    
    **this phone-number grammar will not support / detect / match phone numbers with:**
    - country codes --> numbers beginning with `+1`, `+2` etc.
        - ex: `+1 514-999-9999`
        - it will however match a NANP-valid number even though a country-code (with the optional `+`) was entered (it ignores the country-code with optional `+`)
            - ex: `+44 514-999-9999`
    - phone number that does not follow the North American Numbering Plan (NANP)
        - the first digit of the area code AND prefix number must be a digit from `2 to 9`
        - examples: 
            - `014 999 9999` --> this one has a `0` in the first digit of the area code
            - `514 099 9999` --> this one has a `0` in the first digit of the prefix number
    - multiple space delimiters between the digit-groups
        - ex: `(515)   999   9999`
    - the slash delimiter --> `\` or `/`
        - ex: `514\999\9999` or `514/999/9999` 
    - `1-800-332-5432` --> it will detect the last 10-digits (if they are NANP-valid), ignoring the `1-`

---

### _Dates_
[Date Formats by Country](https://en.wikipedia.org/wiki/List_of_date_formats_by_country)

- Follows numerous formats like:
    - `YYYY/MM/DD` or `YYYY/MMM/DD` 
    - `MM/DD/YYYY` or `MMM/DD/YYYY`
    - `DD/MM/YYYY` or `DD/MMM/YYYY`
        - where `MMM` is the 3-character month
    - the date can also be in full-word format; like `Monday December 31st, 2020`
    - the year can be from `1900` to `2099`
    - the month can be numeric, from `01` to `12` or by name, `January / Jan` to `Decemeber / Dec`
    - full or partial weekday --> `Monday / Mon` etc.
    - the day number can have optional suffix (`st, nd, rd, th`)
    - acceptable delimiters (depending on format) are the dot (`.`), comma (`,`), forward-slash (`/`) or the dash / hyphen `-`
    - the `space` character is mandatory for the string date format

    **Dates Grammar** \
    > S -->  `dateWithDelimiter` | `dateString` \
    > dateWithDelimiter -->  `year delimiter monthNum delimiter dayNum` | `year delimiter monthPart delimiter dayNum` | `monthNum delimiter dayNum delimiter year` | `monthPart delimiter dayNum delimiter year` | `dayNum delimiter monthNum delimiter year` |  `dayNum delimiter monthPart delimiter year` |  \
    > dateString --> `weekday comma space monthFull space dayNum daySuffix comma space year` | `weekday comma space monthPart dayNum daySuffix comma space year` \
    > year -->  `nineteenTwenty digit digit` \
    > monthFull --> January | February | March | April | May | June | July | August | September | October | November | December \
    > monthPart --> Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Sept | Oct | Nov | Dec \
    > monthNum --> `zero nonZeroDigit` | `one zeroOne` | `one two` \
    > weekday --> Monday | Mon | Tuesday | Tues | Tue | Wednesday | Wed | Thursday | Thurs | Thur | Friday | Fri | Saturday | Sat | Sunday | Sun \
    > dayNum --> `zero nonZeroDigit` | `one digit` | `two digit` | `three zeroOne`  \  
    > nineteenTwenty --> `19` | `20` \
    > digit --> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 \
    > nonZeroDigit --> 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 \
    > zeroOne --> `0` | `1` \
    > zero --> `0` | $\lambda$ \
    > one --> `1` \
    > two --> `2` \
    > three --> `3` \
    > delimiter --> `.` | `-` | `/` \
    > daySuffix --> `st` | `nd` | `rd` | `th` | $\lambda$ \
    > comma --> `,` | $\lambda$ \
    > space --> `(space)`

    **this dates-grammar will support / detect / match dates like:**
    - `1945/12/1`
    - `1945/3/1` --> when month (`3`) or day (`1`) is a single digit
    - `1945/12.1`
    - `1945/12-1`
    - `1945-12.1`
    - `1945.12-1`
    - `1945.12.1`
    - `1945-12-1`
    - `1945/12/01`
    - `1945/Dec/01`
    - `1945-Dec-01`
    - `1/12/1900`
    - `01/12/2001`
    - `01/Dec/2001`
    - `01-Dec-2001`
    - `12/31/2001`
    - `Dec/1/2099`
    - `Dec/01/2099`
    - `Dec-01-2001`
    - `01.Dec.01.2001`
    - `Monday, April 9, 2020`
    - `Monday, Apr 9th 2020`
    - `Monday,   April 9,   2020`
    - `Monday April 4th 2020`
    - `Thursday April 3rd 2020`
    - `Tues April 2nd 2020`
    - `Monday April 1st 2020`
    - `Monday April 9 2020`
    - `Mon April 9 1900`
    - `Mon April 9 2099`
    - `Monday, 01/12/2020` --> it will only match with the date with slashes (`dateWithDelimiter`), ignoring the day string (ex: `Monday`)


    **this dates-grammar will not support / detect / match dates like:**
    - `2020 Dec 31` --> no valid delimiter (dot, hyphen/dash or forward-slash) used
    - `2020,Dec,31` --> no valid delimiter (dot, hyphen/dash or forward-slash) used
    - `2020Dec31` --> no valid delimiter (dot, dash or forward-slash) used
    - `1945\31\01` --> the backslash delimiter
    - `1899/31/01` --> year out of range (`1900 - 2099`)
    - `2020/32/01` --> day out of range (`01 - 31`)
    - `2020/31/13` --> month number out of range (`01 - 12`)
    - `2020/31/dec` --> month name must start with capital letter
    - `Monday, december 31st, 2020` --> month name must start with capital letter
    - `monday, December 31st, 2020` --> weekday name must start with capital letter
    - `12.9 2022` --> for this format, delimiters must be the dot (`.`), forward-slash (`/`) and/or dash / hyphen `-`, or some mixture of them (cannot use the space character for this `dateWithDelimiter` format)
    - `Tuesday, 17 July 2018` --> day number before the month
    - `Friday/02/2020` --> full weekday name
    - `Fri/02/2020` --> partial weekday name
    - `31/December/2020` --> full month name in the `dateWithDelimiter` format
    - `24/Dec/31` --> two-digit year (`24`)
    - `12/2020/31` --> year in the middle of the `dateWithDelimiter` format