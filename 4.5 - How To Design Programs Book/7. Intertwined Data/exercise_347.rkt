;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_347) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 347.

;Design eval-expression. The function consumes a representation of a BSL expression and computes its value.

(define-struct add [left right])
; A Add is a structure:
; - (make-add BSL-expr BSL-expr)

(define-struct mul [left right])
; A Mul is a structure:
; - (make-mul BSL-expr BSL-expr)

;BSL-expr -> value
;consumes a representation of a BSL expression and computes its value
(define (eval-expression bslexp)
  (cond [(number? bslexp) bslexp]
        [(add? bslexp) (+ (eval-expression (add-left bslexp))
                          (eval-expression (add-right bslexp)))]
        [(mul? bslexp) (* (eval-expression (mul-left bslexp))
                          (eval-expression (mul-right bslexp)))]))
 
  

(define BSLexp1 (make-add 5 5))
(define BSLexp2 (make-mul 5 5))
(define BSLexp3 (make-mul (make-add 2 3) 5))
(define BSLexp4 (make-mul 10 (make-add 2 3)))
(define BSLexp5 (make-add 10 (make-add 2 3)))
(define BSLexp6 (make-add (make-add 2 3) (make-add 2 3)))
 
(check-expect (eval-expression BSLexp1) 10)
(check-expect (eval-expression BSLexp2) 25)
(check-expect (eval-expression BSLexp3) 25)
(check-expect (eval-expression BSLexp4) 50)
(check-expect (eval-expression BSLexp5) 15)
(check-expect (eval-expression BSLexp6) 10)

;ALL OF THE BELOW IS INCORRECT
;==========================================================================
;;A BSL-expr is a structure:
;;  (make-BSL-expr Number Number)
;
;(define-struct add [x y])
;(define-struct mul [x y])
;
;(define ten (make-add 5 5))
;(define ten? (make-add "5" "5"))
;(define 5en (make-add "5" 5))
;(define twenty-five (make-mul 5 5))
;(define twenty-fives (make-mul "fives" 20))
;(define twenty-false (make-mul 20 "fives"))
;(define twenty-falser (make-mul "t" "fives"))
;
;;BSL-expr -> Sum
;;consumes a BSL expression and produces a sum
;(define (sum BSL-expr)
;  (cond [(and (number? (add-x BSL-expr)) (number? (add-y BSL-expr))) (+ (add-x BSL-expr) (add-y BSL-expr))]
;        [(and (string? (add-x BSL-expr)) (string? (add-y BSL-expr))) (string-append (add-x BSL-expr) (add-y BSL-expr))]
;        [else #false]))
;      
;
;(check-expect (sum ten) 10)
;(check-expect (sum ten?) "55")
;(check-expect (sum 5en) #false)
;
;;BSL-expr -> Product
;;consumes a BSL expression and produces a product
;(define (product BSL-expr)
;  (cond [(and (number? (mul-x BSL-expr)) (number? (mul-y BSL-expr))) (* (mul-x BSL-expr) (mul-y BSL-expr))]
;        [(and (string? (mul-x BSL-expr)) (number? (mul-y BSL-expr)))
;         (foldr (lambda (a b) (if (number? a) (string-append (mul-x BSL-expr) b) #false)) "" (build-list (mul-y BSL-expr) add1))]
;        [else #false]))
;      
;
;(check-expect (product twenty-five) 25)
;(check-expect (product twenty-fives) "fivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfivesfives")
;(check-expect (product twenty-false) #false)
;(check-expect (product twenty-falser) #false)