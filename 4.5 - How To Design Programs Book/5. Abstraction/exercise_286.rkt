;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_286) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 286.
;An inventory record specifies the name of an inventory item,
;a description, the acquisition price, and the recommended sales price.
(define-struct IR [name description a-price r-price])
(define IR1 (make-IR "bean" "bean" 1 10))
(define IR2 (make-IR "pea" "pea" 2 20))
(define IR3 (make-IR "lentil" "lentil" 5 100))
;Define a function that sorts a list of inventory records
;by the difference between the two prices.

;(define (sort-ir loIR)
;  (local [(define(insert IR lst)
;            (cond [(empty? lst) (cons IR '())]
;                  [else
;                   (if ((lambda (a b) (> (- (IR-r-price a) (IR-a-price a))
;                                        (- (IR-r-price a) (IR-a-price a)))) IR (first lst))
;                       (cons IR lst)
;                       (cons (first lst) (insert IR (rest lst))))]))]
;    (cond
;      [(empty? loIR) '()]
;      [else
;       (insert (first loIR) (sort-ir (rest loIR)))])))

(define (sort-ir loIR)
  (sort loIR (lambda (a b) (> (- (IR-r-price a) (IR-a-price a))
                              (- (IR-r-price b) (IR-a-price b))))))

(check-expect (sort-ir (list IR2 IR1 IR3)) (list IR3 IR2 IR1))