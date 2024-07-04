;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_429) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 429. Use filter to define smallers and largers. 

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
                  (append (quick-sort< (smallers alon pivot))
                          (list pivot)
                          (quick-sort< (largers alon pivot))))]))

; [List-of Numbers N] -> List-of Number
; retrieve all numbers in list smaller than pivot
(define (smallers lon pivot)
  (filter (lambda (x) (< x pivot)) lon))

; [List-of Numbers N] -> List-of Number
; ; retrieve all numbers in list larger than pivot
(define (largers lon pivot)
  (filter (lambda (x) (> x pivot)) lon))
            