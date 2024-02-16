;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_325) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 325

;=======================================

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

;=======================================

;Design search-bst.
;The function consumes a number n and a BST.
;If the tree contains a node whose ssn field is n,
;the function produces the value of the name field in that node.
;Otherwise, the function produces NONE. The function organization
;must exploit the BST invariant so that the function performs as
;few comparisons as necessary.

;See exercise 189 for searching in sorted lists. Compare!

(define BSTA (make-node 63 "63"
                        (make-node 29 "29"
                                   (make-node 15 "15"
                                              (make-node 10 "10" NONE NONE)
                                              (make-node 24 "24" NONE NONE))
                                   NONE)
                        (make-node 89 "89"
                                   (make-node 77 "77" NONE NONE)
                                   (make-node 95 "95" NONE
                                              (make-node 99 "99" NONE NONE)))))

;Number BST -> String or NONE
;produce the value for n in the name field otherwise produce NONE
(define (search-bst n bst)
  (cond [(no-info? bst) NONE]
        [(= n (node-ssn bst)) (node-name bst)]
        [(> n (node-ssn bst)) (search-bst n (node-right bst))]
        [(< n (node-ssn bst)) (search-bst n (node-left bst))]))

(check-expect (search-bst 62 BSTA) NONE)
(check-expect (search-bst 63 BSTA) "63")
(check-expect (search-bst 99 BSTA) "99")
(check-expect (search-bst 24 BSTA) "24")
(check-expect (search-bst 1 BSTA) NONE)
(check-expect (search-bst 100 BSTA) NONE)

  
