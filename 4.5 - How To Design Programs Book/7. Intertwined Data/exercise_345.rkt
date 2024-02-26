;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_345) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 345.

;Formulate a data definition for the representation of BSL expressions based on the structure type definitions
;of add and mul. Let’s use BSL-expr in analogy for S-expr for the new class of data.

;A BSL-expr is one of:
;  - Number
;  - Add
;  - Mul


;An Add is a structure:
; (define-struct add [left right])

;A Mul is a structure:
;(define-struct mul [left right])

;Translate the following expressions into data:
; 1. (+ 10 -10)
(make-add 10 -10)

; 2. (+ (* 20 3) 33)
(make-add (make-mul 20 3)
          33)

; 3. (+ (* 3.14 (* 2 3)) (* 3.14 (* -1 -9)))
(make-add (make-mul 3.14
                    (make-mul 2 3))
          (make-mul 3.14
                    (make-mul -1 -9)))

;Interpret the following data as expressions:
; 1. (make-add -1 2)
(+ -1 2)

; 2. (make-add (make-mul -2 -3) 33)
(+ (* -2 -3) 33)

; 3. (make-mul (make-add 1 (make-mul 2 3)) 3.14)
(* (+ 1 (* 2 3)) 3.14)

;Here “interpret” means “translate from data into information.”
;In contrast, “interpreter” in the title of this chapter refers to a program that consumes
;the representation of a program and produces its value.
;While the two ideas are related, they are not the same.