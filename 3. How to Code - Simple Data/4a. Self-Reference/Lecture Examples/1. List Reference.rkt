;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |1. List Reference|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

empty

(define L1 (cons "Flames" empty)   )              ; a list of 1 element
(define L2 (cons "Leafs" (cons "Flames" empty)))  ; a list of 2 elements

;(cons (string-append "C" "anucks") empty)

(define L4 (cons 10 (cons 9 (cons 10 empty))))   ;a list of 3 elements

(define L3 (cons (square 10 "solid" "blue")
      (cons (triangle 20 "solid" "green")
      empty)))

(first L1)
(first L2)
(first L3)

(rest L1)
(rest L2)
(rest L3)

;(... L2)   ; how do I get the second element of L2

(first (rest L2))

(first (rest (rest L4)))

(empty? empty)

(empty? L1)