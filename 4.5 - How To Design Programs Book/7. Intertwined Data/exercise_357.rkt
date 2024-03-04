;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_357) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 357


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

(define bfe1 (make-fa 'k (make-add 1 1)))
(define kfuncbody (make-mul 3 'x))

;Design eval-definition1. The function consumes four arguments:
; 1. a BSL-fun-expr ex;
; 2. a symbol f, which represents a function name;
; 3. a symbol x, which represents the functions’s parameter; and
; 4. a BSL-fun-expr b, which represents the function’s body.

; It determines the value of ex. When eval-definition1 encounters an
; application of f to some argument, it
;  1. evaluates the argument,
;  2. substitutes the value of the argument for x in b; and
;  3. finally evaluates the resulting expression with eval-definition1.

; Here is how to express the steps as code, assuming arg is the argument of the function application:
; (local [(define value (eval-definition1 arg f x b))
;         (define plugd (subst b x arg-value))]
;   (eval-definition1 plugd f x b))

; Notice that this line uses a form of recursion that has not been covered.
; The proper design of such functions is discussed in part V.

; If eval-definition1 encounters a variable, it signals the same error as eval-variable from exercise 354.
; It also signals an error for function applications that refer to a function name other than f.

; Warning The use of this uncovered form of recursion introduces a new element into your computations:
; non-termination. That is, a program may run forever instead of delivering a result or signaling an error.
; If you followed the design recipes of the first four parts, you cannot write down such programs.
; For fun, construct an input for eval-definition1 that causes it to run forever. Use STOP to terminate the program.

; BSL-fun-expr (ex) Symbol (f) Symbol (x) BSL-fun-expr (b) -> Number or error
; determines the value of ex
(define (eval-definition1 ex f x b)
  (cond [(number? ex) ex]
        [(symbol? ex) (error "symbol not found")]
        [(add? ex) (+ (eval-definition1 (add-left ex) f x b)
                      (eval-definition1 (add-right ex) f x b))]
        [(mul? ex) (* (eval-definition1 (mul-left ex) f x b)
                      (eval-definition1 (mul-right ex) f x b))]
        [(fa? ex)
         (if (symbol=? f (fa-name ex))
             (local ((define value (eval-definition1 (fa-arg ex) f x b))
                     (define plugd (subst b x value)))
               (eval-definition1 plugd f x b))
             (error "function not defined"))]))

(check-expect (eval-definition1 bfe1 'k 'x kfuncbody) 6)
(check-error (eval-definition1 bfe1 'i 'x kfuncbody) "function not defined")
(check-error (eval-definition1 bfe1 'k 'i kfuncbody) "symbol not found")
              
