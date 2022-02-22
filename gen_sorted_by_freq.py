import sys

lines=sys.stdin.readlines()

def getKey(line):
    sp=line.split(",")
    key = -1
    if len(sp) > 1:
        key=int(sp[1].strip())        
    return key

slines=sorted(lines,key=getKey)

for sl in slines:
    print(sl.strip())
