;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_436) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 436.
; Formulate a termination argument for food-create from exercise 432.


(define MAX 10)
; Posn -> Posn
; termination (food-create p) loops unless MAX is <= 1
(define (food-create p)
  (local ((define (food-check-create p candidate)
          (if (equal? p candidate) (food-create p) candidate)))
  (food-check-create
     p (make-posn (random MAX) (random MAX)))))
 
; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)

#;
(define MAX 2)
; Posn -> Posn
#;
(define (food-create p)
  (local ((define (food-check-create p candidate)
            (if (equal? p candidate) (food-create p) candidate)))
    (if (equal? (make-posn 0 0) p)
        (make-posn 0 0)
        (food-check-create p (make-posn (random MAX) (random MAX))))))
 
; Posn -> Boolean
; use for testing only
#;
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))
#;
(check-expect (food-create (make-posn 0 0)) (make-posn 0 0))
#;
(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)