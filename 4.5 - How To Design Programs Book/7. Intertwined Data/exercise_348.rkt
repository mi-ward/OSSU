;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_348) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 348

;Develop a data representation for Boolean BSL expressions constructed from
;#true, #false, and, or, and not. Then design eval-bool-expression,
;which consumes (representations of) Boolean BSL expressions and computes their values.

;What kind of values do these Boolean expressions yield? Booleans

; A Bool-BSL-expr is one of:
; - Boolean
; - and_
; - or_
; - not_

(define-struct and_ [left right])
; A and_ is a structure:
; - (make-and_ left right)

(define-struct or_ [left right])
; A or_ is a structure:
; - (make-or_ left right)

(define-struct not_ [param])
; A not_ is a structure:
; - (make-not_ bool)

(define BBex1 (make-and_ #true #true))
(define BBex2 (make-and_ #true #false))
(define BBex3 (make-and_ #false #true))
(define BBex4 (make-and_ #false #false))
(define BBex5 (make-or_ #true #true))
(define BBex6 (make-or_ #true #false))
(define BBex7 (make-or_ #false #true))
(define BBex8 (make-or_ #false #false))
(define BBex9 (make-not_ #true))
(define BBex10 (make-not_ #false))
(define BBex11 (make-and_ (make-not_ (make-or_ #true #false))
                     (make-or_ (make-and_ #false #false)
                          (make-not_ #true))))


;Bool-BSL-expr -> Bool
;consumes representations of Boolean BSL expressions and computes values
(define (eval-bool-expr bbex)
  (cond [(boolean? bbex) bbex]
        [(and_? bbex) (and (eval-bool-expr (and_-left bbex)) (eval-bool-expr (and_-right bbex)))]
        [(or_? bbex)  (or (eval-bool-expr (or_-left bbex)) (eval-bool-expr (or_-right bbex)))]
        [(not_? bbex) (not (eval-bool-expr (not_-param bbex)))]))

(check-expect (eval-bool-expr BBex1) #true)
(check-expect (eval-bool-expr BBex2) #false)
(check-expect (eval-bool-expr BBex3) #false)
(check-expect (eval-bool-expr BBex4) #false)
(check-expect (eval-bool-expr BBex5) #true)
(check-expect (eval-bool-expr BBex6) #true)
(check-expect (eval-bool-expr BBex7) #true)
(check-expect (eval-bool-expr BBex8) #false)
(check-expect (eval-bool-expr BBex9) #false)
(check-expect (eval-bool-expr BBex10) #true)
(check-expect (eval-bool-expr BBex11) #false)
                          



