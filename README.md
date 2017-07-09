# pgen
Perl program to generate XKCD-style passwords

## License

I want there to be NO barriers to using this code, so I am releasing it to the public domain.  But "public domain" does not have an internationally agreed upon definition, so I use CC0:

Copyright 2017 Steven Ford http://geeky-boy.com and licensed
"public domain" style under
[CC0](http://creativecommons.org/publicdomain/zero/1.0/): 
![CC0](https://licensebuttons.net/p/zero/1.0/88x31.png "CC0")

To the extent possible under law, the contributors to this project have
waived all copyright and related or neighboring rights to this work.
In other words, you can use this code for any purpose without any
restrictions.  This work is published from: United States.  The project home
is https://github.com/fordsfords/blink/tree/gh-pages

To contact me, Steve Ford, project owner, you can find my email address
at http://geeky-boy.com.  Can't see it?  Keep looking.

## Introduction

XKCD had an excellent comic -- https://xkcd.com/936/ -- which proposed a style of password generation consisting of randomly selecting 4 words from a list of ~2000 common words.  The result is a password which is more secure and easier to remember than most common methods of password creation.

The pgen program downloads a list of common english words and randomly selects some for a password.  I used the program to produce some mildly-interesting results in [my blog](http://blog.geeky-boy.com/2017/07/i-got-to-thinking-about-passwords-again.html).

Here are the interesting features of the program:

* It starts with a set of 3000 words published by [Education First](http://www.ef.edu/english-resources/english-vocabulary/top-3000-words/) and filters it by word length.

* It can either use Perl's internal pseudo-random number generator, or it can get random numbers from https://random.org which should make the resulting password more secure.  See http://blog.geeky-boy.com/2017/07/pseudo-random-passwords-limit-entropy.html

You can get help by entering:

        ./pgen -h

Important: if you plan to actually use the passwords you generate, use "-r"!  [Here's why](http://blog.geeky-boy.com/2017/07/pseudo-random-passwords-limit-entropy.html).

## 2000.sh and 3000.sh

Also included are two shell scripts that fetch lists of common words off the Internet.  2000.sh goes to [Wiktionary.org](https://en.wiktionary.org/wiki/Wiktionary:Frequency_lists/Contemporary_fiction) to get 2000 words, and 3000.sh goes to [Education First](http://www.ef.edu/english-resources/english-vocabulary/top-3000-words/) to get 3000 words.

These shell scripts are not needed since I included code in the Perl program to fetch the Education First list.
