;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_489) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 489
; Reformulate add-to-each using map and lambda.

; [List-of Number] -> [List-of Number]
; converts a list of relative to absolute distances
; the first number represents the distance to the origin

(check-expect (relative->absolute '(50 40 70 30 30))
              '(50 90 160 190 220))

(define (relative->absolute l)
  (cond
    [(empty? l) '()]
    [else
     (cons (first l) (add-to-each (first l)
                                  (relative->absolute (rest l))))]))

; Number [List-of Number] -> [List-of Number]
; adds n to each number on l

(check-expect (cons 50 (add-to-each 50 '(40 110 140 170)))
              '(50 90 160 190 220))
                    

(define (add-to-each n lon)
  (map (lambda (x) (+ n x)) lon))
  
(check-expect (relative->absolute.book '(50 40 70 30 30))
              '(50 90 160 190 220))

(define (relative->absolute.book l)
  (cond
    [(empty? l) '()]
    [else (local [(define rest-of-l
                    (relative->absolute.book (rest l)))
                  (define adjusted
                    (add-to-each (first l) rest-of-l))]
            (cons (first l) adjusted))]))

;(time (relative->absolute (build-list 1000 add1)))
(time (relative->absolute (build-list 2000 add1)))



     
              
