;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_295) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 295. Develop n-inside-playground?,
;a specification of the random-posns function below.
;The function generates a predicate that ensures that the
;length of the given list is some given count and that
;all Posns in this list are within a WIDTH by HEIGHT rectangle:

;distances in terms of pixels
(define WIDTH 300)
(define HEIGHT 300)

; N -> [List-of Posn]
; generates n random Posns in [0, WIDTH) by [0 , HEIGHT)
(check-satisfied (random-posns 3)
                 (n-inside-playground? 3))

(define (random-posns n)
  (build-list
   n
   (lambda (i)
     (make-posn (random WIDTH) (random HEIGHT)))))

; Number -> Boolean
; ensures that the length of the given list is some given count
; and that all Posns in this list are within a WIDTH by HEIGHT rectangle
(define (n-inside-playground? i)
  (lambda (i0)
    (local [(define (<=WIDTH  w) (< 0 (posn-x w) WIDTH))
            (define (<=HEIGHT h) (< 0 (posn-y h) HEIGHT))]
    (and (= (length i0) i)
         (andmap <=WIDTH  i0)
         (andmap <=HEIGHT i0)))))
         

;Define random-posns/bad that satisfies n-inside-playground?
;and does not live up to the expectations implied by the
;above purpose statement.

; N -> [List-of Posn]
; does not live up to expectations implied by purpose statement
; WIDTH and HEIGHT are switched, can fool the specification if the rectangle area is changed
(define (random-posns/bad n)
    (build-list
   n
   (lambda (i)
     (make-posn (random HEIGHT) (random WIDTH)))))

(check-satisfied (random-posns/bad 3)
                 (n-inside-playground? 3))


;Note: This specification is incomplete.
;Although the word “partial” might come to mind,
;computer scientists reserve the phrase “partial specification”
;for a different purpose.