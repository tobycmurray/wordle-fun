.PHONY: default

OUTPUTS=1w-5.txt 1w-5-freq.csv wordle-freq-nyt.csv wordle-words-nyt-bad.txt wordle-words-orig-bad.txt wordle-guesses-nyt-bad.txt wordle-guesses-orig-bad.txt wordle-freq-histogram-nyt.csv 1w-5-freq-histogram.csv 1w.txt en-5.txt report-orig.txt report-nyt.txt wordle-freq-sorted-nyt.txt  words-removed-by-nyt.txt guesses-removed-by-nyt.txt

ENGLISH_FREQ=${OUT}1w.txt
BADWORDS=en.txt
BADWORDS5=${OUT}en-5.txt
OUT=out/


OUT_OUTPUTS=${OUTPUTS:%=${OUT}%}

default: ${OUT} ${OUT_OUTPUTS}

${OUT}:
	mkdir $@

${OUT}words-removed-by-nyt.txt: wordle-words-orig.txt wordle-words-nyt.txt
	diff $^ | grep '^<' | cut -d' ' -f2 > $@

${OUT}guesses-removed-by-nyt.txt: wordle-guesses-orig.txt wordle-guesses-nyt.txt
	diff $^ | grep '^<' | cut -d' ' -f2 > $@

# for completeness but these are empty at present
${OUT}words-added-by-nyt.txt: wordle-words-orig.txt wordle-words-nyt.txt
	diff $^ | grep '^>' | cut -d' ' -f2 > $@
${OUT}guesses-added-by-nyt.txt: wordle-guesses-orig.txt wordle-guesses-nyt.txt
	diff $^ | grep '^>' | cut -d' ' -f2 > $@

${OUT}wordle-freq-sorted-%.txt: ${OUT}wordle-freq-%.csv gen_sorted_by_freq.py
	cat $< | python gen_sorted_by_freq.py > $@

${OUT}1w.txt: count_1w.txt
	cat $< | cut -f1 > $@

${OUT}report-%.txt: wordle-words-%.txt ${OUT}wordle-words-%-bad.txt
	cat $< | python words.py $^ > $@

${OUT}%-5.txt: %.txt
	cat $< | grep "^[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]$$" > $@

${OUT}%-5.txt: ${OUT}%.txt
	cat $< | grep "^[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]$$" > $@

# FIXME: remove duplication with the following recipe
# FIXME: incredibly inefficient and takes ages (approx 1 hour on my machine)
#        would be better to first put the ${ENGLISH_FREQ} data into a hashtable
#        to avoid the linear time lookup currently performed by grep -n
${OUT}1w-5-freq.csv: ${OUT}1w-5.txt ${ENGLISH_FREQ}
	echo > $@;\
	for w in $$(cat $<); do\
	    num=$$(grep -n "^$$w$$" ${ENGLISH_FREQ} | cut -d':' -f1);\
	    if [ ! -z "$$num" ]; then echo "$$w, $$num" >> $@;\
	    else echo "$$w, 0" >> $@; fi;\
	done

${OUT}wordle-freq-%.csv: wordle-words-%.txt ${ENGLISH_FREQ}
	echo > $@;\
	for w in $$(cat $<); do\
	    num=$$(grep -n "^$$w$$" ${ENGLISH_FREQ} | cut -d':' -f1);\
	    if [ ! -z "$$num" ]; then echo "$$w, $$num" >> $@;\
	    else echo "$$w, 0" >> $@; fi;\
	done

${OUT}%-bad.txt: ${BADWORDS5} %.txt
	echo > $@;\
	for w in $$(cat $<); do\
	    outp=$$(grep "^$$w$$" ${@:${OUT}%-bad.txt=%.txt});\
	    if [ ! -z "$$outp" ]; then echo "$$outp" >> $@; fi;\
	done


${OUT}wordle-freq-histogram-%.csv: ${OUT}wordle-freq-%.csv gen_histograms.py
	cat $< | python gen_histograms.py > $@

# FIXME: remove duplication with above recipe
${OUT}1w-5-freq-histogram.csv: ${OUT}1w-5-freq.csv gen_histograms.py
	cat $< | python gen_histograms.py > $@

clean:
	rm -f ${OUT_OUTPUTS}
	rmdir ${OUT}
