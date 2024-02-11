;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_319) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 319
;Design substitute.
;It consumes an S-expression s and two symbols, old and new.
;The result is like s with all occurrences of old replaced by new.

;====================================

;Any -> Boolean
;produces true if a is number, string, symbol
(define (atom? a)
  (or (number? a)
      (string? a)
      (symbol? a)))

;====================================

;S-expression Symbol Symbol
;replace all occurences of old with new in sexp
(define (substitute sexp old new)
  (local [(define (review-sexp sexp)
            (cond [(atom? sexp) (replace sexp)]
                  [else (collect sexp)]))
          
          (define (replace atom)
            (cond [(symbol? atom) (if (symbol=? old atom) new atom)]
                  [else atom]))
          
          (define (collect sl)
            (cond [(empty? sl) '()]
                  [else
                   (cons (review-sexp (first sl)) (collect (rest sl)))]))]
    (review-sexp sexp)))

(check-expect (substitute 'hello 'hello 'world) 'world)
(check-expect (substitute '(hello world 21.12) 'hello 'world)
              '(world world 21.12))
(check-expect (substitute '((hello world 21.12)) 'hello 'world)
              '((world world 21.12)))

