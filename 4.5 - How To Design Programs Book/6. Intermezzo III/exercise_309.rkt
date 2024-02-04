;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_309) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)
;Exercise 309
;Design the function words-on-line, which determines the
;number of Strings per item in a list of list of strings

(define LINE1 (list "The" "quick" "brown" "fox"))
(define LINE2 (list "jumped" "over" "the"))
(define LINE3 (list "lazy" "dog"))
(define SENTENCE (list LINE1 LINE2 '() LINE3))


;[List-of List-of String] -> [List-of Number]
;Design the function words-on-line, which determines the
;number of Strings per item in a list of list of strings

(define (words-on-line lst)
  (for/list  ([line lst])
    (length line)))

(check-expect (words-on-line SENTENCE) (list 4 3 0 2))