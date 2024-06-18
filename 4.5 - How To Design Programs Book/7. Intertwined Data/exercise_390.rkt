;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_390) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; N is one of:
; - 0
; (add1 N)

; [List-of Symbol] N -> Symbol
; extracts the nth symbol from l;
; signals an error if there is such symbol
(define (list-pick l n)
  (cond
    [(and (= n 0) (empty? l)) (error 'list-pick "list too short")]
    [(and (> n 0) (empty? l)) (error 'list-pick "list too short")]
    [(and (= n 0) (cons?  l)) (first l)]
    [(and (> n 0) (cons?  l)) (list-pick (rest l) (sub1 n))]))

(check-expect (list-pick '(a b c) 2) 'c)
(check-error (list-pick '() 0) "list-pick: list too short")
(check-expect (list-pick (cons 'a '()) 0) 'a)
(check-error (list-pick '() 3) "list-pick: list too short")

; Exercise 390
; Design the function tree-pick.
; The function consumes a tree of symbols and a list of directions

(define-struct branch [left right])

; A TOS is one of:
; - Symbol
; - (make-branch TOS TOS)

; A Direction is one of:
; - 'left
; - 'right

; A list of Directions is also called a path.

; Clearly a Direction tells the function whether to choose the
; left or the right branch in a nonsymbolic tree.

; What is the result of the tree-pick function? A symbol

; Don’t forget to formulate a full signature.
; The function signals an error when given a symbol and a non-empty path.


; TOS [List-of Directions] -> Symbol
; Navigates through the list of directions to find a symbol

(define LOD1 (list "left" "left" "left"))
(define LOD2 (list "right" "right" "right"))
(define LOD3 (list "right" "left"))
(define LOD4 (list "left" "right"))
(define LOD5 (list "right" "left" "right"))

(define TOS1 (make-branch
              (make-branch
               (make-branch 'a 'b)
               (make-branch 'c 'd))
              (make-branch
               'e
               (make-branch 'f 'g))))

(define (tree-pick TOS LOD)
  (cond
    [(and (empty? LOD) (symbol? TOS)) TOS]
    [(and (empty? LOD) (false? (symbol? TOS))) (error "error")]
    [(and (false? (empty? LOD)) (symbol? TOS)) (error "error")]
    [(string=? "left" (first LOD)) (tree-pick (branch-left TOS) (rest LOD))]
    [else
     (tree-pick (branch-right TOS) (rest LOD))]))

(check-expect (tree-pick TOS1 LOD1) 'a)
(check-expect (tree-pick TOS1 LOD2) 'g)
(check-expect (tree-pick TOS1 LOD3) 'e)
(check-error (tree-pick TOS1 LOD4) "error")
(check-error (tree-pick TOS1 LOD5) "error")



