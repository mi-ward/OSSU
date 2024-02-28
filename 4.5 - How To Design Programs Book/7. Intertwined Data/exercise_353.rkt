;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_353) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 353

;Design the numeric? function.
;It determines whether a BSL-var-expr is also a BSL-expr.
;Here we assume that your solution to exercise 345 is the definition for BSL-var-expr without Symbols.

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

(define-struct add [left right])
;An add is a structure
; - (make-add BSL-var-expr BSL-var-expr)

(define-struct mul [left right])
;An mul is a structure
; - (make-mul BSL-var-expr BSL-var-expr)

;BSL-var-expr -> Boolean
;determines whether a BSL-var-expr is also a BSL-expr
(define (numeric? bslve)
  (cond [(symbol? bslve) #false]
        [(add? bslve) (and (numeric? (add-left bslve)) (numeric? (add-right bslve)))]
        [(mul? bslve) (and (numeric? (mul-left bslve)) (numeric? (mul-right bslve)))]
        [else #true]))

(check-expect (numeric? 'x) #false)
(check-expect (numeric? 5) #true)
(check-expect (numeric? (make-add 5 5)) #true)
(check-expect (numeric? (make-add 5 'x)) #false)
(check-expect (numeric? (make-mul 10 5)) #true)
(check-expect (numeric? (make-mul 'x 5)) #false)
(check-expect (numeric? (make-mul (make-add 10 (make-mul (make-mul 10 20) 5)) 10)) #true)
(check-expect (numeric? (make-mul (make-add 10 (make-mul (make-mul 10 20) 'x)) 10)) #false)
        
                      