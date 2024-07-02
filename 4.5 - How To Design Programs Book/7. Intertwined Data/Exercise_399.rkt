;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Exercise 399|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 399.
; Louise, Jane, Laura, Dana, and Mary decide to run a lottery that assigns one gift recipient to each of them.
; Since Jane is a developer, they ask her to write a program that performs this task in an impartial manner.
; Of course, the program must not assign any of the sisters to herself.

(define NAMES (list "Louise" "Jane" "Laura" "Dana" "Mary"))

; Here is the core of Jane’s program:
; [List-of String] -> [List-of String] 
; picks a random non-identity arrangement of names

(define (gift-pick names)
  (random-pick
   (non-same names (arrangements names))))
 
; [List-of String] -> [List-of [List-of String]]
; returns all possible permutations of names
; see exercise 213
(define (arrangements lst)
  (cond
    [(empty? lst) (list '())]
    [else
     (insert-everywhere/all-lists (first lst) (arrangements (rest lst)))]))

(check-expect (arrangements '()) (list '()))
(check-expect (arrangements (list "a")) (list (list "a")))
(check-expect (arrangements (list "a" "b")) (list (list "a" "b")
                                                  (list "b" "a")))
(check-expect (arrangements (list "a" "b" "c")) (list
                                                 (list "a" "b" "c")
                                                 (list "b" "a" "c")
                                                 (list "b" "c" "a")
                                                 (list "a" "c" "b")
                                                 (list "c" "a" "b")
                                                 (list "c" "b" "a")))

;String List-of String -> List-of List-of String
; returns all possible permutations of names
(define (insert-everywhere/all-lists item lst)
  (cond
    [(empty? lst) '()]
    [else
     (append (insert-everywhere/one-list item (first lst))
             (insert-everywhere/all-lists item (rest lst)))]))

(check-expect (insert-everywhere/all-lists "a" (list '())) (list (list "a")))
(check-expect (insert-everywhere/all-lists "a" (list (list "b"))) (list (list "a" "b")
                                                                        (list "b" "a")))
(check-expect (insert-everywhere/all-lists "a" (list (list "b" "c")
                                                     (list "c" "b"))) (list
                                                                       (list "a" "b" "c")
                                                                       (list "b" "a" "c")
                                                                       (list "b" "c" "a")
                                                                       (list "a" "c" "b")
                                                                       (list "c" "a" "b")
                                                                       (list "c" "b" "a")))

(define (insert-everywhere/one-list item lst)
  (cond
    [(empty? lst) (cons (cons item '()) '())]
    [else
     (cons (cons item lst)
           (add-to-front (first lst)
                         (insert-everywhere/one-list item (rest lst))))]))
     
(check-expect (insert-everywhere/one-list "a" '()) (list (list "a")))
(check-expect (insert-everywhere/one-list "b" (list "c")) (list (list "b" "c")
                                                                (list "c" "b")))
(check-expect (add-to-front "d" (list (list "e" "r") (list "r" "e")))
              (list (list "d" "e" "r") (list "d" "r" "e")))


(define (add-to-front l w)
  (cond
    [(empty? w) '()]
    [else (cons (cons l (first w))
                (add-to-front l (rest w)))]))
                   
; It consumes a list of names and randomly picks one of those permutations that do not agree with the original list at any place.

; Your task is to design two auxiliary functions:
; [NEList-of X] -> X 
; returns a random item from the list 
(define (random-pick l)
  (list-ref l (random (length l))))
 
; [List-of String] [List-of [List-of String]] 
; -> 
; [List-of [List-of String]]
; produces the list of those lists in ll that do 
; not agree with names at any place 
(define (non-same names ll)
  (filter (lambda (lst) (not-agree? names lst)) ll))

(define (not-agree? names lst)
  (cond
    [(and (empty? lst) (empty? names)) #true]
    ;[(and (empty? lst) (cons? names))  #true]
    ;[(and (cons?  lst) (empty? names)) #true]
    [(and (cons? lst) (cons? names))
     (and (false? (string=? (first lst) (first names))) (not-agree? (rest lst) (rest names)))]))

(check-expect (non-same (list "a" "b" "c") (list
                                            (list "a" "b" "c")
                                            (list "b" "a" "c")
                                            (list "b" "c" "a")
                                            (list "a" "c" "b")
                                            (list "c" "a" "b")
                                            (list "c" "b" "a")))
              (list
               (list "b" "c" "a")
               (list "c" "a" "b")))
               
;Recall that random picks a random number; see exercise 99.