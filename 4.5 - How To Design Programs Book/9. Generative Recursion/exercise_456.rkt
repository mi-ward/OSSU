;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_456) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 456.
; Design root-of-tangent,
; a function that maps f and r1 to the root of the tangent
; through (r1,(f r1)).

(define ε 0.00000001)

(define (slope f r1)
  (* (/ 1 (* 2 ε))
     (- (f (+ r1 ε))
        (f (- r1 ε)))))

(define (root-of-tangent f r1)
  (- r1 (/ (f r1) (slope f r1))))

(check-expect (root-of-tangent (lambda (x) x) 10) 0)
(check-error (root-of-tangent (lambda (x) 5) 7))
(check-expect (root-of-tangent (lambda (x) (- (* 3/2 x) 2)) 3) 4/3)
(check-expect (root-of-tangent (lambda (x) (sqr x)) 1) 1/2)
(check-expect (root-of-tangent (lambda (x) (sqr x)) 5) 5/2)

; [Number -> Number] Number -> Number
; finds a number r such that (f r) is small
; generative repeatedly generates improved guesses
(define (newton f r1)
  (cond
    [(<= (abs (f r1)) ε) r1]
    [else (newton f (root-of-tangent f r1))]))

; [Number -> Number] Number -> Number
; finds a number r such that (<= (abs (f r)) ε)
 
(check-within (newton poly 1) 2 ε)
(check-within (newton poly 3.5) 4 ε)

; Number -> Number
(define (poly x) (* (- x 2) (- x 4)))
