;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_291) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 291.
;The fold functions are so powerful that you can define almost any list-processing functions with them.
;Use fold to define map-via-fold, which simulates map.

;Fn [List-of X] -> [List-of Y]
;simulates map
(define (map-via-fold fn lox)
  (foldr (lambda (x lst) (cons (fn x) lst)) '()  lox))

(check-expect (map-via-fold sqr (list 1 2 3)) (map sqr (list 1 2 3)))
(check-within (map-via-fold sqrt (list 1 2 3)) (map sqrt (list 1 2 3)) 0.001)