;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_311) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 311
;Develop the function average-age.
;It consumes a family tree and the current year.
;It produces the average age of all child structures in the family tree.

;==================================================

(define-struct no-parent [])
(define-struct child [father mother name date eyes])
(define NP (make-no-parent))
; An FT is one of:
; - NP
; - (make-child FT FT String N String)

; Oldest Generation
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))

; Middle Generation
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva  (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))

; Youngest Generation
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; FT -> ???
; ...
(define (fun-FT an-ftree)
  (cond
    [(no-parent? an-ftree) ...]
    [else ((fun-FT (child-father an-ftree)) ...
           (fun-FT (child-mother an-ftree)) ...
           ... (child-name   an-ftree) ...
           ... (child-date   an-ftree) ...
           ... (child-eyes   an-ftree) ...)]))

; FT -> Number
; counts the child structures in the tree
(check-expect (count-persons Carl) 1)
(check-expect (count-persons Dave) 3)
(check-expect (count-persons Gustav) 5)

(define (count-persons family-tree)
  (cond [(no-parent? family-tree) 0]
        [else
         (+ 1
            (count-persons (child-father family-tree))
            (count-persons (child-mother family-tree)))]))

;==================================================

;FT Number -> Number
;Produces the average age of all child structures in the family tree.
(define (average-age family-tree year)
  (local [(define (total-age ft)
            (cond
              [(no-parent? ft) 0]
              [else (+ (total-age (child-father ft))
                       (total-age (child-mother ft))
                       (- year (child-date ft)))]))]
    (/ (total-age family-tree) (count-persons family-tree))))
               

(check-expect (average-age Fred 2024) (- 2024 1966))
(check-expect (average-age Gustav 2024) (/ (+ (- 2024 1988)
                                              (- 2024 1966)
                                              (- 2024 1965)
                                              (- 2024 1926)
                                              (- 2024 1926)) 5))