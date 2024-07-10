;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_433) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 433.
; Develop a checked version of bundle that is guaranteed to terminate for all inputs.
; It may signal an error for those cases where the original version loops.

; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n
; idea take n items and drop n at a time
(define (bundle-checked s n)
  (cond
    [(empty? s) '()]
    [(<= n 0) (error "n can't be <= 0")]
    [else
     (cons (implode (take s n)) (bundle-checked (drop s n) n))]))
 
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

(check-expect (bundle-checked '() 0) '())
(check-error  (bundle-checked '("a") 0) "n can't be <= 0")
(check-expect (bundle-checked '("a") 1) (list "a"))
(check-expect (bundle-checked '("a") 2) (list "a"))
(check-expect (bundle-checked '("a" "b") 2) (list "ab"))
(check-expect (bundle-checked '("a" "b" "c") 2) (list "ab" "c"))