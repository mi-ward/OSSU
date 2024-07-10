;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname genrec1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define (s-triangle n)
  (triangle (* n 10) "outline" "red"))

(s-triangle 3)
(beside (s-triangle 3) (s-triangle 3))

(above (s-triangle 3)
       (beside (s-triangle 3) (s-triangle 3)))

#;
; Number -> Image
; creates Sierpinski triangle of size side

(define (sierpinski side)
  (triangle side 'outline 'red))

(define SMALL 4) ; a size measure in terms of pixels
(define small-triangle (triangle SMALL 'outline 'red))

; Number -> Image
; generative creates Sierpinski ∆ of size side by generating
; one for (/ side 2) and place one copy above two copies

(check-expect (sierpinski SMALL) small-triangle)
(check-expect (sierpinski (* 2 SMALL))
              (above small-triangle
                     (beside small-triangle small-triangle)))

(define (sierpinski side)
  (cond
    [(<= side SMALL) (triangle side 'outline 'red)]
    [else
     (local ((define half-sized (sierpinski (/ side 2))))
       (above half-sized (beside half-sized half-sized)))]))

; [Number -> Number] Number Number -> Number
; determine R such that f has a root in [R, (+ R epsilon)]
; assume f is continuous
; (2) (or (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in
; one of the two halve, picks according to (2)
(define (find-root f left right)
  0)



