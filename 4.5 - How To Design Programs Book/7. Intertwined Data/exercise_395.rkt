;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_395) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 395.
; Design take.
; It consumes a list l and a natural number n.
; It produces the first n items from l or all of l if it is too short.

; [List-of X] Number -> [List-of X]
; It produces the first n items from l or all of l if it is too short.
(define (take lox n)
  (cond
    [(or (empty? lox) (zero? n)) '()]
    [else
     (cons (first lox) (take (rest lox) (sub1 n)))]))

(check-expect (take '(a b c d e f g h) 4) '(a b c d))
(check-expect (take '(a b c d e f g h) 10) '(a b c d e f g h))
(check-expect (take '(a b c d e f g h) 8) '(a b c d e f g h))

; Design drop.
; It consumes a list l and a natural number n.
; Its result is l with the first n items removed or just ’() if l is too short.

; [List-of X] Number -> [List-of X]
; It consumes a list l and a natural number n.
; Its result is l with the first n items removed or just ’() if l is too short.

(define (drop lox n)
  (cond
    [(or (empty? lox) (zero? n)) lox]
    [else (drop (rest lox) (sub1 n))]))

(check-expect (drop '(a b c d e f g h) 0) '(a b c d e f g h))
(check-expect (drop '(a b c d e f g h) 4) '(e f g h))
(check-expect (drop '(a b c d e f g h) 8) '())
(check-expect (drop '(a b c d e f g h) 10) '())