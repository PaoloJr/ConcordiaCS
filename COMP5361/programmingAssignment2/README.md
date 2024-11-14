## RegEx Grammar
_**Phone Numbers**_
- Follows the North America Numbering Plan (NANP)
    - in the format NXX NXX-XXXX
    - where `N` represents digits `2` to `9`
    - the first 3-digit group is the area code

    **Phone Number Grammar** \
    _first 3 digits_
    > A --> D2B | D3B | D4B | D5B | D6B | D7B | D8B | D9B \
    > B --> 0C | 1C | 2C | 3C | 4C | 5C | 6C | 7C | 8C | 9C \
    > C --> 0EF | 1EF | 2EF | 3EF | 4EF | 5EF | 6EF | 7EF | 8EF | 9EF \
    > D --> ( | $\lambda$ \
    > E --> ) | $\lambda$ \
    > F --> (space) | - | . | $\lambda$
    
    _second 3-digit group (area code)_
    > G --> 2H | 3H | 4H | 5H | 6H | 7H | 8H | 9H
    > H --> 0I | 1I | 2I | 3I | 4I | 5I | 6I | 7I | 8I | 9I
    > I --> 0F | 1F | 2F | 3F | 4F | 5F | 6F | 7F | 8F | 9F

    _4-digit group (subscriber)_
    > J --> 0KKK | 1KK | 2KK | 3KK | 4KK | 5KK | 6KK | 7KK | 8KK | 9KK
    > K --> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

_**Dates**_






[Date Formats by Country](https://en.wikipedia.org/wiki/List_of_date_formats_by_country)\
[Phone Number Formats by Country](https://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers#United_States,_Canada,_and_other_NANP_countries)