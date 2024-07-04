;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_412_incomplete) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct inex [mantissa sign exponent])
; An Inex is a structure: 
;   (make-inex N99 S N99)
; An S is one of:
; – 1
; – -1
; An N99 is an N between 0 and 99 (inclusive).

; N Number N -> Inex
; makes an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))
 
; Inex -> Number
; converts an inex into its numeric equivalent 
(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt
       10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

(define MAX-POSITIVE (create-inex 99 1 99))
(define MIN-POSITIVE (create-inex 1 -1 99))

;Exercise 412.
; Design inex+.
; The function adds two Inex representations of numbers
; that have the same exponent.
; The function must be able to deal with inputs that increase the exponent.
; Furthermore, it must signal its own error if the result is out of range,
; not rely on create-inex for error checking.

; Inex Inex -> Inex
; add two Inex representations of numbers that have the same exponent
(define (inex+ inex1 inex2)
  (local ((define temp_m (+ (inex-mantissa inex1) (inex-mantissa inex2)))
          (define new_m (if (> temp_m 99) (round (/ temp_m 10)) temp_m))
          (define new_e (if (> temp_m 99) (+ (inex-exponent inex1) 1) (inex-exponent inex1))))
    (if (> new_e 99)
        (error "out of range")
        (create-inex new_m (inex-sign inex1) new_e))))

(check-expect (inex+ (create-inex 1 1 10) (create-inex 2 1 10)) (create-inex 3 1 10))    
(check-expect (inex+ (create-inex 56 1 10) (create-inex 56 1 10)) (create-inex 11 1 11))
(check-expect (inex+ (create-inex 99 1 10) (create-inex 99 1 10)) (create-inex 20 1 11))
(check-error (inex+ (create-inex 99 1 99) (create-inex 99 1 99)) "out of range")

;Challenge Extend inex+ so that it can deal with inputs whose exponents differ by 1:
;(check-expect
;  (inex+ (create-inex 1 1 0) (create-inex 1 -1 1))
;  (create-inex 11 -1 1))
;Do not attempt to deal with larger classes of inputs than that without reading the following subsection.
