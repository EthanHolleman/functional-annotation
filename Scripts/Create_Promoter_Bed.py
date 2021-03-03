import sys

promoters = {}
for line in sys.stdin:
    if line.startswith('#'):
        continue
    cols = line.strip().split('\t')
    if cols[2] == 'gene':
        if cols[6] == '+':
            start = str(max(0, int(cols[3]) - 2000))
            end = cols[3]
        elif cols[6] == '-':
            start = str(max(0, int(cols[4])))
            end = str(int(cols[4]) + 2000)
        print '\t'.join([cols[0], start, end])




