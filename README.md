ical2csv
========

Convert an iCal file into a csv file

## Usage ##


`ical2csv.rb infile.ics outfile.csv`

Where `infile.ics` is an iCal file. If it contains more than a calendar, then
only the first calendar will be converted into the CSV file.

Each timestamp will be split in several subfields, containing year, month,
day, day of week, day of year, hour, minute, second, time zone of the timestamp.
The rationale is that a generated csv file is likely to be imported into a
spreadsheet or used my some other program, to compute some statistics or graphs.
Having different numeric fields will help in those cases

## TODO

1.  Export all calendars in a file
2.  Give a time zone in input, and convert all timestamps so that the generated
    file contains only timestamp in the given time zone.
