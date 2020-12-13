#!/bin/bash


''' regex '''
man 7 regex #regex manual
[...] #list of possible values, ignore ...
- #range of values
. #any signle character
* #any number of characters
^ #beginning of line
$ #end of line
...|... #or, cat calc.txt | grep -E "halloween|christmas", ignroe ... 
(...) #sub-expression, ignore ...
\ #escape character

''' grep '''
grep -r test.txt ~ #search test.txt file in yout home directory, recursive search
cat get-docker.sh | egrep "echo|docker" #in the get-docker.sh file, perform extented grep, looking for the words echo OR docker
cat holidays.txt | egrep "^1[0-2]" #numbers that are: 10, 11, 12
cat kermit.txt | egrep "[Kk]ermit"