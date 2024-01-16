;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_287) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 287.
(define-struct IR [name price])
(define IR1 (make-IR "beans" 10))
(define IR2 (make-IR "peas" 20))
(define IR3 (make-IR "lentil" 100))

;Use filter to define eliminate-exp.
;The function consumes a number, ua, and a list of inventory records
;(containing name and price), and it produces a list of all those
;structures whose acquisition price is below ua.

;Number, loIR
;produce a list of all structs whose price is below ua
(define (eliminate-exp ua loIR)
  (filter (lambda (ir) (< (IR-price ir) ua)) loIR))

(check-expect (eliminate-exp 100 (list IR1 IR2 IR3)) (list IR1 IR2))

;Then use filter to define recall,
;which consumes the name of an inventory item,called ty,
;and a list of inventory records and which produces
;a list of inventory records that do not use the name ty.

;String [List-of IR] -> [List-of IR]
;produce a list of inventory records that do not use the name (ty)
(define (recall ty loIR)
  (filter (lambda (ir) (not (string=? (IR-name ir) ty))) loIR))

(check-expect (recall "beans" (list IR1 IR2 IR3)) (list IR2 IR3))

;In addition, define selection,
;which consumes two lists of names and
;selects all those from the second one that are also on the first.
;[List-of names] [List-of Names] -> [List-of Names]
(define (selection lon1 lon2)
  (filter (lambda (name) (member? name lon1)) lon2))

(check-expect (selection (list "Jon" "Jim" "Jude" "Justin")
                         (list "Jon" "Jim" "Kevin" "Richard"))
              (list "Jon" "Jim"))