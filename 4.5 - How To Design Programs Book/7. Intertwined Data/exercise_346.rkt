;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_346) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 346.
;Formulate a data definition for the class of values to which a representation of a BSL expression can evaluate.

; A Add is a structure:
; - (make-add BSL-expr BSL-expr)

; A Mul is a structure:
; - (make-mul BSL-expr BSL-expr)

; A BSL-expr is one of:
; - Number
; - Add
; - Mul

(define BSLexp1 (make-add 5 5))
(define BSLexp2 (make-mul 5 5))
(define BSLexp3 (make-mul (make-add 2 3) 5))

