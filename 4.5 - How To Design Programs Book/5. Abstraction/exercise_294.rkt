;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_294) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 294

;Develop is-index?, a specification for index:
; X [List-of X] -> [Maybe N]
; determine the index of the first occurrence
; of x in lst, #false otherwise

(define (index x lst)
  (cond
    [(empty? lst) #false]
    [else (if (equal? (first lst) x)
              0
              (local ((define i (index x (rest lst))))
                (if (boolean? i) i (+ i 1))))]))

(check-expect (index 5 (list 1 2 3 4 5)) 4)
(check-expect (index 1 (list 1 2 3 4 5)) 0)
(check-expect (index 0 (list 1 2 3 4 5)) #false)

; X [List-of X] -> Boolean
; determine if X is in list-of X
; and is the first occurrence
(define (index-of? x lst)
  (lambda (l)
    (cond [(false? l) (not (member? x lst))]
          [(number? l) (= x (list-ref lst l))]))) 
          
(check-satisfied (index 0 (list 1 2 3 4 5)) (index-of? 0 (list 1 2 3 4 5)))
(check-satisfied (index 1 (list 1 2 3 4 5)) (index-of? 1 (list 1 2 3 4 5)))
(check-satisfied (index 5 (list 1 2 3 4 5)) (index-of? 5 (list 1 2 3 4 5)))



;Use is-index? to formulate a check-satisfied test for index.