;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_438) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 438.

(define (gcd-structural n m)
  (local (; N -> N
          ; determines the gcd of n and m less than i
          (define (greatest-divisor-<= i)
            (cond
              [(= i 1) 1]
              [else
               (if (= (remainder n i) (remainder m i) 0)
                   i
                   (greatest-divisor-<= (- i 1)))])))
    (greatest-divisor-<= (min n m))))

;In your words: how does greatest-divisor-<= work?
; - base case is if the divisor is 1 return 1
; - otherwise check for the remainders of n and m against i and see if they're both equal to 0
; - if yes, return that number, if not recur on greatest-divisor-<= again with i less one

;Use the design recipe to find the right words.

;Why does the locally defined greatest-divisor-<= recur on (min n m)?
; - it finds the lowest of the two numbers because that is potentially the greatest divisor between the two