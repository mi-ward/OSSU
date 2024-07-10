;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_454) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 454

;Design create-matrix.
; The function consumes a number n and a list of n2 numbers.
; It produces an image matrix, for example:

(define (create-matrix n lst)
  (cond
    [(empty? lst) '()]
    [else
      (cons (take n lst) (create-matrix n (remaining n lst)))]))

(define (take n lst)
  (cond
    [(zero? n) '()]
    [else (cons (first lst) (take (sub1 n) (rest lst)))]))

(define (remaining n lst)
  (cond
    [(zero? n) lst]
    [else (remaining (sub1 n) (rest lst))]))



(check-expect
 (create-matrix 2 (list 1 2 3 4))
 (list (list 1 2)
       (list 3 4)))

(check-expect
 (create-matrix 2 (list 1 2 3 4 5 6))
 (list (list 1 2)
       (list 3 4)
       (list 5 6)))

(check-expect
 (create-matrix 3 (list 1 2 3 4 5 6))
 (list (list 1 2 3)
       (list 4 5 6)))