;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_425) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 425.
; Articulate purpose statements for smallers and largers in figure 149. 

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
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n)
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))

; [List-of Numbers N] -> List-of Number
; ; retrieve all numbers in list larger than pivot
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))

(check-expect (quick-sort< (list 4 3 5 2 1)) (list 1 2 3 4 5))
            