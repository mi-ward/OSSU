;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_299_incomplete) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 299
;Design a data representation for finite and infinite sets
;so that you can represent the sets of all odd numbers,
;all even numbers, all numbers divisible by 10, and so on.

;Design the functions add-element, which adds an element to a set;
;union, which combines the elements of two sets; and intersect,
;which collects all elements common to two sets.

;Hint: Mathematicians deal with sets as functions that consume a
;potential element ed and produce #true only if ed belongs to the set.

; A set is a function:
; [N -> Boolean]
; if set is a number, produce true, else false

;Number Set -> Boolean
(define (in-set? ed s)
  (s ed))

;[Number -> Boolean] -> Set
; creates an infinite set defined by i
(define (infinite-set i)
  (lambda (p) (i p)))

;[Number -> Boolean] ->
; creates a finite set defined by i
(define (finite-set l)
  (infinite-set (lambda (x) (member? x l))))

(check-expect (in-set? 10 (infinite-set even?)) #true)
(check-expect (in-set? 11 (infinite-set even?)) #false)
(check-expect (in-set? 10 (infinite-set odd?)) #false)
(check-expect (in-set? 11 (infinite-set odd?)) #true)
(check-expect (in-set? 10 (infinite-set (lambda (x) (= 0 (modulo x 10))))) #true)
(check-expect (in-set? 11 (infinite-set (lambda (x) (= 0 (modulo x 10))))) #false)

(check-expect (in-set? 10 (finite-set (list 10))) #true)
(check-expect (in-set? 11 (finite-set (list 10))) #false)


;add-element
; Number Set -> Set
(define (add-element n s)
  (lambda (x) (or (in-set? x s) (= n x) )))

(check-expect (in-set? 10 (add-element 10 (infinite-set even?))) #true)
(check-expect (in-set? 10 (add-element 10 (infinite-set odd?))) #true)
(check-expect (in-set? 10 (add-element 10 (finite-set (list 11)))) #true)
(check-expect (in-set? 9 (add-element 10 (finite-set (list 11)))) #false)
(check-expect (in-set? 9 (add-element 10 (infinite-set even?))) #false)


;union
;Set Set -> Set
(define (union s1 s2)
  (lambda (x) (or (in-set? x s1) (in-set? x s2))))

(check-expect (in-set? 10 (union (infinite-set even?)
                                 (finite-set (list 9)))) #true)
(check-expect (in-set? 11 (union (infinite-set even?)
                                 (finite-set (list 9)))) #false)
(check-expect (in-set? 11 (union (infinite-set even?)
                                 (finite-set (list 11)))) #true)
(check-expect (in-set? 11 (union (finite-set (list 11))
                                 (finite-set (list 10)))) #true)

;intersect
;Set Set -> Set
(define (intersect s1 s2)
  (lambda (x) (and (in-set? x s1) (in-set? x s2))))

(check-expect (in-set? 10 (intersect (infinite-set even?)
                                     (finite-set (list 10)))) #true)
(check-expect (in-set? 10 (intersect (infinite-set odd?)
                                     (finite-set (list 10)))) #false)
                                                              