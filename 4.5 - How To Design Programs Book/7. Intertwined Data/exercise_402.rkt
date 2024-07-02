;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |exercise 402|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 402.
; Reread exercise 354.
; Explain the reasoning behind our hint to think of the given expression as an atomic value at first.

; This allows you to more easily comprehend each conditional.
; By treating it as an atomic value you can organize checks against the atomic value while iterating through the list and not have to think through processing both.