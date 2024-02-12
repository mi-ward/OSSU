;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_320) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 320
;Practice the step from data definition to function design
;with two changes to the definition of S-expr.

;For the first step, reformulate the data definition for
;S-expr so that the first clause of the first data definition
;is expanded into the three clauses of Atom and the second data definition
;uses the List-of abstraction.

;Redesign the count function for this data definition.

;An S-expr is one of:
; - Number
; - String
; - Symbol
; - [List-of S-expr]

; A [List-of S-expr] is one of:
; - '()
; - (cons S-expr [List-of S-expr])

;Symbol S-expr -> N
;counts all occurences of sy in sexp
(define (count sy sexp)
  (cond [(number? sexp) 0]
        [(string? sexp) 0]
        [(symbol? sexp) (if (symbol=? sy sexp) 1 0)]
        [else
         (review-losexp sy sexp)]))
        
(define (review-losexp sy losexp)
  (cond [(empty? losexp) 0]
        [else
         (+ (count sy (first losexp)) (review-losexp sy (rest losexp)))]))

(check-expect (count 'hello     123) 0)
(check-expect (count 'hello "world") 0)
(check-expect (count 'hello  'world) 0)
(check-expect (count 'hello     '()) 0)
(check-expect (count 'hello 'hello) 1)
(check-expect (count 'hello '(hello world)) 1)
(check-expect (count 'hello '((hello world))) 1)
(check-expect (count 'hello '((hello world) hello)) 2)

;Symbol S-expr -> N
;counts all occurences of sy in sexp
(define (count1 sy sexp)
  (local [(define (count-atom sexp)
            (cond [(number? sexp) 0]
                  [(string? sexp) 0]
                  [(symbol? sexp) (if (symbol=? sy sexp) 1 0)]
                  [else (review-losexp sexp)]))
        
          (define (review-losexp losexp)
            (cond [(empty? losexp) 0]
                  [else
                   (+ (count-atom (first losexp))
                      (review-losexp (rest losexp)))]))]
    (count-atom sexp)))

(check-expect (count1 'hello     123) 0)
(check-expect (count1 'hello "world") 0)
(check-expect (count1 'hello  'world) 0)
(check-expect (count1 'hello     '()) 0)
(check-expect (count1 'hello 'hello) 1)
(check-expect (count1 'hello '(hello world)) 1)
(check-expect (count1 'hello '((hello world))) 1)
(check-expect (count1 'hello '((hello world) hello)) 2)


;An S-expr is one of:
; - Number
; - String
; - Symbol
; - '()
; - [list-of Sexp]

;Symbol S-expr -> N
;counts all occurences of sy in sexp
(define (count2 sy sexp)
  (cond [(number? sexp) 0]
        [(string? sexp) 0]
        [(symbol? sexp) (if (symbol=? sy sexp) 1 0)]
        [else
           (foldr + 0 (map (lambda (s) (count2 sy s)) sexp))]))

(check-expect (count2 'hello     123) 0)
(check-expect (count2 'hello "world") 0)
(check-expect (count2 'hello  'world) 0)
(check-expect (count2 'hello     '()) 0)
(check-expect (count2 'hello 'hello) 1)
(check-expect (count2 'hello '(hello world)) 1)
(check-expect (count2 'hello '((hello world))) 1)
(check-expect (count2 'hello '((hello world) hello)) 2)



