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
    lowerBound = balance / 12
    upperBound = (balance * (1 + (annualInterestRate/12))**12) / 12
    payment = lowerBound + (upperBound - lowerBound) / 2
    print(payment)
    while (interestCalc(balance, annualInterestRate, payment, months)*100) not in range(-10, 10):
        if interestCalc(balance, annualInterestRate, payment, months) > 0:
            lowerBound = payment
            payment = lowerBound + (upperBound - lowerBound) / 2
        elif interestCalc(balance, annualInterestRate, payment, months) < 0:
            upperBound = payment
            payment = lowerBound + (upperBound - lowerBound) / 2
            
    return round(payment, 2)
        
#print(interestCalc(4773, 0.2, 0, 12))
print("Lowest payment: " + str(round(payoffCalc(4773, 0.2, 12)), 2))

    
