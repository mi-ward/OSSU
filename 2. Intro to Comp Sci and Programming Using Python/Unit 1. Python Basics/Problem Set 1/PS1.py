#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 16:17:16 2023

@author: Michael

Problem 1
1.0/1 point (ungraded)
Assume s is a string of lower case characters.

Write a program that counts up the number of vowels contained in the string s. 
Valid vowels are: 'a', 'e', 'i', 'o', and 'u'. For example, if s = 'azcbobobegghakl', 
your program should print:
    
Number of vowels: 5

"""

count = 0

for letter in s:
  if ((letter == "a") or (letter == "e") or (letter == "i") or (letter == "o") or (letter == "u")):
    count += 1

print("Number of vowels: " + str(count))