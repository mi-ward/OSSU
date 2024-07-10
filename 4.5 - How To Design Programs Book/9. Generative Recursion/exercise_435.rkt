;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_435) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 435.
; When you worked on exercise 430 or exercise 428, you may have produced looping solutions.
; Similarly, exercise 434 actually reveals how brittle the termination argument is for quick-sort<.
; In all cases, the argument relies on the idea that smallers and largers produce lists that are maximally as long as the given list,
; and on our understanding that neither includes the given pivot in the result.

; Based on this explanation, modify the definition of quick-sort< so that both functions receive lists that are shorter than the given one.

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct 
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers (rest alon) pivot))
                    (list pivot)
                    (quick-sort< (largers (rest alon) pivot))))]))
 
; [List-of Number] Number -> [List-of Number]
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))

; [List-of Number] Number -> [List-of Number]
(define (smallers l n)
  (cond
    [(empty? l) '()]
    [else (if (<= (first l) n)
              (cons (first l) (smallers (rest l) n))
              (smallers (rest l) n))]))

(check-expect (quick-sort< (list 3 2 1)) (list 1 2 3))
(check-expect (quick-sort< (list 2 3 1)) (list 1 2 3))
(check-expect (quick-sort< (list 2 3 1 4 5 7 9 2 1 2)) (list 1 1 2 2 2 3 4 5 7 9))
(check-expect (quick-sort< (list 2 2 2 2 2 2 2)) (list 2 2 2 2 2 2 2))