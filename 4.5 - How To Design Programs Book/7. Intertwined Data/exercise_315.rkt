;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_315) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 315.
;Design the function average-age.
;It consumes a family forest and a year (N).
;From this data, it produces the average age of all
;child instances in the forest.

;Note If the trees in this forest overlap,
;the result isn’t a true average because some people
;contribute more than others.

;For this exercise, act as if the trees don’t overlap.

;===================================================
(define-struct no-parent[])
(define-struct child [father mother name date eyes])
; An FT (short for family tree) is one of:
; - (make-no-parent)
; - (make child FT FT String N String)

(define NP (make-no-parent))
; An FT is one of:
; - NP
; - (make-child FT FT String N String)
(make-child NP NP "Carl" 1926 "green")

(make-child (make-child NP NP "Carl" 1926 "green")
            (make-child NP NP "Bettina" 1926 "green")
            "Adam"
            1950
            "hazel")

; Oldest Generation
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))

; Oldest Generation
(define Adam (make-child NP NP "Adam" 1950 "hazel"))
(define Dave (make-child NP NP "Dave" 1955 "black"))
(define Eva (make-child NP NP "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))

; Oldest Generation
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))


;==========================================

;[List-of FT] Number -> Number
;produce the average age of all child instances in the forest
(define (average-age loft year)
  (local [(define (total-age ft)
            (cond
              [(no-parent? ft) 0]
              [else (+ (total-age (child-father ft))
                       (total-age (child-mother ft))
                       (- year (child-date ft)))]))
    (define (count-persons family-tree)
       (cond [(no-parent? family-tree) 0]
             [else
              (+ 1
                 (count-persons (child-father family-tree))
                 (count-persons (child-mother family-tree)))]))]

    (if (empty? loft)
        0
    (/ (foldr + 0 (map total-age loft))
       (foldr + 0 (map count-persons loft))))))

(check-expect (average-age '() 2024) 0)
(check-expect (average-age ff1 2024) (- 2024 1926))
(check-expect (average-age ff2 2024) 58.5)
(check-within (average-age ff3 2024) 71.6 .1)

