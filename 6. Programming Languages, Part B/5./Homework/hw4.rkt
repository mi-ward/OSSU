
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (stream x) (cons x (lambda () (stream (+ x 1)))))
(define nats (stream 1))

(define (sequence low high stride)
  (cond [(> low high) null]
        [#t (cons low (sequence (+ low stride) high stride))]))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

(define (list-nth-mod xs n)
  (cond
    [(< n 0)    (error "list-nth-mod: negative number")]
    [(null? xs)      (error "list-nth-mod: empty list")]
    [#t (car (list-tail xs (remainder n (length xs))))]))

(define (stream-for-n-steps s n)
  (if (= 0 n)
      null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))


(define funny-number-stream
  (letrec ([f (lambda (x) (cons x (lambda () (f (if (= (modulo (+ x 1) 5) 0)
                                                    (- (+ x 1))
                                                    (+ (abs x) 1))))))])
    (lambda () (f 1))))

(define dan-then-dog
  (letrec ([f (lambda (x) (cons x (lambda () (f (if (string=? "dan.jpg" x)
                                                    "dog.jpg"
                                                    "dan.jpg")))))])
    (lambda () (f "dan.jpg"))))

(define (stream-add-zero s)
  (lambda () (cons
              (cons 0 (car (s)))
              (stream-add-zero (cdr (s))))))

(define (cycle-lists xs ys)
  (letrec ([cycle-lists-aux (lambda (lst1 lst2 acc) 
                              (cons (cons (list-nth-mod lst1 acc)
                                          (list-nth-mod lst2 acc))
                                    (lambda () (cycle-lists-aux lst1 lst2 (+ 1 acc)))))])
    (lambda () (cycle-lists-aux xs ys 0))))

(define (vector-assoc v vec)
  (letrec ([vector-assoc-aux (lambda (v vec acc)
                               (cond
                                 [(equal? (vector-length vec) acc) #f]
                                 [(pair? (vector-ref vec acc)) (if (equal? (car (vector-ref vec acc)) v)
                                                                   (vector-ref vec acc)
                                                                   (vector-assoc-aux v vec (+ 1 acc)))]
                                 [#t (vector-assoc-aux v vec (+ 1 acc))]))])
    (vector-assoc-aux v vec 0)))
                                                                 
(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [i 0]
           [f (lambda (x)
                (let ([ans (vector-assoc x memo)])
                  (if ans
                      ans
                      (let ([new-ans (assoc x xs)])
                        (if new-ans
                            (begin (vector-set! memo i new-ans)
                                   (set! i (if (= (+ i 1) n)
                                               0
                                               (+ i 1))) new-ans)
                            #f)))))])
    f))

;(define-syntax while-less
;  (syntax-rules (do)
;    [(while-less e1 do e2)
;     (if (> e2 e1)
;         #t
;         (
    

 
  
  
  
           
    


  

  
      
