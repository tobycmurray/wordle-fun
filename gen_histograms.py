import sys

# buckets[0] reserved for '0'
# buckets[i] for i > 0 is for values in range (i-1)*binsize+1 .. i*binsize

buckets={}
binsize=1000
maxbucket=0

def read_bucket(bucket):
    global buckets
    if bucket not in buckets.keys():
        buckets[bucket] = 0
    return buckets[bucket]

def add_to_bucket(freq):
    global buckets
    global binsize
    global maxbucket
    bucket = 0
    if freq > 0:
        bucket = (freq-1)/binsize+1
    count=read_bucket(bucket)
    buckets[bucket] = count+1
    if bucket > maxbucket:
        maxbucket = bucket

for line in sys.stdin.readlines():
    sp=line.split(",")
    if len(sp) > 1:
        word=sp[0].strip()
        freq=int(sp[1].strip())
        add_to_bucket(freq)


for bucket in range(maxbucket+1):
    if bucket != 0:
        #print("\"0\", %d" % read_bucket(0))
        print("\"%d--%d\", %d" % ((bucket-1)*binsize+1,bucket*binsize,read_bucket(bucket)))
    
