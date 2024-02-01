;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_298) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Shape Posn -> Boolean
(define (inside? s p)
  (s p))

; Number Number Number -> Shape
; creates a representation for a circle of radius r
;   located at (center-x, center-y)
(define (mk-circle center-x center-y r)
  ; [Posn -> Boolean]
  (lambda (p)
    (<= (distance-between center-x center-y p) r)))

;Number Number Posn -> Number
; computes distance between x, y and p
(define (distance-between x y p)
  (sqrt (+ (sqr (- x (posn-x p))) (sqr (- y (posn-y p))))))

; Number Number Number Number -> Shape
; represents a width by height rectangle whose
; upper-left corner is located at (ul-x, ul-y)

(check-expect (inside? (mk-rect 0 0 10 3)
                       (make-posn 0 0))
              #true)
(check-expect (inside? (mk-rect 2 3 10 3)
                       (make-posn 4 5))
              #true)
(check-expect (inside? (mk-rect 0 0 5 5)
                       (make-posn 5 6))
              #false)


(define (mk-rect ul-x ul-y width height)
  (lambda (p)
    (and (<= ul-x (posn-x p) (+ ul-x width))
         (<= ul-y (posn-y p) (+ ul-y height)))))

; Shape Shape -> Shape
; combines two shapes into one
(define (mk-combination s1 s2)
  ; Posn -> Boolean
  (lambda (p)
    (or (inside? s1 p) (inside? s2 p))))

(define circle1 (mk-circle 3 4 5))
(define rectangle1 (mk-rect 0 3 10 3))
(define union1 (mk-combination circle1 rectangle1))

(check-expect (inside? union1 (make-posn 0 0)) #true)
(check-expect (inside? union1 (make-posn 0 9)) #false)
(check-expect (inside? union1 (make-posn -1 3)) #true)

;Exercise 298
; Design my-animate.
; Recall that the animate function consumes the representation
; of a stream of images, one per natural number.
; Since streams are infinitely long,
; ordinary compound data cannot represent them.

;Instead, we use functions:
; An ImageStream is a function:
; [N -> Image]
; interpretation a stream s denotes a series of images

;Here is a data example:
; ImageStream
 (define (create-rocket-scene height)
   (place-image (triangle 5 "solid" "green") 50 height (empty-scene 60 60)))

;You may recognize this as one of the first pieces of code in the Prologue.
;The job of (my-animate s n) is to show the images (s 0), (s 1), and soon
;at a rate of 30 images per second up to n images total.
;Its result is the number of clock ticks passed since launched.

;Note: This case is an example where it is possible to write down
;examples/test cases easily, but these examples/tests per se do not
;inform the design process of this big-bang function. Using functions
;as data representations calls for more design concepts than
;this book supplies.

(define (my-animate s n)
  (big-bang 0
    (on-tick (lambda (t) (add1 t)) 1/30)
    (to-draw s)
    (stop-when (lambda (t) (= t n)))))

(my-animate create-rocket-scene 10)