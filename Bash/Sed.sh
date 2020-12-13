#!/bin/bash

echo "this is a word" | sed 's/word/sentence/'
echo


sed 's/Bananas/peaches/' BasicText.txt
echo


sed -e 's/Toys/toys/; s/Trees/plants/' BasicText.txt
echo


sed 's/e/aaa/2' BasicText.txt
echo
sed 's/e/aaa/g' BasicText.txt
echo


sed 's/\/bin\/bash/\/bin\/zsh/' /etc/passwd | grep zsh
echo
sed 's!/bin/bash!/bin/zsh!' /etc/passwd | grep zsh
echo

#Line number
sed '2s/e/abcd/' BasicText.txt
echo
sed '2,4s/e/abcd/' BasicText.txt
echo
sed '2,$s/e/abcd/' BasicText.txt
echo
sed '2,$s/e/abcd/g' BasicText.txt
echo

#Lines with the word:
sed '/are/s/r/b/' BasicText.txt
echo
sed '/are/s/r/b/g' BasicText.txt
echo
sed '/Bananas/s/r/b/g' BasicText.txt
echo


sed 'd' BasicText.txt
echo
sed '4d' BasicText.txt
echo
sed '4,6d' BasicText.txt
echo


sed '/Bananas/d' BasicText.txt
echo


sed 'i\this is an inserted text' BasicText.txt
echo
sed '3i\2.5. this is an inserted text' BasicText.txt
echo
