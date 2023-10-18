#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 14 09:40:31 2023

@author: Michael
"""

def interestCalc(balance, months):
    #annualInterestRate = 0.2
    monthlyAppliedInterest = annualInterestRate / 12
    #monthlyPaymentRate = 0.04
    
    for month in range(0, months):
        balance -= balance * monthlyPaymentRate
        balance += balance * monthlyAppliedInterest
    
    return round(balance, 2)
        
print("Remaining balance: " + str(interestCalc(balance, 12)))
    
    
