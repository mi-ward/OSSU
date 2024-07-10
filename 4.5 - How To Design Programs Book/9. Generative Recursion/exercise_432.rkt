;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_432) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 432.
; Exercise 219 introduces the function food-create,
; which consumes a Posn and produces a randomly chosen Posn that is guaranteed to be distinct from the given one.
; First reformulate the two functions as a single definition, using local;
; then justify the design of food-create

; 1. What is a trivially solvable problem?
; - create a new posn

; 2. How are trivial problems solved?
; - create a posn with a random number for x and y

; 3. How does the algorithm generate new problems that are more easily solvable than the original one?
;    Is there one new problem that we generate or are there several?
; - 1 new problem, check the ensure the new value is different from the existing

; Is the solution of the given problem the same as the solution of (one of) the new problems? No
; Or, do we need to combine the solutions to create a solution for the original problem? Yes
; And, if so, do we need anything from the original problem data? Yes we need the x and y of the posn


(define MAX 2)
; Posn -> Posn
(define (food-create p)
  (local ((define (food-check-create p candidate)
          (if (equal? p candidate) (food-create p) candidate)))
  (food-check-create
     p (make-posn (random MAX) (random MAX)))))
 
; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)



