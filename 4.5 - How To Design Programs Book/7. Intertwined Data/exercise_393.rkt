;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_393) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 393.
;Figure 62 presents two data definitions for finite sets.
;Design the union function for the representation of finite sets of your choice.
;It consumes two sets and produces one that contains the elements of both.

;Design intersect for the same set representation. It consumes two sets and produces the set of exactly those elements that occur in both.

; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)
; 
; Son is used when it 
; applies to Son.L and Son.R
  

; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s


; Set.L Set.L -> Set.L
; consumes two sets and produces a set with all elements from both

(define SETA (list 1 2 3))
(define SETB (list 4 5 6))
(define SETC (list 1 7 8))

(define (union set1 set2)
  (append set1 set2))


         

(check-expect (union '() '()) '())
(check-expect (union '() SETB) SETB)
(check-expect (union SETA SETB) '(1 2 3 4 5 6))
(check-expect (union SETA SETC) '(1 2 3 1 7 8))

(define (intersect set1 set2)
  (cond [(or (empty? set1) (empty? set2)) '()]
        [(member? (first set1) set2) (cons (first set1) (intersect (rest set1) set2))]
        [else (intersect (rest set1) set2)]))

(check-expect (intersect '() '()) '())
(check-expect (intersect '() SETB) '())
(check-expect (intersect SETA SETB) '())
(check-expect (intersect SETA SETC) '(1))
