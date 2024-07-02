;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_394) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 394.
; Design merge.
; The function consumes two lists of numbers, sorted in ascending order.
; It produces a single sorted list of numbers that contains all the numbers on both inputs lists.
; A number occurs in the output as many times as it occurs on the two input lists together.

; [List-of Number] [List-of Number -> [List-of Numbers]
; It produces a single sorted list of numbers that contains all the numbers on both inputs lists.
; A number occurs in the output as many times as it occurs on the two input lists together.

(define (merge lon1 lon2)
  (cond [(and (empty? lon1) (empty? lon2)) '()]
        [(and (cons? lon1) (empty? lon2)) lon1]
        [(and (empty? lon1) (cons? lon2)) lon2]
        [(= (first lon1) (first lon2)) (cons (first lon1) (cons (first lon2) (merge (rest lon1) (rest lon2))))]
        [(< (first lon1) (first lon2)) (cons (first lon1) (merge (rest lon1) lon2))]
        [(> (first lon1) (first lon2)) (cons (first lon2) (merge lon1 (rest lon2)))]))
        

(define LON1 '(0 1 3 5 7 7))
(define LON2 '(2 2 4 6 8 9))
(define LON3 '(0 1 3 4 6 9 9 9))
  

(check-expect (merge '() '()) '())
(check-expect (merge '(1 2 3) '()) '(1 2 3))
(check-expect (merge '() '(1 2 3)) '(1 2 3))
(check-expect (merge LON1 LON2) '(0 1 2 2 3 4 5 6 7 7 8 9))
(check-expect (merge LON1 LON3) '(0 0 1 1 3 3 4 5 6 7 7 9 9 9))