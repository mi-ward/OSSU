;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_443) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 443. Given the header material for gcd-structural, a naive use of the design recipe might use the following template or some variant:

(define (gcd-structural n m)
  (cond
    [(and (= n 1) (= m 1)) ...]
    [(and (> n 1) (= m 1)) ...]
    [(and (= n 1) (> m 1)) ...]
    [else
     (... (gcd-structural (sub1 n) (sub1 m)) ...
      ... (gcd-structural (sub1 n) m) ...
      ... (gcd-structural n (sub1 m)) ...)]))

; Why is it impossible to find a divisor with this strategy?
; - Your termination cases won't be able to identify when the greatest common divisor is identified. Instead they're reducing each iteration
; - to the point of one or both being equal to 1. This takes an incredible amount of time if the numbers ar elarge enough and would not allow one
; - to determine the greatest common divisor in any capacity.