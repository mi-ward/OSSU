;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_312) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 312
;Develop the function eye-colors, which consumes a family tree
;and produces a list of all eye colors in the tree.
;An eye color may occur more than once in the resulting list.

;Hint Use append to concatenate the lists resulting from the
;recursive calls.

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

;==================================================

; FT -> List-of String
;produces a list of all eye colors in the tree,
;eye color can occur more than once

(define (eye-colors ft)
  (cond
    [(no-parent? ft) '()]
    [else
     (append (cons (child-eyes ft) '())
             (eye-colors (child-father ft))
             (eye-colors (child-mother ft)))]))

(check-expect (eye-colors Fred) (list "pink"))
(check-expect (eye-colors Gustav) (list "brown" "pink" "blue" "green" "green"))
