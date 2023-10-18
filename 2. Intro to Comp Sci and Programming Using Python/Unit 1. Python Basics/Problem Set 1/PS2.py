#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 16:18:19 2023

@author: Michael


Problem 2 
Assume s is a string of lower case characters.

Write a program that prints the number of times the string 'bob' occurs in s. For example, if s = 'azcbobobegghakl', then your program should print

Number of times bob occurs is: 2

"""

# Paste your code into this box 
n = "bob"
i = 0
j = i + len(n)
count = 0

while j <= len(s):
  if s[i:j] == n:
    count += 1
  i+=1
  j+=1
  

print("Number of times bob occurs is: " + str(count))