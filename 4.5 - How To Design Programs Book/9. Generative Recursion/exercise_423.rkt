;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_423) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 423.
; Define partition.
; It consumes a String s and a natural number n.
; The function produces a list of string chunks of size n.

; For non-empty strings s and positive natural numbers n,
; (equal? (partition s n) (bundle (explode s) n)) is #true. But don’t use this equality as the definition for partition; use substring instead.

; Hint Have partition produce its natural result for the empty string. For the case where n is 0, see exercise 421.

; Note The partition function is somewhat closer to what a cooperative DrRacket environment would need than bundle.


; String Number -> [List of String]
; Produce a list of string chunks of size n
(define (partition s n)
  (cond
    [(zero? n) '()]
    [(string=? "" s) (list s)]
    [(<= (string-length s) n) (list s)]
    [else
     (cons (substring s 0 n) (partition (substring s n) n))]))

(check-expect (partition "" 3) (list ""))
(check-expect (partition "abc" 0) '())
(check-expect (partition "abc" 1) (list "a" "b" "c"))
(check-expect (partition "abc" 3) (list "abc"))
(check-expect (partition "abcdef" 3) (list "abc" "def"))
(check-expect (partition "abcdefg" 3) (list "abc" "def" "g"))
(check-expect (partition "abcdefg" 5) (list "abcde" "fg"))
