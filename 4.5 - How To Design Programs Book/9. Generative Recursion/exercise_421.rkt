;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_421) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(check-expect (bundle (list "a" "b" "c" "d" "e" "f" "g" "h") 2)
              (list "ab" "cd" "ef" "gh"))
(check-expect (bundle (list "a" "b" "c" "d" "e" "f" "g" "h") 3)
              (list "abc" "def" "gh"))
(check-expect (bundle (list "a" "b") 3)
              (list "ab"))
(check-expect (bundle '() 3)
              '())

;Exercise 421.
; Is (bundle '("a" "b" "c") 0) a proper use of the bundle function? No
; What does it produce? (list "" "a" "b" "c")
; Why? The function Take is expecting to remove something from the list,
; as there's nothing to remove it returns empty which is then consed to the beginning
; of the list.