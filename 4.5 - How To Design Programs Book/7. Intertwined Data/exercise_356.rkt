;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_356) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 356
;Extend the data representation of chapter 21.2 to include the application of a programmer-defined function.
;Recall that a function application consists of two pieces: a name and an expression.
;The former is the name of the function that is applied; the latter is the argument.
;Represent these expressions: (k (+ 1 1)), (* 5 (k (+ 1 1))), (* (i 5) (k (+ 1 1))).

;We refer to this newly defined class of data as BSL-fun-expr.

; A BSL-fun-expr is one of: 
; – Number
; – Symbol
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fa Symbol BSL-fun-expr)

;(k (+ 1 1))
(make-fa 'k (make-add 1 1))

;(* 5 (k (+ 1 1)))
(make-mul 5 (make-fa 'k (make-add 1 1)))

;(* (i 5) (k (+ 1 1)))
(make-mul (make-fa i 5) (make-fa k (make-add 1 1)))
