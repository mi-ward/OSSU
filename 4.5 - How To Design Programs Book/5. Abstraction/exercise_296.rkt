;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_296) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 296

; A Shape is a function;
; [Posn -> Boolean]
; interpretation if s is a shape and p a Posn, (s p)
; produces #true if p is in s, #false otherwise

; Shape Posn -> Boolean
(define (inside? s p)
  (s p))

; Posn -> Boolean
(lambda (p) (and (= (posn-x p) 3) (= (posn-y p) 4)))

; Number Number -> Shape
(define (mk-point x y)
  (lambda (p)
    (and (= (posn-x p) x) (= (posn-y p) y))))

(define a-sample-shape (mk-point 3 4))

; represents a point at (x, y)

(check-expect (inside? (mk-point 3 4) (make-posn 3 4)) #true)
(check-expect (inside? (mk-point 3 4) (make-posn 3 0)) #false)

; Number Number Number -> Shape
; creates a representation for a circle of radius r
;  located at (center-x, center-y)
(define (mk-circle center-x center-y r)
  ; [Posn -> Boolean]
  (lambda (p)
    (<= (distance-between center-x center-y p) r)))

(check-expect
 (inside? (mk-circle 3 4 5) (make-posn 0 0)) #true)
(check-expect
 (inside? (mk-circle 3 4 5) (make-posn 0 9)) #false)
(check-expect
 (inside? (mk-circle 3 4 5) (make-posn -1 3)) #true)




;- - - - - X - o o o - - - -
;- - - - - o o - - - o o - -
;- - - - o ; - - - - - - o -
;- - - - o ; - - - - - - o -
;- - - o - ; - - - - - - - o
;- - - o - ; - - - - - - - o
;- - - o X ; - - - - - - - o
;- - - - o ; - - - - - - o -
;- - - - o ; - - - - - - o -
;----------X-o-------o-o----
;- - - - - ; - o o o - - - -
;- - - - - ; - - - - - - - -
;- - - - - ; - - - - - - - -
;- - - - - ; - - - - - - - -
;- - - - - ; - - - - - - - -


;Number Number Posn -> Number
; computes distance between x, y and p
(define (distance-between x y p)
  (sqrt (+ (sqr (- x (posn-x p))) (sqr (- y (posn-y p))))))

