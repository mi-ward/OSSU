;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_322) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 322

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

;Draw the above two trees in the manner of figure 119.
;Then design contains-bt?, which determines whether a given number
;occurs in some given BT.

;     15
;    /  \
;  None 24
;       /\
;   None None

;   15
;   /\
;  87 None
;  /\
; N  N

;BST N -> Boolean
;determines if a given number occurs in a BT
(define (contains-bt? n bst)
  (cond [(no-info? bst) #false]
        [else
         (or (= (node-ssn bst) n)
             (contains-bt? n (node-left bst))
             (contains-bt? n (node-right bst)))]))

(check-expect (contains-bt? 15 N1) #true)
(check-expect (contains-bt? 15 N2) #true)
(check-expect (contains-bt? 24 N1) #true)
(check-expect (contains-bt? 87 N2) #true)
(check-expect (contains-bt? 87 N1) #false)
(check-expect (contains-bt? 87 NONE) #false)


