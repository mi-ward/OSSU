# 10.2 Write a program to read through the mbox-short.txt and figure out 
# the distribution by hour of the day for each of the messages. 
# You can pull the hour out from the 'From ' line by finding the time 
# and then splitting the string a second time using a colon.
# From stephen.marquard@uct.ac.za Sat Jan  5 09: 14: 16 2008
# Once you have accumulated the counts for each hour, print out the counts, sorted by hour as shown below.

fn = 'mbox-short.txt'
fh = open(fn)

hour_counts = dict()

for line in fh:
    if not line.startswith('From '):
        continue

    line = line.rstrip()
    time = line.split()[5]
    hour = time.split(':')[0]
    hour_counts[hour] = hour_counts.get(hour, 0) + 1

    
for hour, counts in sorted(hour_counts.items()):
    print(hour, counts)

    
