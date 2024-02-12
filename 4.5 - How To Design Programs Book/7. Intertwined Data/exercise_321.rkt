;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_321) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 321
;Abstract the data definitions for S-expr and SL
;so that they abstract over the kinds of Atoms that may appear.

; An [S-expr X] is one of: 
; – X
; – SL

;; An [SL X] is one of: 
;; – '()
;; – (cons X SL)

; An [SL X] is a [List-of [S-expr X]]