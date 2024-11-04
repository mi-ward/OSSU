;; Programming Languages, Homework 5

#lang racket

(provide (all-defined-out))

;; ==========================================
;; Definition of structures for MUPL programs
;; ==========================================

(struct var       (string)              #:transparent) ;; a variable, e.g., (var "foo")
(struct int       (num)                 #:transparent) ;; a constant number, e.g., (int 17)
(struct add       (e1 e2)               #:transparent) ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)         #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun       (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call      (funexp actual)       #:transparent) ;; function call
(struct mlet      (var e body)          #:transparent) ;; a local binding (let var = e in body) 
(struct apair     (e1 e2)               #:transparent) ;; make a new pair
(struct fst       (e)                   #:transparent) ;; get first part of a pair
(struct snd       (e)                   #:transparent) ;; get second part of a pair
(struct aunit     ()                    #:transparent) ;; unit value -- good for ending a list
(struct isaunit   (e)                   #:transparent) ;; evaluate to 1 if e is unit else 0
(struct closure  (env fun)             #:transparent) ;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to

;; =========
;; Problem 1
;; =========

(define (racketlist->mupllist xs)
  (cond [(null? xs) (aunit)]
        [else (apair (car xs) (racketlist->mupllist (cdr xs)))]))

(define (mupllist->racketlist xs)
  (cond [(aunit? xs) empty]
        [else (cons (apair-e1 xs) (mupllist->racketlist (apair-e2 xs)))]))

;; =========
;; Problem 2
;; =========

(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

(define (eval-under-env e env)
  (cond [(var? e)       (envlookup env (var-string e))]
        [(int? e)       e]
        [(closure? e)   e]
        [(aunit? e)     e]
        [(add? e)       (let ([v1 (eval-under-env (add-e1 e) env)] [v2 (eval-under-env (add-e2 e) env)])
                          (if (and (int? v1) (int? v2)) (int (+ (int-num v1) (int-num v2))) (error "MUPL addition applied to non-number")))]
        [(ifgreater? e) (let ([v1 (eval-under-env (ifgreater-e1 e) env)] [v2 (eval-under-env (ifgreater-e2 e) env)])
                          (if (and (int? v1) (int? v2))
                              (if (> (int-num v1) (int-num v2)) (eval-under-env (ifgreater-e3 e) env) (eval-under-env (ifgreater-e4 e) env))
                              (error "MUPL ifgreater applied to non-number")))]
        [(fun? e)       (closure env e)]
        [(mlet? e)      (let ([v1 (eval-under-env (mlet-e e) env)]) (eval-under-env (mlet-body e) (append env (list (cons (mlet-var e) v1)))))] 
        [(call? e)      (let ([v1 (eval-under-env (call-funexp e) env)] [v2 (eval-under-env (call-actual e) env)])
                          (if (closure? v1)
                              (let ([fn-body (fun-body (closure-fun v1))] [arg-name (fun-formal (closure-fun v1))] [clo-env (closure-env v1)] [fn-name (fun-nameopt (closure-fun v1))])
                                (eval-under-env fn-body (append clo-env (list (cons arg-name v2) (if fn-name (cons fn-name v1) '())))))
                              (error "MUPL call applied to non-closure")))]
        [(apair? e)     (apair (eval-under-env (apair-e1 e) env) (eval-under-env (apair-e2 e) env))]
        [(fst? e)       (if (apair? (eval-under-env (fst-e e) env)) (apair-e1 (eval-under-env (fst-e e) env)) (error "MUPL fst applied to non-pair"))]
        [(snd? e)       (if (apair? (eval-under-env (snd-e e) env)) (apair-e2 (eval-under-env (snd-e e) env)) (error "MUPL snd applied to non-pair"))]
        [(isaunit? e)   (if (aunit? (eval-under-env (isaunit-e e) env)) (int 1) (int 0))]
        [#t             (error (format "bad MUPL expression: ~v" e))]))

(define (eval-exp e)
  (eval-under-env e null))

;; =========
;; Problem 3
;; =========

(define (ifaunit e1 e2 e3)
  (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lst e2)
  (if (null? lst)
      e2
      (let ([v (first lst)])
	(mlet (car v) (cdr v) (mlet* (cdr lst) e2)))))

(define (ifeq e1 e2 e3 e4)
  (mlet* (list (cons "_x" e1) (cons "_y" e2))
	 (ifgreater (var "_x") (var "_y") e4
		    (ifgreater (var "_y") (var "_x") e4 e3))))

;; =========
;; Problem 4
;; =========

(define mupl-map
  (fun "map-fn" "fn"
       (fun "map-lst" "xs"
            (ifaunit (var "xs") (aunit)
                     (apair (call (var "fn") (fst (var "xs")))
                            (call (var "map-lst") (snd (var "xs"))))))))

(define mupl-mapAddN 
  (mlet "map" mupl-map
        (fun "fn" "i"
             (fun "fn-xs" "xs"
                  (call (call (var "map") (fun "add-i" "x" (add (var "x") (var "i")))) (var "xs"))))))

(eval-exp (call (call mupl-mapAddN (int 5)) (apair (int 1) (apair (int 2) (apair (int 3) (apair (int 4) (apair (int 5) (aunit))))))))

;; =================
;; Challenge Problem
;; =================

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
