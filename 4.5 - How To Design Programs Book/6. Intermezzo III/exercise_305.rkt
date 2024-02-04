;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_305) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)

;Exercise 305
;Use loops to define convert-euro.
;Convert a list of US$ amounts into a list of euro amounts based on
;an exchange rate of US$1.06 per EUR

(define RATE 1.06)
(define (convert-euro lst)
  (for/list ([i lst]) (/ i 1.06)))


(check-expect (convert-euro (list 1.06 10.60)) (list 1 10))

(convert-euro (list 1.06 10.60 30 249 1020 123))
