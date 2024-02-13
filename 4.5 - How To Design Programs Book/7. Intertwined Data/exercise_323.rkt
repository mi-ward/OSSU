;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_323) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 323

(define-struct no-info [])
(define NONE (make-no-info))
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

(define N1(make-node 15 'd
                     NONE
                     (make-node 24 'i
                                NONE
                                NONE)))

(define N2 (make-node 15 'd
                      (make-node 87 'h
                                 NONE
                                 NONE)
                      NONE))

;Design search-bt. The function consumes a number n and a BT.
;If the tree contains a node structure whose ssn field is n,
;the function produces the value of the name field in that node.
;Otherwise, the function produces #false.

;Hint Consider using contains-bt? to check the entire tree first or boolean?
;to check the result of the natural recursion at each stage. 

;Number BT -> String or #false
;if the tree contains the number, produce the name, otherwise false
(define (search-bt n bt)
  (cond [(no-info? bt) #false]
        [(= n (node-ssn bt)) (node-name bt)]
        [(not (boolean? (search-bt n (node-left bt)))) (search-bt n (node-left bt))]
        [(not (boolean? (search-bt n (node-right bt)))) (search-bt n (node-right bt))]
        [else #false]))

(check-expect (search-bt 1 N1) #false)
(check-expect (search-bt 100 N2) #false)
(check-expect (search-bt 15 N1) 'd)
(check-expect (search-bt 15 N2) 'd)
(check-expect (search-bt 24 N1) 'i)
(check-expect (search-bt 87 N2) 'h)
  
