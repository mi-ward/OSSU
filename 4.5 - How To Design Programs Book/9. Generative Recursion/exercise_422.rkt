;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_422) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 422.
; Define the function list->chunks.
; It consumes a list l of arbitrary data and a natural number n.
; The function’s result is a list of list chunks of size n. Each chunk represents a sub-sequence of items in l.

; Use list->chunks to define bundle via function composition.

; [List-of X] N -> [List-of [List-of X]
; Generate a list of list chunks of size N
(define (list->chunks l n)
  (cond
    [(empty? l) '()]
    [else
     (cons (take l n) (list->chunks (drop l n) n))]))

(define (take l n)
  (cond
    [(empty? l) '()]
    [(zero? n)  '()]
    [else
     (cons (first l) (take (rest l) (sub1 n)))]))

(define (drop l n)
  (cond
    [(empty? l) l]
    [(zero?  n) l]
    [else
     (drop (rest l) (sub1 n))]))

(check-expect (list->chunks (list "a" "b" "c") 3) (list (list "a" "b" "c")))
(check-expect (list->chunks (list "a" "b" "c") 1) (list (list "a") (list "b") (list "c")))
(check-expect (list->chunks (list "a" "b" "c" "d") 3) (list (list "a" "b" "c") (list "d")))

(define (bundle l n)
  (map implode (list->chunks l n)))

(check-expect (bundle (list "a" "b" "c" "d" "e" "f" "g" "h") 2)
              (list "ab" "cd" "ef" "gh"))
(check-expect (bundle (list "a" "b" "c" "d" "e" "f" "g" "h") 3)
              (list "abc" "def" "gh"))
(check-expect (bundle (list "a" "b") 3)
              (list "ab"))
(check-expect (bundle '() 3)
              '())
