;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_450) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 450.
; A function f is monotonically increasing if (<= (f a) (f b)) holds whenever (< a b)
; holds. Simplify find-root assuming the given function is not only continuous
; but also monotonically increasing.

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in one of the two
; halves, picks according to assumption 
(define ε 0.00000000000001)
(define (poly n) (* (- n 2) (- n 4))) 

(define (find-root f left right)
  (local ((define (find-root-2 left right f-left f-right)
  (cond
    [(<= (- right left) ε) left]
    [else
      (local ((define mid (/ (+ left right) 2))
              (define f@mid (f mid)))
        (cond
          [(<= f-left 0 f@mid)
           (find-root-2 left mid f-left f@mid)]
          [(<= f@mid 0 f-right)
           (find-root-2 mid right f@mid f-right)]))])))
  (find-root-2 left right (f left) (f right))))


(check-satisfied (find-root poly 3 6)
                 (lambda (n) (or (<= (- (poly n) (poly 4)) ε)
                                 (<= (- (poly 4) (poly n)) ε))))


(check-satisfied (find-root poly 2 10)
                 (lambda (n) (or (<= (- (poly n) (poly 4)) ε)
                                 (<= (- (poly 4) (poly n)) ε))))
