.PHONY: default

OUTPUTS=wordle-freq.csv wordle-words-nyt-bad.txt wordle-words-orig-bad.txt wordle-guesses-nyt-bad.txt wordle-guesses-orig-bad.txt wordle-freq-histogram.csv 1w.txt en-5.txt report-orig.txt report-nyt.txt

ENGLISH_FREQ=1w.txt
BADWORDS=en.txt
BADWORDS5=en-5.txt

default: ${OUTPUTS}

1w.txt: count_1w.txt
	cat $< | cut -f1 > $@

report-%.txt: wordle-words-%.txt wordle-words-%-bad.txt
	cat $< | python words.py $^ > $@

%-5.txt: %.txt
	cat $< | grep "^[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]$$" > $@

wordle-freq.csv: wordle-words-nyt.txt ${ENGLISH_FREQ}
	echo > $@;\
	for w in $$(cat $<); do\
	    num=$$(grep -n "^$$w$$" ${ENGLISH_FREQ} | cut -d':' -f1);\
	    if [ ! -z "$$num" ]; then echo "$$w, $$num" >> $@;\
	    else echo "$$w, 0" >> $@; fi;\
	done

%-bad.txt: ${BADWORDS5} %.txt
	echo > $@;\
	for w in $$(cat $<); do\
	    outp=$$(grep "^$$w$$" ${@:%-bad.txt=%.txt});\
	    if [ ! -z "$$outp" ]; then echo "$$outp" >> $@; fi;\
	done


wordle-freq-histogram.csv: wordle-freq.csv gen_histograms.py
	cat $< | python gen_histograms.py > $@

clean:
	rm -f ${OUTPUTS}
