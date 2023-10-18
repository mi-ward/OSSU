#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul 13 14:06:15 2023

@author: Michael
"""

def isIn(char, aStr):
    '''
    char: a single character
    aStr: an alphabetized string
    
    returns: True if char is in aStr; False otherwise
    '''
    # Your code here
    if len(aStr) <= 1:
      return char == aStr
    else:
        if char >= aStr[len(aStr)//2]:
            return isIn(char, aStr[len(aStr)//2:])
        elif char <= aStr[len(aStr)//2]:
            return isIn(char, aStr[:len(aStr)//2])
  
print(isIn("a", ""))
print(isIn("a", "a"))
print(isIn("a", "b"))
print(isIn("a", "abc"))
print(isIn("a", "abcd"))
print(isIn("a", "abcde"))
print(isIn("f", "abcde"))