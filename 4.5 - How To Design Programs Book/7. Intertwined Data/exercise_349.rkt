;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_349) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 349
;Create tests for parse until DrRacket tells you that every element
;in the definitions area is covered during the test run.

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

(check-expect (parse 10) 10)
(check-expect (parse '(+ 10 11)) (make-add 10 11))
(check-expect (parse '(* 10 12)) (make-mul  10 12))
(check-error (parse '(+ 12)) WRONG)
(check-error (parse '(/ 10 12)) WRONG)
(check-error (parse '('() 10 12)) WRONG)
(check-error  (parse "ten") WRONG)
(check-error  (parse 'ten) WRONG)
