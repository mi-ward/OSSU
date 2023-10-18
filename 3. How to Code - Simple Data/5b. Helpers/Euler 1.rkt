;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Euler 1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Natural -> Natural
;; Find sum of all numbers that are multiples of 3 and 5
;(define mult3or5 0) 0)  ; stub

(check-expect (mult3or5 9) 23)
(check-expect (mult3or5 2) 0)

(define (mult3or5 n)
  (cond [(zero? n) 0]
        [else
         (if (or (= (modulo n 3) 0) (= (modulo n 5) 0))
             (+ n (mult3or5 (sub1 n)))
             (mult3or5 (sub1 n)))]))

(mult3or5 999)