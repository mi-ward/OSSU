;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_351) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 351

;Design interpreter-expr. The function accepts S-expressions.
;If parse recognizes them as BSL-expr, it produces their value.
;Otherwise, it signals the same error as parse.

; An atom is one of:
; - Number
; - String
; - Symbol

(define (atom? a)
  (cond [(number? a) #true]
        [(string? a) #true]
        [(symbol? a) #true]
        [else #false]))


(define WRONG "wrong")

;An add is a structure:
(define-struct add [left right])

;A mul is a structure:
(define-struct mul [left right])

; S-expr -> BSL-expr
(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))
 
; SL -> BSL-expr 
(define (parse-sl s)
  (local ((define L (length s)))
    (cond
      [(< L 3) (error WRONG)]
      [(and (= L 3) (symbol? (first s)))
       (cond
         [(symbol=? (first s) '+)
          (make-add (parse (second s)) (parse (third s)))]
         [(symbol=? (first s) '*)
          (make-mul (parse (second s)) (parse (third s)))]
         [else (error WRONG)])]
      [else (error WRONG)])))
 
; Atom -> BSL-expr 
(define (parse-atom s)
  (cond
    [(number? s) s]
    [(string? s) (error WRONG)]
    [(symbol? s) (error WRONG)]))

(define (eval-expression bslexp)
  (cond [(number? bslexp) bslexp]
        [(add? bslexp) (+ (eval-expression (add-left bslexp))
                          (eval-expression (add-right bslexp)))]
        [(mul? bslexp) (* (eval-expression (mul-left bslexp))
                          (eval-expression (mul-right bslexp)))]))

;S-expr -> Number
;If parse recognizes them as BSL-expr, it produces their value. Otherwise, it signals the same error as parse.
(define (interpreter-expr sexp)
  (eval-expression (parse sexp)))

(check-expect (interpreter-expr 1) 1)
(check-expect (interpreter-expr '(* (+ 1 2) (* 3 (* 10 (+ 1 2))))) 270)
(check-expect (interpreter-expr '(+ 1 2)) 3)
(check-error (interpreter-expr "jon") WRONG)
(check-error (interpreter-expr '(* 1)) WRONG)
(check-error (interpreter-expr '(/ 1 2)) WRONG)
(check-error (interpreter-expr '(/ 1 2)) WRONG)