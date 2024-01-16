;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_285) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 285. Use map to define the function convert-euro,
;which converts a list of US$ amounts into a list of € amounts
;based on an exchange rate of US$1.06 per €.

;[List-of amount] -> [List-of amount]
;convert a list of $US amounts into a list of Euro amounts
;based on 1.06 -> 1 exchange rate
(define (convert-euro loa)
  (map (lambda (a) (/ a 1.06)) loa))

(check-expect (convert-euro (list 1.06 10.60)) (list 1 10))


;Also use map to define convertFC,
;which converts a list of Fahrenheit measurements to
;a list of Celsius measurements.

;[List-of Number] -> [List-of Number]
;convert a list of Fahrenheit measurements to
; a list of Celsius measurements
(define (F->C lot)
  (map (lambda (t) (* 5/9 (- t 32))) lot))

(check-expect (F->C (list 32 212)) (list 0 100))

;Finally, try your hand at translate,
;a function that translates a list of Posns into
;a list of lists of pairs of numbers.

;List-of Posns -> List-of [List-of pairs-of-numbers]
;translate a list of Posns into a list of lists of pair of numbers
(define (translate lop)
  (map (lambda (p) (list (posn-x p) (posn-y p))) lop))

(check-expect (translate (list (make-posn 1 1) (make-posn 2 2) (make-posn 3 3)))
              (list (list 1 1) (list 2 2) (list 3 3)))


