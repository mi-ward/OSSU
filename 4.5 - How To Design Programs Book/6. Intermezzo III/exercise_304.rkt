;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_304) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)

;Exercise 304. Evaluate

(for/list ([i 2] [j '(a b)]) (list i j))
;(list (list 0 'a) (list 1 'b))

;and

(for*/list ([i 2] [j '(a b)]) (list i j))
;(list (list 0 'a) (list 0 'b) (list 1 'a) (list 1 'b))

;in the interactions area of DrRacket.