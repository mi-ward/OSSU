;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_442) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 442.
; Add sort< and quick-sort< to the definitions area.
; Run tests on the functions to ensure that they work on basic examples.
; Also develop create-tests, a function that creates large test cases randomly. Then explore how fast each works on various lists.

(define (create-tests n r)
  (build-list n (lambda (x) (+ (- x x) (random r)))))

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct 
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers alon pivot))
                    (list pivot)
                    (quick-sort< (largers alon pivot))))]))
 
; [List-of Number] Number -> [List-of Number]
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))
 
; [List-of Number] Number -> [List-of Number]
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n)
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))

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

(check-expect (quick-sort< (list 3 2 1)) (list 1 2 3))
(check-expect (sort< (list 3 2 1)) (list 1 2 3))

;(define TEST1 (create-tests 10 1000))
;(define TEST2 (create-tests 100 1000))
;(define TEST3 (create-tests 1000 1000))
;(define TEST4 (create-tests 25 1000))
;(define TEST5 (create-tests 50 1000))
;(define TEST6 (create-tests 75 1000))
;(define TEST7 (build-list 100 (lambda (x) x)))
;(define TEST8 (reverse (build-list 100 (lambda (x) x))))
;(define TEST9 (build-list 50 (lambda (x) x)))
;(define TEST10 (reverse (build-list 50 (lambda (x) x))))
;(define TEST11 (build-list 75 (lambda (x) x)))
;(define TEST12 (reverse (build-list 75 (lambda (x) x))))


; (time (sort< TEST1))
; cpu time: 0 real time: 0 gc time: 0
; (time (quick-sort< TEST1))
; cpu time: 0 real time: 0 gc time: 0
; (time (sort< TEST2))
; cpu time: 1 real time: 1 gc time: 0
; (time (quick-sort< TEST2))
; cpu time: 0 real time: 0 gc time: 0
; (time (sort< TEST3))
; cpu time: 231 real time: 243 gc time: 19
; (time (quick-sort< TEST3))
; cpu time: 27 real time: 28 gc time: 0
; (time (sort< TEST4))
; cpu time: 0 real time: 0 gc time: 0
; (time (sort< TEST5))
; cpu time: 0 real time: 0 gc time: 0
; (time (sort< TEST6))
; cpu time: 1 real time: 1 gc time: 0
; (time (quick-sort< TEST4))
; cpu time: 0 real time: 0 gc time: 0
; (time (quick-sort< TEST5))
; cpu time: 0 real time: 0 gc time: 0
; (time (quick-sort< TEST6))

;(time (sort< TEST7))
;cpu time: 0 real time: 0 gc time: 0
;(time (sort< TEST8))
;cpu time: 7 real time: 7 gc time: 0
;(time (quick-sort< TEST7))
;cpu time: 9 real time: 9 gc time: 0
;(time (quick-sort< TEST8))
;cpu time: 6 real time: 7 gc time: 0

;(time (sort< TEST9))
;cpu time: 0 real time: 0 gc time: 0
;(time (sort< TEST10))
;cpu time: 0 real time: 0 gc time: 0
;(time (sort< TEST11))
;cpu time: 0 real time: 0 gc time: 0
;(time (sort< TEST12))
;cpu time: 2 real time: 2 gc time: 0
;
;(time (quick-sort< TEST9))
;cpu time: 3 real time: 3 gc time: 0
;(time (quick-sort< TEST10))
;cpu time: 1 real time: 1 gc time: 0
;(time (quick-sort< TEST11))
;cpu time: 3 real time: 3 gc time: 0
;(time (quick-sort< TEST12))
;cpu time: 3 real time: 3 gc time: 0


;Does the experiment confirm the claim that the plain sort< function often wins over quick-sort< for short lists and vice versa?
; - yes, specifically around less than 75 items

; Determine the cross-over point.
; Use it to build a clever-sort function that behaves like quick-sort< for large lists and like sort< for lists below this cross-over point. Compare with exercise 427.

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
(define (clever-sort< alon)
  (cond
    [(<= (length alon) 75) (sort< alon)]
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
            (append (clever-sort< (smallers alon pivot))
                    (filter (lambda (x) (= x pivot)) alon)
                    (clever-sort< (largers alon pivot))))]))

(define TEST12 (create-tests 1000 1000))
(time (sort< TEST12))
; cpu time: 233 real time: 245 gc time: 13
(time (quick-sort< TEST12))
; cpu time: 16 real time: 17 gc time: 0
(time (clever-sort< TEST12))
; cpu time: 23 real time: 24 gc time: 0