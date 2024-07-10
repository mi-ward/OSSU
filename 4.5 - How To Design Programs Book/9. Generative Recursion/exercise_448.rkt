;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_448) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 448.
; The find-root algorithm terminates for all (continuous) f, left, and right
; for which the assumption holds. Why? Formulate a termination argument.

; - Because we keep recurring until the intervals are small enough to satisfy
;   right minus left being less than our constant.

; Hint Suppose the arguments of find-root describe an interval of size S1.
; How large is the distance between left and right for the
; first and second recursive call to find-root?
;  - First call, S1 / 2
;  - Second call, S1 / 2 / 2
; After how many steps is (- right left) smaller than or equal to ε?
; - in as many as are necessary provided the assumptions hold true



(define ε 0.0000001)

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))

;(check-satisfied (find-root poly 3 6)
 ;                (lambda (n) (or (<= (- (poly n) (poly 4)) ε)
  ;                               (<= (- (poly 4) (poly n)) ε))))


; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in one of the two
; halves, picks according to assumption
; termination (find root f left root) loops unless:
; - (1) f is not continuous
; - (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left))) is not true
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


#;
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
