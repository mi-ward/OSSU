;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_354) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 354
;Design eval-variable. The checked function consumes a BSL-var-expr
;and determines its value if numeric? yields true for the input.
;Otherwise it signals an error.

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

;BSL-var-expr -> Boolean
;determines whether a BSL-var-expr is also a BSL-expr
(define (numeric? bslve)
  (cond [(symbol? bslve) #false]
        [(add? bslve) (and (numeric? (add-left bslve)) (numeric? (add-right bslve)))]
        [(mul? bslve) (and (numeric? (mul-left bslve)) (numeric? (mul-right bslve)))]
        [else #true]))

;BSL-expr -> value
;consumes a representation of a BSL expression and computes its value
(define (eval-expression bslexp)
  (cond [(number? bslexp) bslexp]
        [(add? bslexp) (+ (eval-expression (add-left bslexp))
                          (eval-expression (add-right bslexp)))]
        [(mul? bslexp) (* (eval-expression (mul-left bslexp))
                          (eval-expression (mul-right bslexp)))]))

;BSL-var-expr -> Number or error
;determines if numeric then evaluates, otherwise error
(define (eval-variable bslve)
  (if (numeric? bslve)
      (eval-expression bslve)
      (error WRONG)))

(check-expect (eval-variable 10) 10)
(check-expect (eval-variable (make-mul (make-add 10 (make-mul (make-mul 10 20) 5)) 10)) 10100)
(check-error (eval-variable (make-mul (make-add 10 (make-mul (make-mul 10 'x) 5)) 10)) WRONG)
(check-error (eval-variable 'x) WRONG)

;BSL-var-expr Symbol Number -> BSL-exp
;produces a BSL-var-expr like the orignal with all occurrences of x replaced by v.
(define (subst ex x v)
  (cond [(number? ex) ex]
        [(and (symbol? ex) (symbol=? ex x)) v]
        [(add? ex) (make-add (subst (add-left ex) x v) (subst (add-right ex) x v))]
        [(mul? ex) (make-mul (subst (mul-left ex) x v) (subst (mul-right ex) x v))]
        [else ex]))

;In general, a program defines many constants in the definitions area,
;and expressions contain more than one variable. To evaluate such expressions,
;we need a representation of the definitions area when it contains
;a series of constant definitions. For this exercise we use association lists:

; An AL (short for association list) is [List-of Association].

; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

(define AL (list (list 'x 10) (list 'y 5) (list 'z 8)))

;Make up elements of AL.
;Design eval-variable*. The function consumes a BSL-var-expr ex and an association list da.
;Starting from ex, it iteratively applies subst to all associations in da.
;If numeric? holds for the result, it determines its value; otherwise it signals the same error as eval-variable.

;Hint Think of the given BSL-var-expr as an atomic value and traverse the given association list instead.
;We provide this hint because the creation of this function requires a little design knowledge from Simultaneous Processing.

;BSL-var-expr (ex) AL (da) -> Number or error
;apply subst to all associations in da, if numeric? is true for all, determine value. otherwise error
(define (eval-variable* ex da)
  (cond [(empty? da) (eval-variable ex)]
        [else
         (eval-variable* (subst ex (first (first da)) (second (first da))) (rest da))]))

(check-expect  (eval-variable* 5 AL) 5)
(check-expect (eval-variable* 'x AL) 10)
(check-expect (eval-variable* 'y AL) 5)
(check-expect (eval-variable* 'z AL) 8)
(check-error (eval-variable* 'a AL) WRONG)

(check-expect (eval-variable* (make-add 5 5) AL) 10)
(check-expect (eval-variable* (make-mul 5 5) AL) 25)
(check-expect (eval-variable* (make-add 'x 5) AL) 15)
(check-expect (eval-variable* (make-mul 'x 5) AL) 50)
(check-expect (eval-variable* (make-add 5 'y) AL) 10)
(check-expect (eval-variable* (make-mul 5 'y) AL) 25)
(check-expect (eval-variable* (make-mul 'z 'y) AL) 40)
(check-expect (eval-variable* (make-add 'x 'z) AL) 18)



