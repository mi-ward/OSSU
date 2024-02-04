;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_300) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 300.

;Here is a simple ISL+ program:

(define (p1 x y)  ; - - - - - -
  (+ (* x y)                   ;
     (+ (* 2 x)                ;
        (+ (* 2 y) 22))))      ;
                               ;
(define (p2 x)                 ;
  (+ (* 55 x) (+ x 11)))       ;
                               ;
(define (p3 x)                 ;
      ;v-----------------------;
  (+ (p1 x 0)                  ;
     (+ (p1 x 1) (p2 x))))     ;
        ;^---------------------;


;Draw arrows from p1’s x parameter to all
;its bound occurrences. Draw arrows from p1
;to all bound occurrences of p1. Check the
;results with DrRacket’s CHECK SYNTAX functionality.