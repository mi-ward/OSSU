;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_428) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 428.
; If the input to quick-sort< contains the same number several times,
; the algorithm returns a list that is strictly shorter than the input.
; Why? -> because we're only looking for numbers lower and smaller than the pivot, not duplicates

; Fix the problem so that the output is as long as the input. Okay

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
                  (append (quick-sort< (smallers alon pivot))
                          (filter (lambda (x) (= pivot x)) alon)
                          (quick-sort< (largers alon pivot))))]))

; [List-of Numbers N] -> List-of Number
; retrieve all numbers in list smaller than pivot
(define (smallers lon pivot)
  (filter (lambda (x) (< x pivot)) lon))

; [List-of Numbers N] -> List-of Number
; ; retrieve all numbers in list larger than pivot
(define (largers lon pivot)
  (filter (lambda (x) (> x pivot)) lon))


(check-expect (quick-sort< (list 1 1 2 1 1)) (list 1 1 1 1 2))
(check-expect (quick-sort< (list 3 3 2 1 1)) (list 1 1 2 3 3))