;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_387) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 387.
; Design cross.
; The function consumes a list of symbols and a list of numbers and produces all possible ordered pairs of symbols and numbers.
; That is, when given '(a b c) and '(1 2), the expected result is '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)).

; [List-of Symbols] [List-of Numbers] -> [List-of Pairs]
; consume list of symbols and a list of numbers, produce all possible ordered pairs of symbols and numbers.

(define (cross los lon)
  (cond
    [(empty? los) '()]
    [else
     (append (step (first los) lon) (cross (rest los) lon))]))

(define (step x lon)
  (cond
    [(empty? lon) '()]
    [else
     (cons (cons x (cons (first lon) '())) (step x (rest lon)))]))



(check-expect (cross '(a b c) '(1 2)) '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))