## RegEx Grammar
_**Phone Numbers**_
- Follows the North America Numbering Plan (NANP)
    - in the format +1 (NXX, 3-digit area code) NXX-XXXX, where `N` represents digits `2` to `9`
    - the RegEx pattern sequence:   
        - "(^\\+1[-.\\s]?)?"
            - S --> +1( - + . + " ")   
        - "\\(?[2-9][0-9]{2}\\)?[-.\\s]?"
        - "[2-9][0-9]{2}[-.\\s]?"
        - "[0-9]{4}";


_**Dates**_






[Date Formats by Country](https://en.wikipedia.org/wiki/List_of_date_formats_by_country)\
[Phone Number Formats by Country](https://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers#United_States,_Canada,_and_other_NANP_countries)