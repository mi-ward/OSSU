#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 24 14:49:08 2023

@author: Michael
"""

def genPrimes():
    x = 2
    primes = [2]
    yield primes
    
    while True:
        isPrime = True
        for p in primes:
            if x % p == 0:
                isPrime = False
            
        if isPrime:
            primes.append(x)
            yield primes
    
        x+=1

        
        
    
                