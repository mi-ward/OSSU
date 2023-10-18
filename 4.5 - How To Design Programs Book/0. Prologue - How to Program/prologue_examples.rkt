;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Prologue - How to Program|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(+ 1 1)
(+ 2 2)
(* 3 3)
(- 4 2)
(/ 6 2)

(define (y x) (* x x))

(y 1)
(y 2)
(y 3)
(y 4)
(y 5)

;; (define (FunctionName InputName) BodyExpression)

(empty-scene 100 60)

(place-image (circle 5 "solid" "red") 50 23 (empty-scene 100 60))

(place-image (circle 5 "solid" "red") 50 20 (empty-scene 100 60))
(place-image (circle 5 "solid" "red") 50 30 (empty-scene 100 60))
(place-image (circle 5 "solid" "red") 50 40 (empty-scene 100 60))

(define (picture-of-circle height)
  (place-image (circle 5 "solid" "red") 50 height (empty-scene 100 60)))


(picture-of-circle 0)
(picture-of-circle 10)
(picture-of-circle 20)
(picture-of-circle 30)




;; CONDS

(define (picture-of-circle.v2 height)
  (cond
    [(<= height 60) (place-image (circle 5 "solid" "red") 50 height (empty-scene 100 60))]
    [(>  height 60) (place-image (circle 5 "solid" "red") 50 60 (empty-scene 100 60))]))

(define (picture-of-circle.v3 height)
  (cond
    [(<= height (- 60 (/ (image-height (circle 5 "solid" "red")) 2)))
         (place-image (circle 5 "solid" "red") 50 height
                      (empty-scene 100 60))]
    [(> height (- 60 (/ (image-height (circle 5 "solid" "red")) 2)))
     (place-image (circle 5 "solid" "red") 50 (- 60 (/ (image-height (circle 5 "solid" "red")) 2))
     (empty-scene 100 60))]))


(picture-of-circle 1000)
(picture-of-circle.v2 1000)
(animate picture-of-circle.v2)
(animate picture-of-circle.v3)