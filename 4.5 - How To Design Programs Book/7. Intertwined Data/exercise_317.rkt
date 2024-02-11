;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_317) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 317
;A program that consists of three connected functions
;ought to express this relationship with a local expression.

;Copy and reorganize the program from figure 117
;into a single function using local. Validate the revised code
;with the test suite for count.

;The second argument to the local functions, sy, never changes.
;It is always the same as the original symbol.
;Hence you can eliminate it from the local function definitions
;to tell the reader that sy is a constant across the traversal process.

;================================

;Any -> Boolean
;produces true if a is number, string, symbol
(define (atom? a)
  (or (number? a)
      (string? a)
      (symbol? a)))

; S-expr Symbol -> N
; counts all occurrences of sy in sexp
(define (count sexp sy)
  (cond
    [(atom? sexp) (count-atom sexp sy)]
    [else (count-sl sexp sy)]))

;SL Symbol -> N
; counts all occurrences of sy in sl
(define (count-sl sl sy)
  (cond
    [(empty? sl) 0]
    [else
     (+ (count (first sl) sy) (count-sl (rest sl) sy))]))

;Atom Symbol -> N
; counts all occurrences of sy in at
(define (count-atom at sy)
  (cond
    [(number? at) 0]
    [(string? at) 0]
    [(symbol? at) (if (symbol=? at sy) 1 0)]))

(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)
;=================================

;S-expr Symbol -> N
;counts all occurrences of sy in s-exp
(define (count2 sexp sy)
  (local [(define (count-atom at)
            (cond
              [(number? at) 0]
              [(string? at) 0]
              [(symbol? at) (if (symbol=? at sy) 1 0)]))
          (define (count-sl sl)
            (cond
              [(empty? sl) 0]
              [else
               (+ (count (first sl)) (count-sl (rest sl)))]))
          (define (count sexp)
            (cond
              [(atom? sexp) (count-atom sexp)]
              [else (count-sl sexp)]))]
    (count sexp)))

(check-expect (count2 'world 'hello) 0)
(check-expect (count2 '(world hello) 'hello) 1)
(check-expect (count2 '(((world) hello) hello) 'hello) 2)
