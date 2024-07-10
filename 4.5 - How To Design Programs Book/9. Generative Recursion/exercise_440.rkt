;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_440) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 440.
; Copy gcd-generative into the definitions area of DrRacket
; and evaluate (time (gcd-generative 101135853 45014640)) in the interactions area.


; my solution
(define (gcd-generative n m)
  (local ((define low (min n m))
          (define high (max n m)))
    (cond
      [(= low 0) high]
      [else
       (gcd-generative low (remainder high low))])))

;from textbook
(define (gcd-generative-tb n m)
  (local (; N[>= 1] N[>=1] -> N
          ; generative recursion
          ; (gcd L S) == (gcd S (remainder L S))
          (define (clever-gcd L S)
            (cond
              [(= S 0) L]
              [else (clever-gcd S (remainder L S))])))
    (clever-gcd (max m n) (min m n))))

(time (gcd-generative 101135853 45014640))
; - result: cpu time: 0 real time: 0 gc time: 0
; - 177

(time (gcd-generative-tb 101135853 45014640))
; - result: cpu time: 0 real time: 0 gc time: 0
; - 177
        