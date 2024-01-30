;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_293) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 293
; Develop found?, a specification for the find function:

; X [List-of X] -> [Maybe [List-of X] ]
; returns the first sublist of l that starts
; with x, #false otherwise
(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))

(check-expect (find 1 (list 2 3 1)) (list 1))
(check-expect (find 1 (list 1 2 3)) (list 1 2 3))
(check-expect (find 4 (list 1 2 3)) #false)

; List-of X -> Boolean
; if false not found otherwise it was found
(define (found? x lst)
  (lambda (l)
    (cond [(false? l) (not (member? x lst))]
          [(cons? l) (= x (first l))])))

(check-satisfied (find 2 '(1 2 3)) (found? 2 '(1 2 3)))
(check-satisfied (find 2 '(1 4 3)) (found? 2 '(1 4 3)))