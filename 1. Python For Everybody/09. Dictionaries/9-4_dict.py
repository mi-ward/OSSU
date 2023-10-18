#9.4 Write a program to read through the mbox-short.txt and figure out 
# who has sent the greatest number of mail messages. 
# The program looks for 'From ' lines and takes the second word of those lines 
# as the person who sent the mail. 
# The program creates a Python dictionary that maps the sender's mail address to
# a count of the number of times they appear in the file. 
# After the dictionary is produced, the program reads through the dictionary using 
# a maximum loop to find the most prolific committer.

file = 'mbox-short.txt'
#fn = input('Enter file name:')

fh = open(file)
commits = dict()

for line in fh:
    if not line.startswith('From '):
        continue
    
    line = line.rstrip()
    line_arr = line.split()
    email = line_arr[1]
    commits[email] = commits.get(email, 0) + 1

prolific = None
prolific_count = None

for email, count in commits.items():
    if prolific_count is None:
        prolific = email
        prolific_count = count
    elif count > prolific_count:
        prolific = email
        prolific_count = count

print(prolific)


