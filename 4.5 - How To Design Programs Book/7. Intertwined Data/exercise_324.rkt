;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_324) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;====
;Exercise 324
;Design the function inorder.
;It consumes a binary tree and produces the sequence of all
;the ssn numbers in the tree as they show up from left to right
;when looking at a tree drawing.

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

;Hint Use append, which concatenates lists like thus:
;(append (list 1 2 3) (list 4) (list 5 6 7))
;==
;(list 1 2 3 4 5 6 7)

;What does inorder produce for a binary search tree?

; BT -> [List-of Number]
; produce the sequence of all ssn numbers in the tree from left to right
(define (inorder bt)
  (cond [(no-info? bt) '()]
  [else
   (append (inorder (node-left bt))
           (cons (node-ssn bt) '())
           (inorder (node-right bt)))]))
 

(check-expect (inorder N1) (list 15 24))
(check-expect (inorder N2) (list 87 15))

;What does inorder produce for a binary search tree?
; -- It produces the ssn in a sorted list

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

(check-expect (inorder BSTA) (sort (inorder BSTA) <))

;(inorder BSTA)
;==
;(list 10 15 24 29 63 77 89 95 99)
