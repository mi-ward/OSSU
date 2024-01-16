;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_282) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(define (f x) (* 10 x))
;(f 10) -> 100

;(define f (lambda (x) (* 10 x)))
;(f 10) -> 100

;Exercise 282.
;Experiment with the above definitions in DrRacket.

;Also add
; Number -> Boolean
;(define (compare x)
;  (= (f-plain x) (f-lambda x)))
;to the definitions area after renaming the left-hand f
;to f-plain and the right-hand one to f-lambda.

;Then run (compare (random 100000))
;a few times to make sure the two functions
;agree on all kinds of inputs.

(define (f-plain x) (* 10 x))
(define f-lambda (lambda (x) (* 10 x)))

(define (compare x)
  (= (f-plain x) (f-lambda x)))

(compare (random 100000)) ;-> #true
(compare (random 100000)) ;-> #true
(compare (random 100000)) ;-> #true
(compare (random 100000)) ;-> #true