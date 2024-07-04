;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_430) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 430.
; Develop a variant of quick-sort< that uses only one comparison function, say, <.
; Its partitioning step divides the given list alon into a list that contains the items of alon smaller than the pivot and another one with those that are not smaller.
; Use local to package up the program as a single function. Abstract this function so that it consumes a list and a comparison function.

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
(define (quick-sort-fn fn alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
    [else (local ((define pivot (first alon))
                  (define partition-a (first (partition fn alon pivot)))
                  (define partition-b (second (partition fn alon pivot))))
                  (append (quick-sort-fn fn partition-a)
                          (list pivot)
                          (quick-sort-fn fn partition-b)))]))

(check-expect (quick-sort-fn > (list 5 2 4 1 3)) (list 5 4 3 2 1))
(check-expect (quick-sort-fn < (list 5 2 4 1 3)) (list 1 2 3 4 5))

; [List-of Numbers N] -> List-of Number
; retrieve all numbers in list smaller than pivot
(define (partition fn lon pivot)
  (cond
    [(empty? lon) '()]
    [else
     (list (filter (lambda (x) (fn x pivot)) lon)
           (filter (lambda (x) (and (false? (= x pivot)) (false? (fn x pivot)))) lon))]))

(check-expect (partition < (list 1 2 3 4 5) 4) (list (list 1 2 3) (list 5)))