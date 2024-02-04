;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_306) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)
;Exercise 306
; Use loops to define a function that

;1. creates the list (list 0 ... (- n 1)) for any natural number n;

(define (lst n)
  (for/list ([i n]) i))

(check-expect (lst 9) (list 0 1 2 3 4 5 6 7 8))

;2. creates the list (list 1 ... n) for any natural number n;
(define (lst+1 n)
  (for/list ([i n]) (add1 i)))

(check-expect (lst+1 9) (list 1 2 3 4 5 6 7 8 9))

;3. creates the list (list 1 1/2 ...1/n) for any natural number n;
(define (lst1/2 n)
  (for/list ([i n]) (/ 1 (add1 i))))

(check-expect (lst1/2 9) (list 1 1/2 1/3 1/4 1/5 1/6 1/7 1/8 1/9))

;4. creates the list of the first n even numbers
(define (evens n)
  (for/list ([i n]) (* 2 (add1 i))))

(check-expect (evens 10) (list 2 4 6 8 10 12 14 16 18 20))

;5. creates a diagonal square of 0s and 1s
(define (diagonal n)
  (for/list ([i n]) (build-list n (lambda (x) (if (= i x) 1 0)))))

(check-expect (diagonal 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))

;Finally, use loops to define tabulate from exercise 250.
(define (tabulate fn lst)
  (for/list ([i lst]) (fn i)))

(check-expect (tabulate sqr (list 1 2 3 4 5)) (list 1 4 9 16 25))
(check-expect (tabulate sqr 5) (list 0 1 4 9 16))
(check-within (tabulate tan (list 1 2 3)) (list 1.557407 -2.185039 -0.142546) .000001)
(check-within (tabulate tan 3) (list 0 1.557407 -2.185039) .000001)






