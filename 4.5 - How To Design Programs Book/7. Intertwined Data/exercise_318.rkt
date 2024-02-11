;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_318) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 318
;Design depth.
;The function consumes an S-expression and
;determines its depth. An Atom has a depth of 1.
;The depth of a list of S-expressions is the
;maximum depth of its items plus 1.

;====================================

;Any -> Boolean
;produces true if a is number, string, symbol
(define (atom? a)
  (or (number? a)
      (string? a)
      (symbol? a)))

;====================================

; S-Expression -> N
;determines the depth of an s-expression
;atom has depth of 1
(define (depth sexp)
  (local [(define (count sexp)
            (cond [(empty? sexp) 0]
                  [(atom? sexp) 1]
                  [else
                   (+ 1 (count-sl sexp))]))

          (define (count-sl sexp)
            (cond [(empty? sexp) 0]
                  [else
                   (+ (depth (first sexp)) (count-sl (rest sexp)))]))]
    (count sexp)))


(check-expect (depth '()) 0)
(check-expect (depth 'first) 1)
(check-expect (depth '(hello 20.12 "world")) 4)
(check-expect (depth '((hello 20.12 "world"))) 5)
