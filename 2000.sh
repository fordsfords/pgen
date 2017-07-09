#!/bin/sh
# simple_words.sh

rm -f words2k_*.txt
curl -s https://en.wiktionary.org/wiki/Wiktionary:Frequency_lists/Contemporary_fiction |  # get the wiki page
  grep "<li>" |                                    # select out the word lines
  sed 's/^.*title="//;s/".*$//' >words2k_all.txt     # isloate the word

egrep -v "[^a-z]" <words2k_all.txt >words2k_lets.txt # elim caps, non-letters
egrep "^.$|^..$|^...$" <words2k_lets.txt >words2k_123.txt
egrep "^....$" <words2k_lets.txt >words2k_4.txt
egrep "^.....$|^......$|^.......$|^........$" <words2k_lets.txt >words2k_5678.txt
egrep "^.........$|^..........$|^...........$|^............$" <words2k_lets.txt >words2k_9012.txt

wc words2k_*.txt
