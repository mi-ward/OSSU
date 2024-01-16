;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_279) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 279. Decide which of the following phrases are legal lambda expressions:
(lambda (x y) (x y y)) ;-> legal, takes in two

(lambda () 10) ;-> not legal, requires a variable

(lambda (x) x) ;-> legal, will just return x

(lambda (x y) x) ;-> legal, will just return the first variable

(lambda x 10) ;-> not legal, need variables

;Explain why they are legal or illegal. If in doubt, experiment in the interactions area of DrRacket. 