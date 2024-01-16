;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_281) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;Exercise 281.

;Write down a lambda expression that
;consumes a number and decides whether it is less than 10;

(lambda (x) (< x 10))
((lambda (x) (< x 10)) 1)

;multiplies two given numbers and turns the result into a string

(lambda (x y) (number->string (* x y)))
((lambda (x y) (number->string (* x y))) 4 5)

;consumes a natural number and returns 0 for evens and 1 for odds
(lambda (x) (if (odd? x) 1 0))
((lambda (x) (if (odd? x) 1 0)) 5)
((lambda (x) (if (odd? x) 1 0)) 6)

;consumes two inventory records and compares them by price
(lambda (ir1 ir2) (> (ir-price ir1) (ir-price ir2)))
(define-struct ir [name price])
(define IR1 (make-ir "bean" 1))
(define IR2 (make-ir "camera" 200))
((lambda (ir1 ir2) (> (ir-price ir1) (ir-price ir2))) IR1 IR2)

;adds a red dot at a given Posn to a given Image.
(lambda (x y img) (place-image (circle 5 "solid" "red") x y img))
(define mts (empty-scene 100 100))
((lambda (x y img) (place-image (circle 5 "solid" "red") x y img)) 55 55 mts)


;Demonstrate how to use these functions in the interactions area.
