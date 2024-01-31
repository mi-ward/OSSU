;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_297) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 297
;Exercise 297. Design the function distance-between. It consumes two numbers and a Posn: x, y, and p.
;The function computes the distance between the points (x, y) and p.

;Domain Knowledge:
;The distance between (x0, y0) and (x1, y1) is
; sqrt( (x0 - x1)^2 + (y0 - y1)^2)

;that is, the distance of (x0 - y0, x1 - y1) to the origin.

;Number Number Posn -> Number
; computes distance between x, y and p
(define (distance-between x y p)
  (sqrt (+ (sqr (- x (posn-x p))) (sqr (- y (posn-y p))))))