# wordle-fun

Some fun with Wordle. By Toby Murray.

## How to Build

Run `make`. However outputs are already archived in the `out/` directory so
`make` is only useful to re-build the outputs.

## Outputs

Outputs are placed in the `out/` subdirectory. They include:
* `1w-5-freq-histogram.csv`: frequency histogram data for 5-letter English words
* `1w-5-freq.csv`: list of 5-letter English words with frequency rank
* `1w-5.txt`: list of 5-letter English words
* `1w.txt`: list of 1/3 million most common English words
* `en-5.txt`: list of 5-letter objectionable words
* `guesses-removed-by-nyt.txt`: words removed from the guesslist by NYT
* `report-nyt.txt`: report including dates on which objectionable words will arise, from NYT wordlist
* `report-orig.txt`: report including dates on which objectionable words will arise, from original wordlist
* `wordle-freq-histogram-nyt.csv`: frequency histogram data for NYT Wordle wordlist
* `wordle-freq-nyt.csv`: Wordle NYT wordlist with frequency rank
* `wordle-freq-sorted-nyt.txt`: Wordle NYT wordlist sorted by frequency rank
* `wordle-guesses-nyt-bad.txt`: Objectionable words in the NYT guesslist
* `wordle-guesses-orig-bad.txt`: Objectionable words in the original wordlist
* `wordle-words-nyt-bad.txt`: Objectionable words in the NYT wordlist
* `wordle-words-orig-bad.txt`: Objectionable words in the original wordlist
* `words-removed-by-nyt.txt`: words removed from the wordlist by NYT

## Source Material Obtained from Elsewhere

* `en.txt` used unmodified from https://raw.githubusercontent.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/master/en

  Licence: Creative Commons Attribution 4.0 International


* `count_1w.txt` used unmodified from https://norvig.com/ngrams/count_1w.txt

  Code copyright (c) 2008-2009 by Peter Norvig. License: MIT License

* `wordle-words-nyt.txt` and `wordle-guesses-nyt.txt` sourced from the lists in https://www.nytimes.com/games/wordle/main.4d41d2be.js on Feb 22 2022
* `wordle-words-orig.txt` and `wordle-guesses-orig.txt` sourced from the lists in https://web.archive.org/web/20220115071441js_/https://www.powerlanguage.co.uk/wordle/main.c1506a22.js on Feb 2022 2022

All four of the latter were sourced by manually copying the strings of comma-separated, double-quote delimited words from the JavaScript source files and trivially tokenising them via a tiny Python script (details omitted)

