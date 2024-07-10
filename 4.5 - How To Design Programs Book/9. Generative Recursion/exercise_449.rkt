;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_449) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 449.
; As presented in figure 159, find-root computes the value of f
; for each boundary value twice to generate the next interval.
; Use local to avoid this recomputation.

; In addition, find-root recomputes the value of a boundary across recursive calls.
; For example, (find-root f left right) computes (f left) and, if [left,mid]
; is chosen as the next interval, find-root computes (f left) again.

; Introduce a helper function that is like find-root but consumes not only left and right
; but also (f left) and (f right) at each recursive stage.

; How many recomputations of (f left) does this design maximally avoid?
; - 2 recomputations of (f left)
; Note The two additional arguments to this helper function change at each
; recursive stage, but the change is related to the change in the numeric arguments.
; These arguments are so-called accumulators, which are the topic of Accumulators.

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in one of the two
; halves, picks according to assumption 
(define ε 0.00000000000001)
(define (poly n) (* (- n 2) (- n 4))) 

(define (find-root f left right)
  (local ((define f-left  (f  left))
          (define f-right (f right)))
  (cond
    [(<= (- right left) ε) left]
    [else
      (local ((define mid (/ (+ left right) 2))
              (define f@mid (f mid)))
        (cond
          [(or (<= f-left 0 f@mid) (<= f@mid 0 f-left))
           (find-root-2 f left mid f-left f@mid)]
          [(or (<= f@mid 0 f-right) (<= f-right 0 f@mid))
           (find-root-2 f mid right f@mid f-right)]))])))

(define (find-root-2 f left right f-left f-right)
  (cond
    [(<= (- right left) ε) left]
    [else
     (local ((define mid (/ (+ left right) 2))
             (define f@mid (f mid)))
       (cond
         [(or (<= f-left 0 f@mid) (<= f@mid 0 f-left))
           (find-root-2 f left mid f-left f@mid)]
          [(or (<= f@mid 0 f-right) (<= f-right 0 f@mid))
           (find-root-2 f mid right f@mid f-right)]))]))

(check-satisfied (find-root poly 3 6)
                 (lambda (n) (or (<= (- (poly n) (poly 4)) ε)
                                 (<= (- (poly 4) (poly n)) ε))))


(check-satisfied (find-root poly 1 3)
                 (lambda (n) (or (<= (- (poly n) (poly 4)) ε)
                                 (<= (- (poly 4) (poly n)) ε))))

; 3 4.5 6   -1 1.25 8
; 3     4.5 