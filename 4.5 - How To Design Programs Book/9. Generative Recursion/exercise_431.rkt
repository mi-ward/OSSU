;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_431) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 431.
; Answer the four key questions for the bundle problem and the first three questions for the quick-sort< problem.

; Bundle
; What is a trivially solvable problem?
; - Is the list empty?
; - implode n number of a list (list less than or equal to 3)

; How are trivial problems solved?
; - check for the value or use the built-in implode function

; How does the algorithm generate new problems that are more easily solvable than the original one? Is there one new problem that we generate or are there several?
; - takes more than one (n) off the list and adds it to the list
; - removes that group from the start of the list
; - 2 new problems that we generate, (take and drop)

; Is the solution of the given problem the same as the solution of (one of) the new problems?
; - yes

; Or, do we need to combine the solutions to create a solution for the original problem?
; - no, the problem is the same we just generate simpler versions to act on, similar to using first and rest
; And, if so, do we need anything from the original problem data? n/a


; How many instances of generate-problem are needed?
; 2 for bundle

; ====================================================================

;Quick sort
; What is a trivially solvable problem?
; - if the list is empty return empty if the rest of the list is empty return the list

; How are trivial problems solved?
; - check the value and return the appropriate value

; How does the algorithm generate new problems that are more easily solvable than the original one?
; - it defines the pivot, and acts on the rest of the list

; Is there one new problem that we generate or are there several?
; - several, (smallers, largers)

; Is the solution of the given problem the same as the solution of (one of) the new problems?
; - no, the new problems are concerned with simply filtering down the list, the original problem wants them sorted

; Or, do we need to combine the solutions to create a solution for the original problem?
; yes we need to combine the definition of the single items, the filtering and the appending

; And, if so, do we need anything from the original problem data?
; - yes, we need to define the how we'll append everything together

; How many instances of generate-problem are needed?
; 2


(define (generative-recursive-fun problem)
  (cond
    [(trivially-solvable? problem)
     (determine-solution problem)]
    [else
     (combine-solutions
       ... problem ...
       (generative-recursive-fun
         (generate-problem-1 problem))
       ...
       (generative-recursive-fun
         (generate-problem-n problem)))]))

; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n
; idea take n items and drop n at a time
(define (bundle s n)
  (cond
    [(empty? s) '()]
    [else
     (cons (implode (take s n)) (bundle (drop s n) n))]))
 
; [List-of X] N -> [List-of X]
; keeps the first n items from l if possible or everything
(define (take l n)
  (cond
    [(zero? n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))
 
; [List-of X] N -> [List-of X]
; removes the first n items from l if possible or everything
(define (drop l n)
  (cond
    [(zero? n) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))


(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
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




; 

; How are trivial problems solved?

; How does the algorithm generate new problems that are more easily solvable than the original one? Is there one new problem that we generate or are there several?

; Is the solution of the given problem the same as the solution of (one of) the new problems?
; Or, do we need to combine the solutions to create a solution for the original problem?
; And, if so, do we need anything from the original problem data?