#!/bin/bash



printf "hello \nWhats up" #\n new line
wc test.txt #wordcount
sort calendar.txt #sort
sort -r calendar.txt #reverse sort
sort -k 2 -t" " holidays.txt #-k column, -t delimiter, " " space (sorts with characters)
cut -f 2 -d, holidays.csv #-f field (column), -d delimiter
diff file1.txt file2.txt #file comparison
.... >file2.txt
.... <file1.txt
awk '$1 == "install"' get-docker.sh #$1 first set of info, =="install" is equal to
sed '/fi/d' get-docker.sh #delete every 'fi' wor