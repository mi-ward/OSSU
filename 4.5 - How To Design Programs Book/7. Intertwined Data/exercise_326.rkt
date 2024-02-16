;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_326) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 326

;Design the function create-bst.
;It consumes a BST B, a number N, and a symbol S.
;It produces a BST that is just like B and that in
;place of one NONE subtree contains the node structure
;(make-node N S NONE NONE)

;Once the design is completed, use the function on tree A from figure 119.

(define-struct no-info [])
(define NONE (make-no-info))
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

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

;BST Number Symbol -> BST
;produces a BST with a new node for number symbol in place                        
(define (create-bst b n s)
  (cond [(no-info? b) (make-node n s NONE NONE)]
        [(> n (node-ssn b)) (if (no-info? (node-right b))
                                (make-node (node-ssn b) (node-name b) (node-left b) (make-node n s NONE NONE))
                                (make-node (node-ssn b) (node-name b) (node-left b) (create-bst (node-right b) n s)))]
        [(< n (node-ssn b)) (if (no-info? (node-left b))
                                (make-node (node-ssn b) (node-name b) (make-node n s NONE NONE) (node-right b))
                                (make-node (node-ssn b) (node-name b) (create-bst (node-left b) n s) (node-right b)))]
        [else b]))
        

(check-expect (create-bst NONE 1 "1") (make-node 1 "1" NONE NONE))
(check-expect (create-bst BSTA 99 "99") BSTA)
(check-expect (create-bst BSTA 1 "1") (make-node 63 "63"
                                                (make-node 29 "29"
                                                           (make-node 15 "15"
                                                                      (make-node 10 "10" (make-node 1 "1" NONE NONE) NONE)
                                                                      (make-node 24 "24" NONE NONE))
                                                           NONE)
                                                (make-node 89 "89"
                                                           (make-node 77 "77" NONE NONE)
                                                           (make-node 95 "95" NONE
                                                                      (make-node 99 "99" NONE NONE)))))
(check-expect (create-bst BSTA 100 "100") (make-node 63 "63"
                                                (make-node 29 "29"
                                                           (make-node 15 "15"
                                                                      (make-node 10 "10" NONE NONE)
                                                                      (make-node 24 "24" NONE NONE))
                                                           NONE)
                                                (make-node 89 "89"
                                                           (make-node 77 "77" NONE NONE)
                                                           (make-node 95 "95" NONE
                                                                      (make-node 99 "99" NONE (make-node 100 "100" NONE NONE))))))

(check-expect (create-bst BSTA 94 "94") (make-node 63 "63"
                                                (make-node 29 "29"
                                                           (make-node 15 "15"
                                                                      (make-node 10 "10" NONE NONE)
                                                                      (make-node 24 "24" NONE NONE))
                                                           NONE)
                                                (make-node 89 "89"
                                                           (make-node 77 "77" NONE NONE)
                                                           (make-node 95 "95"
                                                                      (make-node 94 "94" NONE NONE)
                                                                      (make-node 99 "99" NONE NONE)))))
