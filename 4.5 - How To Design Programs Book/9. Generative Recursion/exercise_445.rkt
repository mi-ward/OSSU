;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_445) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 445.
; Consider the following function definition:

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))

;It defines a binomial for which we can determine its roots by hand:
(poly 2) ; 0
(poly 4) ; 0

(map poly (list -2 -1 0 1 2 3 4 5 6 7 8))

;Use poly to formulate a check-satisfied test for find-root.

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in 
; one of the two halves, picks according to (2)
;(define (find-root f left right) 0)

(check-satisfied (find-root poly 3 6)
                 (lambda (n) (or (<= (- (poly n) (poly 4)) ε)
                                 (<= (- (poly 4) (poly n)) ε))))

;Also use poly to illustrate the root-finding process.
;Start with the interval [3,6] and tabulate the information as follows for ε = 0:

; step  left         (f left)        right           (f right)            mid       (f mid)
; n=1     3          -1                  6.00        8.00                 4.50        1.25
; n=2     3          -1                  4.50        1.25                 3.75       -0.4375
; n=3     3.75       -0.4375             4.50        1.25                 4.125       0.265625
; n=4     3.75       -0.4375             4.125       0.265625             3.9375     -0.12109375
; n=5     3.9375     -0.12109375         4.125       0.265625             4.03125     0.0634765625
; n=6     3.9375     -0.12109375         4.03125     0.0634765625         3.984375   -0.031005859375
; n=7     3.984375   -0.031005859375     4.03125     0.0634765625         4.0078125   0.01568603515625
; n=8     3.984375   -0.031005859375     4.0078125   0.01568603515625     3.99609375 -0.0077972412109375
; n=9     3.99609375 -0.0077972412109375 4.0078125   0.01568603515625     4.001953125 0.003910064697265625
; n=10    3.99609375 -0.0077972412109375 4.001953125 0.003910064697265625 3.9990234375
  

(define ε 0.00000000000000001)

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in one of the two
; halves, picks according to assumption 
(define (find-root f left right)
  (cond
    [(<= (- right left) ε) left]
    [else
      (local ((define mid (/ (+ left right) 2))
              (define f@mid (f mid)))
        (cond
          [(or (<= (f left) 0 f@mid) (<= f@mid 0 (f left)))
           (find-root f left mid)]
          [(or (<= f@mid 0 (f right)) (<= (f right) 0 f@mid))
           (find-root f mid right)]))]))