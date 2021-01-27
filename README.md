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
is https://github.com/fordsfords/pgen

To contact me, Steve Ford, project owner, you can find my email address
at http://geeky-boy.com.  Can't see it?  Keep looking.

## Introduction

XKCD had an excellent comic -- https://xkcd.com/936/ -- which proposed a style of password generation consisting of randomly selecting 4 words from a list of ~2000 common words.  The result is a password which is more secure and easier to remember than most common methods of password creation.

The pgen program uses a list of 3000 common english words and randomly selects some for a password.  I used the program to produce some mildly-interesting results in [my blog](http://blog.geeky-boy.com/2017/07/i-got-to-thinking-about-passwords-again.html).

Here are the interesting features of the program:

* It starts with a set of 3000 words that I put together.
I make use of several "lists of common words" for suggestions, including
[Education First](http://www.ef.edu/english-resources/english-vocabulary/top-3000-words/)
and [Wikipedia](https://en.wiktionary.org/wiki/Wiktionary:Frequency_lists/Contemporary_fiction).
But this is not a simple copy of any of the lists, and I consider it
my own.
I wanted them to be words that most people would understand and know how to
spell.

* It can either use Perl's internal pseudo-random number generator (useful for experimentation and statistics gathering), or it can get random numbers from https://random.org which makes the resulting password properly secure.

You can get help by entering:

        ./pgen.pl -h

Important: if you plan to actually use the passwords you generate, use "-r"!  [Here's why](http://blog.geeky-boy.com/2017/07/pseudo-random-passwords-limit-entropy.html).

To try it out without downloading it, go here:
https://repl.it/@fordsfords/pgen#README.md

Click on the right-hand panel and enter:

        ./pgen.pl -r
