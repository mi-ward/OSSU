;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_314) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 314
;Reformulate the data definition for FF with the List-of abstraction.
;Now do the same for the blue-eyed-child-in-forest? function.
;Finally, define blue-eyed-child-in-forest? using one of the
;list abstractions from the preceding chapter.

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

; FT -> Boolean
; does an-ftree contain a child
; structure with "blue" in the eyes field
(check-expect (blue-eyed-child? Carl) #false)
(check-expect (blue-eyed-child? Gustav) #true)

(define (blue-eyed-child? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [else (or (string=? (child-eyes   an-ftree)  "blue")
              (blue-eyed-child? (child-father an-ftree))
              (blue-eyed-child? (child-mother an-ftree))
              ; ... (child-name   an-ftree) ...
              ; ... (child-date   an-ftree) ...
              )]))


(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))

;;FF -> Boolean
;;does the forest contain any child with "blue" eyes
;
;(check-expect (blue-eyed-child-in-forest? ff1) #false)
;(check-expect (blue-eyed-child-in-forest? ff2) #true)
;(check-expect (blue-eyed-child-in-forest? ff3) #true)
;
;(define (blue-eyed-child-in-forest? a-forest)
;  (cond
;    [(empty? a-forest) #false]
;    [else
;     (or (blue-eyed-child? (first a-forest))
;         (blue-eyed-child-in-forest? (rest a-forest)))]))


;==========================================

; [List-of FT] -> Boolean
;;does the forest contain any child with "blue" eyes
(define (blue-eyed-child-in-forest? a-forest)
  (ormap blue-eyed-child? a-forest))

(check-expect (blue-eyed-child-in-forest? ff1) #false)
(check-expect (blue-eyed-child-in-forest? ff2) #true)
(check-expect (blue-eyed-child-in-forest? ff3) #true)
