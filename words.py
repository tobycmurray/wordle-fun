import sys
import datetime

w=open(sys.argv[1],"r")
words=w.readlines()
bw=open(sys.argv[2],"r")
iwords=bw.readlines()
birthdays=[(25,12,"Jesus"),(14,2,"Velentine"),(14,6,"Trump"),(13,5,"ScoMo"),(14,1,"Dave Grohl")]

epoch = datetime.date(2021,6,19)

def get_word(year,month,day):
    d = datetime.date(year,month,day)
    delta = d - epoch
    if delta.days >= 0 and delta.days < len(words):
        w = words[delta.days]
        print("Word for %s is %s" % (d,w))
        return w
    else:
        return None

def get_date(word):
    for i in range(0,len(words)):
        if words[i] == word:
            delta = datetime.timedelta(days=i)
            d = epoch + delta
            print("Date for %s is %s" % (word,d))
            return d
    return None

for b in birthdays:
    print(b[2])
    for year in range(2021,2035):
        m = b[1]
        d = b[0]
        get_word(year,m,d)
    print("")

for word in iwords:
    get_date(word)


