#lang racket

(provide (all-defined-out))

;; Homework 4, August 20, 2024



;; 1. sequence Function Definition


(define (sequence low high stride)
  (let ([next-n (+ low stride)])
    (cond [(< high low) null]
          [(<= next-n high) (append (list low) (sequence next-n high stride))]
          [else (cons low empty)])))


;; 2. string-append-map Function Definition


(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))


;; 3. list-nth-mod Function Definition


(define (list-nth-mod lox n)
  (cond [(< n 0)      (error "list-nth-mod: negative number")]
        [(empty? lox) (error "list-nth-mod: empty list")]
        [else (list-ref lox (remainder n (length lox)))]))


;; 4. stream-for-n-steps Function Definition


(define (stream-for-n-steps s n)
  (let ([memo null] [current-n (s)])
    (cond [(equal? n 0) memo]
          [else (append memo (list (car current-n)) (stream-for-n-steps (cdr current-n) (- n 1)))])))


;; 5. funny-number-stream Function Definition


(define funny-number-stream
  (letrec ([f (lambda (x) (if (equal? (remainder x 5) 0) (cons (- x (* x 2)) (lambda () (f (+ x 1)))) (cons x (lambda () (f (+ x 1))))))])
    (lambda () (f 1))))


;; 6. dan-then-dog Function Definition


(define dan-then-dog
  (letrec ([f (lambda (x) (if (equal? x 0) (cons "dan.jpg" (lambda () (f 1))) (cons "dog.jpg" (lambda () (f 0)))))])
    (lambda () (f 0))))


;; 7. stream-add-zero Function Definition

(define (stream-add-zero s)
  (letrec ([n (s)][f (lambda () (cons (cons 0 (car n)) (stream-add-zero (cdr n))))])
    (lambda () (f))))


;; 8. cycle-list Function Definition


(define (cycle-lists xs ys)
  (letrec ([f (lambda (x y tx ty) (cons (cons x y) (fn-for-lox tx ty)))]
           [fn-for-lox (lambda (tx ty) (cond [(and (null? tx) (null? ty)) (lambda () (f (car xs) (car ys) (cdr xs) (cdr ys)))]
                                             [(null? tx)                  (lambda () (f (car xs) (car ty) (cdr xs) (cdr ty)))]
                                             [(null? ty)                  (lambda () (f (car tx) (car ys) (cdr tx) (cdr ys)))]
                                             [else                        (lambda () (f (car tx) (car ty) (cdr tx) (cdr ty)))]))])
    (lambda () (f (car xs) (car ys) (cdr xs) (cdr ys)))))


;; 9. vector-assoc Function Definition


(define (vector-assoc v vec)
  (letrec ([vec-lgth (vector-length vec)]
           [fn-for-vec (lambda (current) (cond [(= current vec-lgth) #f]
                                               [(pair? (vector-ref vec current)) (if (equal? (car (vector-ref vec current)) v) (vector-ref vec current) (fn-for-vec (+ current 1)))]
                                               [else (fn-for-vec (+ current 1))]))])
    (fn-for-vec 0)))


;; 10. cached-assoc Function Definition


(define (cached-assoc xs n)
  (letrec ([cache (make-vector n (cons #f #f))] [vxs (list->vector xs)] [index 0]
           [fn-for-xs (lambda (v) (cond [(> index (- n 1)) (set! index 0) (fn-for-xs v)]
                                        [(vector-assoc v cache)]
                                        [(vector-assoc v   vxs) (vector-set! cache index v) (set! index (+ index 1)) (vector-assoc v vxs)]))])
    fn-for-xs))



