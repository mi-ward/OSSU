;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_327) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 327

;=======================================

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

;================================================

;Design the function create-bst-from-list.
;It consumes a list of numbers and names and produces a
;BST by repeatedly applying create-bst. Here is the signature:

; [List-of [List Number Symbol]] -> BST

;Use the complete function to create a BST from this sample input:
(define FIG119 '((99 o) (77 l) (24 i) (10 h) (95 g) (15 d) (89 c) (29 b) (63 a)))
;The result is tree A in figure 119, if you follow the structural design recipe.
;If you use an existing abstraction, you may still get this tree
;but you may also get an “inverted” one. Why?

;based on the direction of fold function used you'll get a different result

; [List-of [List Number Symbol]] -> BST
;consumes a list of numbers and names and produces a BST
(define (create-bst-from-list lons)
  (cond [(empty? lons) NONE]
        [else
         (create-bst (create-bst-from-list (rest lons))
                     (first (first lons))
                     (second (first lons)))]))
         

(check-expect (create-bst-from-list '((99 o))) (make-node 99 'o NONE NONE))
(create-bst-from-list FIG119)

(define (create-bst2 ns b)
  (cond [(no-info? b) (make-node (first ns) (second ns) NONE NONE)]
        [(> (first ns) (node-ssn b)) (if (no-info? (node-right b))
                                         (make-node (node-ssn b) (node-name b) (node-left b) (make-node (first ns) (second ns) NONE NONE))
                                         (make-node (node-ssn b) (node-name b) (node-left b) (create-bst2 ns (node-right b))))]
        [(< (first ns) (node-ssn b)) (if (no-info? (node-left b))
                                         (make-node (node-ssn b) (node-name b) (make-node (first ns) (second ns) NONE NONE) (node-right b))
                                         (make-node (node-ssn b) (node-name b) (create-bst2 ns (node-left b)) (node-right b)))]
        [else b]))

(check-expect (create-bst-from-list2 '((99 o))) (make-node 99 'o NONE NONE))

(define (create-bst-from-list2 lons)
  (foldr create-bst2 NONE lons))

(create-bst-from-list2 FIG119)

(check-expect (create-bst-from-list2 FIG119) (create-bst-from-list FIG119))