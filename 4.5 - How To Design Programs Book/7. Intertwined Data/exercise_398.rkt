;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_398) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 398.
; A linear combination is the sum of many linear terms,
; that is, products of variables and numbers.
; The latter are called coefficients in this context. Here are some examples:

; 5x
; 5x + 17y
; 5x + 17y + 3z

;In all examples, the coefficient of x is 5, that of y is 17, and the one for z is 3.
; If we are given values for variables, we can determine the value of a polynomial. For example, if x = 10, the value of image is 50
; if x = 10 and y = 1, the value of image is 67; and if x = 10, y = 1, and z = 2, the value of image is 73.

; There are many different representations of linear combinations.
; We could, for example, represent them with functions.
; An alternative representation is a list of its coefficients. The above combinations would be represented as:
(list 5)
(list 5 17)
(list 5 17 3)

; This choice of representation assumes a fixed order of variables.

; Design value.
; The function consumes two equally long lists:
; a linear combination and a list of variable values. It produces the value of the combination for these values.

; [List-of Number] [List-of Number] -> Value
; Produces the value of the combination for these values
(define (value lon1 lon2)
  (cond
    [(and (empty? lon1) (empty? lon2)) 0]
    ;[(and (cons? lon1) (empty? lon2)) 0]
    ;[(and (empty? lon1) (cons? lon2)) 0]
    [(and (cons? lon1) (cons? lon2))
     (+ (* (first lon1) (first lon2)) (value (rest lon1) (rest lon2)))]))

(check-expect (value (list 5) (list 10)) 50)
(check-expect (value (list 5 17) (list 10 1)) 67)
(check-expect (value (list 5 17 3) (list 10 1 2)) 73)
     