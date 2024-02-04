;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_302) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 302
;Recall that each occurrence of a variable receives its value
;from its binding occurrence. Consider the following definition:

    ;(define x (cons 1 [x] ))

;Where is the shaded occurrence of x bound?
; to the first x

;Since the definition is a constant definition and
;not a function definition, we need to evaluate the
;right-hand side immediately. What should be the value
;of the right-hand side according to our rules?

;(cons 1 x) but this is not allowed as x is used before being defined