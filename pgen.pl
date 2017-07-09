#!/usr/bin/env perl -w
# pgen.pl - password generation tool
# Copyright 2017 Steve Ford (sford@geeky-boy.com) and made available under the
#   Steve Ford's "standard disclaimer, policy, and copyright" notice.  See
#   http://www.geeky-boy.com/steve/standard.html for details.  It means you
#   can do pretty much anything you want with it, including making your own
#   money, but you can't blame me for anything bad that happens.

use strict;
use Getopt::Std;
use LWP::Simple;
use LWP::UserAgent;


# globals
my $tool = "pgen.pl";
my $usage_str = "$tool [-h] [-q] [-r] [-s seed] [-l max_word_len] [-w num_words_in_pass] [-p num_passwords]";

# process options.
use vars qw($opt_h $opt_q $opt_r $opt_s $opt_l $opt_w $opt_p);
getopts('hqrs:l:w:p:') || usage();

if (defined($opt_h)) {
  help();  # if -h had a value, it would be in $opt_h
}

my $seed;
if (defined($opt_s)) {
  if (defined($opt_r)) { die("-r is incompatible with -s"); }
  $seed = $opt_s;
}
if (! defined($opt_r)) {
  if (! defined($seed)) {
    $seed = int(rand(2**31));
    print "seed=$seed\n";
  }

  srand($seed);  # Randomize
}

my $max_word_len = 99;
if (defined($opt_l)) {
  $max_word_len = $opt_l;
}

my $num_words_in_pass = 4;
if (defined($opt_w)) {
  $num_words_in_pass = $opt_w;
}

my $num_passwords = 1;
if (defined($opt_p)) {
  $num_passwords = $opt_p;
}


my $web_vocab = get("http://www.ef.edu/english-resources/english-vocabulary/top-3000-words/");

my @words;
foreach (split(/[\n\r]+/, $web_vocab)) {
  if (/^[\s]+(\w+)<br \/>/) {
    if (length($1) <= $max_word_len) {
      push(@words, $1);
    }
  }
}

my $num_words = scalar(@words);
print "num_words=$num_words\n";
printf("%d words gives %d bits entropy\n",
       $num_words_in_pass, log($num_words**$num_words_in_pass)/log(2));

my $num_randoms = $num_words_in_pass * $num_passwords;
my @randoms;
my $r = 0;

if (defined($opt_r)) {
  if ($num_randoms >= 10000) { die "too many randoms for -r"; }

  my $ua = LWP::UserAgent->new;
  my $req = HTTP::Request->new(GET =>
      "https://www.random.org/integers/" .
      "?num=$num_randoms\&min=1\&max=$num_words" .
      "\&col=1\&base=10\&format=html\&rnd=new");
  my $res = $ua->request($req);
  if (! $res->is_success) {
    die("UserAgent failed: ", $res->status_line, "\n");
  }
  my $web_rand = $res->as_string;

  $web_rand =~ s/^.*<pre class="data">//s;
  $web_rand =~ s/<\/pre>.*$//s;
  foreach (split(/[\n\r]+/, $web_rand)) {
    push(@randoms, $_);
  }
}

my $sum_password_lengths = 0;
for (my $i = 0; $i < $num_passwords; $i++) {
  my $password = "";
  for (my $i = 0; $i < $num_words_in_pass; $i++) {
    if (defined($opt_r)) {
      $password .= ucfirst($words[int($randoms[$r++])]);
    } else {
      $password .= ucfirst($words[int(rand($num_words))]);
    }
  }

  $sum_password_lengths += length($password);
  if (! defined($opt_q)) {
    print "password: $password\n";
    print "length: " . length($password) . "\n";
  }
}

print "Average password length=" . $sum_password_lengths/$num_passwords . "\n";

# All done.
exit(0);


# End of main program, start subroutines.


sub usage {
  my($err_str) = @_;

  if (defined $err_str) {
    print STDERR "$tool: $err_str\n\n";
  }
  print STDERR "Usage: $usage_str\n\n";

  exit(1);
}  # usage


sub help {
  my($err_str) = @_;

  if (defined $err_str) {
    print "$tool: $err_str\n\n";
  }
  print <<__EOF__;
Generate one or more passwords consisting of 4 or more randomly chosen common
english words.

Usage: $usage_str
Where:
    -h - help
    -q - quiet
    -r - use random.org (incompatible with -s)
    -s seed - Specify a pseudorandom seed.
    -l max_word_len - Limit the number of letters in each word.
    -w num_words_in_pass - Minimum number of random words per password.
    -p num_passwords - Number of passwords to generate.

__EOF__

  exit(0);
}  # help
