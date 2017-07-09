#!/bin/sh
# 3000_words.sh

rm -f words3k_*.txt
curl -s http://www.ef.edu/english-resources/english-vocabulary/top-3000-words/ |
  grep "^[ 	].*<br />" |                                    # select out the word lines
  sed 's/<br \/>//;s/^[ 	]*//' >words3k_all.txt     # isloate the word

egrep -v "[^a-z]" <words3k_all.txt >words3k_lets.txt # elim caps, non-letters
egrep "^.$|^..$|^...$" <words3k_lets.txt >words3k_123.txt
egrep "^....$" <words3k_lets.txt >words3k_4.txt
egrep "^.....$|^......$|^.......$|^........$" <words3k_lets.txt >words3k_5678.txt
egrep "^.........$|^..........$|^...........$|^............$" <words3k_lets.txt >words3k_9012.txt

wc words3k_*.txt
