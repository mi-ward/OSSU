;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_328) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 328

;Copy and paste figure 120 into DrRacket;
;include your test suite. Validate the test suite.
;As you read along the remainder of this section,
;perform the edits and rerun the test suites
;to confirm the validity of our arguments.

;========================================

(define(atom? a)
  (or (string? a) (number? a) (symbol? a)))
  

; S-expr Symbol Atom -> S-expr
; replaces all occurrences of old in sexp with new
 
(check-expect (substitute '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))
 
(define (substitute sexp old new)
  (cond
    [(atom? sexp) (if (equal? sexp old) new sexp)]
    [else (map (lambda (s) (substitute s old new)) sexp)]))

;lambda had to be used because we needed a function to
;interpret the single argument allowed in map