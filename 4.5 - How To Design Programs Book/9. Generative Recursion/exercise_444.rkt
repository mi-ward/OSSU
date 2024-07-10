;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_444) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 444.
; Exercise 443 means that the design for gcd-structural calls for some planning and a design-by-composition approach.

; The very explanation of “greatest common denominator” suggests a two-stage approach.
; First design a function that can compute the list of divisors of a natural number.
; Second, design a function that picks the largest common number in the list of divisors of n and the list of divisors of m.

;The overall function would look like this:
(define (gcd-structural S L)
  (largest-common (divisors S S) (divisors S L)))
 
; N[>= 1] N[>= 1] -> [List-of N]
; computes the divisors of l smaller or equal to k
(define (divisors k l)
  (cond [(zero? k) '()]
        [else
         (if (zero? (remainder l k))
             (cons k (divisors (sub1 k) l))
             (divisors (sub1 k) l))]))

(check-expect (divisors 10 10) (list 10 5 2 1))
(check-expect (divisors 1 1) (list 1))
(check-expect (divisors 7 7) (list 7 1))
              
 
; [List-of N] [List-of N] -> N
; finds the largest number common to both k and l
(define (largest-common k l)
  (if (member? (first k) l)
      (first k)
      (largest-common (rest k) l)))

(check-expect (gcd-structural 5 10) 5)
(check-expect (gcd-structural 7 17) 1)

(check-expect (gcd-structural 101135853 45014640) 177)
(check-expect (gcd-structural 45014640 101135853) 177)

  

; Why do you think divisors consumes two numbers? Why does it consume S as the first argument in both uses?
; - divisors needs to two numbers so it can handle the recursive cases
; - assuming S is the smaller of the two, the GCD will never be higher than S