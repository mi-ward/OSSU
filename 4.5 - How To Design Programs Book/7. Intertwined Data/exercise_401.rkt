;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |exercise 401|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 401.
; Design sexp=?, a function that determines whether two S-expressions are equal.
; For convenience, here is the data definition in condensed form:

; An S-expr (S-expression) is one of: 
; – Atom
; – [List-of S-expr]
; 
; An Atom is one of: 
; – Number
; – String
; – Symbol 

; Whenever you use check-expect, it uses a function like sexp=? to check whether the two arbitrary values are equal.
; If not, the check fails and check-expect reports it as such.

(define (sexp=? a b)
  (cond
    [(and (string? a) (string? b)) (string=? a b)]
    [(and (number? a) (number? b)) (= a b)]
    [(and (symbol? a) (symbol? b)) (symbol=? a b)]
    [(and (empty? a)  (empty? b))  #true]
    [(and (cons? a)  (empty? b))   #false]
    [(and (empty? a)  (cons? b))   #false]
    [(and (cons? a)  (cons? b))
     (and (sexp=? (first a) (first b)) (sexp=? (rest a) (rest b)))]))
     


(check-expect (sexp=? (list 'a) (list 'a)) #true)
(check-expect (sexp=? (list 'a) '()) #false)
(check-expect (sexp=? '() (list 'a)) #false)
(check-expect (sexp=? 'a 'a) #true)
(check-expect (sexp=? 1 1) #true)
(check-expect (sexp=? "a" "a") #true)
(check-expect (sexp=? (list 'a 'b ) (list 'b)) #false)
(check-expect (sexp=? (list 'a (list 'b)) (list 'b)) #false)
(check-expect (sexp=? (list 'a (list 'b)) (list 'b 'a 'c 'd)) #false)
(check-expect (sexp=? (list 'a ) (list 'b)) #false)
  