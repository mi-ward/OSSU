#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 14 09:40:31 2023

@author: Michael
"""


def interestCalc(balance, annualInterestRate, monthlyPaymentRate, months):
    monthlyAppliedInterest = annualInterestRate / 12

    
    for month in range(0, months):
        balance -= monthlyPaymentRate
        balance += balance * monthlyAppliedInterest
    
    return round(balance, 2)


def payoffCalc(balance, annualInterestRate, months):
    fixedPayment = 0
    while interestCalc(balance, annualInterestRate, fixedPayment, months) > 0 :
        fixedPayment += 10
          
    return round(fixedPayment)
        
#print(interestCalc(4773, 0.2, 0, 12))
print("Lowest payment: " + str(payoffCalc(4773, 0.2, 12)))
    
    
