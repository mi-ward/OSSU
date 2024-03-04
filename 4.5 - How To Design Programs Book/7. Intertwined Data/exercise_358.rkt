;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_358) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 358

;Provide a structure type and a data definition for function definitions.
;Recall that such a definition has three essential attributes:
; 1. the function’s name, which is represented with a symbol
; 2. the function’s parameter, which is also a name; and
; 3. the function’s body, which is a variable expression.

(define-struct fd [name arg body])
; A function defintion is a structure: (make-fd Symbol Symbol BSL-var-expr)

(define WRONG "error")

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

(define-struct add [left right])
;An add is a structure
; - (make-add BSL-var-expr BSL-var-expr)

(define-struct mul [left right])
;An mul is a structure
; - (make-mul BSL-var-expr BSL-var-expr)

(define-struct fa [name arg])

;We use BSL-fun-def to refer to this class of data.
;Use your data definition to represent these BSL function definitions:
; 1.(define (f x) (+ 3 x))
(define BFD1 (make-fd 'f 'x (make-add 3 'x)))
; 2. (define (g y) (f (* 2 y)))
(define BFD2 (make-fd 'g 'y '(make-fa 'f (make-mul 2 'y))))
; 3. (define (h v) (+ (f v) (g v)))
(define BFD3 (make-fd 'h 'v (make-add (make-fa 'f 'v) (make-fa 'g 'v))))

; Next, define the class BSL-fun-def* to represent a definitions area that
; consists of a number of one-argument function definitions.
; Translate the definitions area that defines f, g, and h into your data representation and name it da-fgh.

; A BSL-fun-def* is [List of BSL-fun-def]
(define da-fgh (list BFD1 BFD2 BFD3))


; Finally, work on the following wish:
; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da
; signals an error if there is none

(check-expect (lookup-def da-fgh 'f) BFD1)
(check-expect (lookup-def da-fgh 'g) BFD2)
(check-expect (lookup-def da-fgh 'h) BFD3)
(check-error (lookup-def da-fgh 'i) "function definition not found")


(define (lookup-def da f)
  (local ((define search (filter (lambda (def) (symbol=? f (fd-name def))) da)))
    (if (empty? search)
        (error "function definition not found")
        (first search))))

;Looking up a definition is needed for the evaluation of applications.