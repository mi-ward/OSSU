;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_455) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 455.
; Translate this mathematical formula into the ISL+
; function slope, which maps function f and a
; number r1 to the slope of f at r1.

;Assume that ε is a global constant.
; For your examples, use functions whose exact slope
; you can figure out, say, horizontal lines,
; linear functions, and perhaps polynomials
; if you know some calculus.

(define ε 0.00000001)

(define (slope f r1)
  (* (/ 1 (* 2 ε))
     (- (f (+ r1 ε))
        (f (- r1 ε)))))

(check-expect (slope (lambda (x) x) 10) 1)
(check-expect (slope (lambda (x) 5) 7) 0)
(check-expect (slope (lambda (x) (- (* 3/2 x) 2)) 3) 3/2)
(check-expect (slope (lambda (x) (sqr x)) 1) 2)
(check-expect (slope (lambda (x) (sqr x)) 5) 10)
