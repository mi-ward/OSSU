#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 11 13:16:31 2023

@author: Michael
"""

print("Please think of a number between 0 and 100!")

max_num = 100
min_num = 0
guess = max_num / 2

instructions =  "Enter 'h' to indicate the guess is too high. " \
                "Enter 'l' to indicate the guess is too low. "  \
                "Enter 'c' to indicate I guessed correctly. "
i = ""

while i != 'c':
    guess = min_num + int((max_num - min_num) / 2)
    print("Is your secret number ", end ="")
    print (str(guess) + "?")
    i = input(instructions)
    
    if i == 'l':
        min_num = guess
    elif i == 'h':
        max_num = guess
    elif i == 'c':
        break
    else:
        print("Sorry, I did not understand your input.")

print("Game over. Your secret number was: ", end=str(guess))

        
    
        
    