#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 14 09:40:31 2023

@author: Michael
"""

def interestCalc(balance, annualInterestRate, monthlyPaymentRate, months):
    monthlyAppliedInterest = annualInterestRate / 12

    
    for month in range(0, months):
        balance -= balance * monthlyPaymentRate
        balance += balance * monthlyAppliedInterest
    
    return round(balance, 2)
        
print("Remaining balance: " + str(interestCalc(1000, 0.2, 0.04, 12)))
    
    
