import sys

for line in sys.stdin:
    if line.startswith('#'):
        continue
    parts = line.split()
    if parts[6] == '+':
        print "{}\t{}\t{}".format(parts[0], parts[3], str(int(parts[3]) + 1))
    elif parts[6] == '-':
        print "{}\t{}\t{}".format(parts[0], parts[4], str(int(parts[4]) + 1))

