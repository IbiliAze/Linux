#!/bin/bash


''' IO '''
>
2> #STDERR
>>
2>>
&> # STDOUT & STDERR
tr : , < /etc/passwd #swap every : with , with STDIN
cat /etc/passwd | grep ibi | uniq -c



''' Vi '''    
vi ~/.vimrc
set number #numbered lines for all files, saved by default
vi +/word test.txt #+run a command right after opening, / search

COMMAND MODE
    > i #insert mode
    > o #insert a line and insert mode
    > a #insert mode, then next character
    > h #left 
    > j #down
    > k #up
    > l #right
    > yy #copy a line (yank)
    > p #paste a line
    > dd #delete a line
    > /word #look for the word 'word'
        > n #next word
        > N #unnext word ;)
    > ?word #look for the word 'word' backwards on the line you're on
    > ZZ #save and quit

EXECUTE MODE
    > :500 #jump to line 500
    > :q! #quit without saving
    > :d #delte a line
    > :1,3d #delete lines 1 to 3
    > :10,20s/word/word2 #from lines 10, 20, swap every 'word' with "word2:"
    > :%s/word/word2 #same as above but with every line
    > :set number #numbered lines, settings won't be saved
    > :1,50y #copy lines 1 to 50 (yank)
    > :p #paste
    > :w file2.txt #save as file2.txt (new file)
    > :e file3.txt #edit another file