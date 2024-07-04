;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_427) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 427.
; While quick-sort< quickly reduces the size of the problem in many cases,
; it is inappropriately slow for small problems.
; Hence people use quick-sort< to reduce the size of the problem and switch to a different sort function when the list is small enough.

; Develop a version of quick-sort< that uses sort< (an appropriately adapted variant of sort> from Auxiliary Functions that Recur) if the length of the input is below some threshold.

; [List-of Number] -> [List-of Number]
; sorts the list of numbers
(define (sort< lon)
  (cond
    [(empty? lon) '()]
    [else (insert (first lon) (sort< (rest lon)))]))

(define (insert n lon)
  (cond
    [(empty? lon) (cons n '())]
    [else (if (<= n (first lon))
              (cons n lon)
              (cons (first lon) (insert n (rest lon))))]))


(check-expect (sort< (list 4 3 2 1)) (list 1 2 3 4))
(check-expect (sort< (list 1 1 2 1 1)) (list 1 1 1 1 2))

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
(define (quick-sort< alon)
  (cond
    [(< (length alon) 5) (sort< alon)]
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers alon pivot))
                    (filter (lambda (x) (= x pivot)) alon)
                    (quick-sort< (largers alon pivot))))]))

; [List-of Numbers N] -> List-of Number
; retrieve all numbers in list smaller than pivot
(define (smallers lon pivot)
  (filter (lambda (x) (< x pivot)) lon))

; [List-of Numbers N] -> List-of Number
; ; retrieve all numbers in list larger than pivot
(define (largers lon pivot)
  (filter (lambda (x) (> x pivot)) lon))

(check-expect (quick-sort< (list 1 1 1 1 2 1 9 10 1 1 4 1)) (list 1 1 1 1 1 1 1 1 2 4 9 10))
(check-expect (quick-sort< (list 1 1 1 1 2 1 1 1 4 1)) (list 1 1 1 1 1 1 1 1 2 4))
(check-expect (quick-sort< (list 1 1 1 2 1 1 1 4 1))   (list 1 1 1 1 1 1 1 2 4))

