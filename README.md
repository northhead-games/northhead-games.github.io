# Our Blog
To use the formatter, you can run:
```
awk -f html_log.awk <log file>
```

Log's should be of the following format:
```
ID log[number]
TITLE Log [number] - Log title
DATE The date

Some paragraphs of text. Code is formatted like `this`.  To reference a note write{note number}.  For example here I could reference note 1{1}.
NOTE 1 Notes can be wherever
SUBNOTE 1 and can be followed by subnotes if necessary
SUBNOTE 2 (you can have multiple)

Each paragraph must be separated by an empty line

IMAGE images/image.png images can be inserted like this, all of the text after the url is the alt text

<div>HTML will be put in the log as is as long as the line starts with a tag</div>

NOTE 2 You can also put notes at the end if that's easier
```
