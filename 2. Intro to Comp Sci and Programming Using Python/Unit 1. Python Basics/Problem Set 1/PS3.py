# -*- coding: utf-8 -*-
"""
Spyder Editor

Lecture 1 - Problem Set 3

Assume s is a string of lower case characters.

Write a program that prints the longest substring of s in 
which the letters occur in alphabetical order. 
For example, if s = 'azcbobobegghakl', then your program should print

Longest substring in alphabetical order is: beggh

In the case of ties, print the first substring. 
For example, if s = 'abcbcd', then your program should print

Longest substring in alphabetical order is: abc

Note: This problem may be challenging. 
We encourage you to work smart. 
If you've spent more than a few hours on this problem, 
we suggest that you move on to a different part of the course. 
If you have time, come back to this problem 
after you've had a break and cleared your head.
"""

s = 'azcbobobegghakl'

alpha = 'abcdefghijklmnopqrstuvwxyz'

first = ''
last = ''

longest_substring_alpha = ""


# loop through string
## each loop requires a loop after it
# store the substring with the longest length (could be single letter or full string)
## if the substring is no longer if alphabetical order start the next loop

for start_win_idx in range(0, len(s)):

    
    for i in range(0, len(alpha)):
        if alpha[i] == s[start_win_idx]:
            start_win_alpha = alpha[i]
            
    temp_substring = start_win_alpha

    end_win_alpha = ""
    
    for end_win_idx in range((start_win_idx+1), len(s)):

        for j in range(0, len(alpha)):
            if alpha[j] == s[end_win_idx]:
                end_win_alpha = alpha[j]
            
            
        if temp_substring[-1] <= end_win_alpha:
            temp_substring += end_win_alpha
        elif temp_substring[-1] > end_win_alpha:
            break
            
        if len(temp_substring) > len(longest_substring_alpha):
            longest_substring_alpha =  temp_substring


if len(longest_substring_alpha) > 1:
     print(longest_substring_alpha)
else:
    print(s[0])
    





            