;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_352) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 352. Design subst

;The function consumes a BSL-var-expr ex, a Symbol x, and a Number v.
;It produces a BSL-var-expr like ex with all occurrences of x replaced by v.

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

;BSL-var-expr Symbol Number -> BSL-exp
;produces a BSL-var-expr like the orignal with all occurrences of x replaced by v.
(define (subst ex x v)
  (cond [(number? ex) ex]
        [(and (symbol? ex) (symbol=? ex x)) v]
        [(add? ex) (make-add (subst (add-left ex) x v) (subst (add-right ex) x v))]
        [(mul? ex) (make-mul (subst (mul-left ex) x v) (subst (mul-right ex) x v))]))

(check-expect (subst 5 'x 5) 5)
(check-expect (subst 'x 'x 5) 5)
(check-expect (subst (make-add 'x 'x) 'x 5) (make-add 5 5))
(check-expect (subst (make-add 'x (make-add 'x 'x)) 'x 5) (make-add 5 (make-add 5 5)))
(check-expect (subst (make-mul 'x 'x) 'x 10) (make-mul 10 10))
(check-expect (subst (make-mul 'x (make-mul 'x 'x)) 'x 10) (make-mul 10 (make-mul 10 10)))



