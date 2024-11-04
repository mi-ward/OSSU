;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

(define (racketlist->mupllist rlst)
  (cond [(null? rlst) (aunit)]
        [(apair (car rlst) (racketlist->mupllist (cdr rlst)))]))

(define (mupllist->racketlist mlst)
  (cond [(aunit? mlst) null]
        [(cons (apair-e1 mlst) (mupllist->racketlist (apair-e2 mlst)))]))
                      
;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) (envlookup env (var-string e))]
        [(int? e) (int (int-num e))]
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1) (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL ifgreater applied to non-number")))]
        [(fun? e) (closure env (fun (fun-nameopt e) (fun-formal e) (fun-body e)))]
        [(call? e)
         (let ([c (eval-under-env (call-funexp e) env)]
               [a (eval-under-env (call-actual e) env)])
           (if (closure? c)
               (let ([f    (closure-fun c)]
                     [cenv (closure-env c)])
                 (if (fun-nameopt f)
                     (eval-under-env (fun-body f) (append cenv (list (cons (fun-nameopt f) c) (cons (fun-formal f) a))))
                     (eval-under-env (fun-body f) (append cenv (list (cons (fun-formal f) a))))))
               (error "MUPL call applied to non-fun")))]
        [(mlet? e)
         (let ([v1 (mlet-var e)]
               [v2 (eval-under-env (mlet-e e) env)])
           (eval-under-env (mlet-body e) (append env (list (cons v1 v2)))))]
        
        [(apair? e) (apair (eval-under-env (apair-e1 e) env) (eval-under-env (apair-e2 e) env))]
        [(fst? e)   (if (apair? (eval-under-env (fst-e e) env)) (apair-e1 (eval-under-env (fst-e e) env)) (error "MUPL fst applied to non-pair"))]
        [(snd? e)   (if (apair? (eval-under-env (snd-e e) env)) (apair-e2 (eval-under-env (snd-e e) env)) (error "MUPL snd applied to non-pair"))]
        [(closure? e) e]
        [(isaunit? e) (if (aunit? (eval-under-env (isaunit-e e) env)) (int 1) (int 0))]
        [(aunit? e) (aunit)]
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3) (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (cond
    [(null? lstlst) e2]
    [(mlet* (cdr lstlst) (mlet (car (car lstlst)) (cdr (car lstlst))  e2))]))
          

(define (ifeq e1 e2 e3 e4) (mlet "_x" e1
                                 (mlet "_y" e2
                                       (ifgreater (var "_x")
                                                  (var "_y")
                                                  e4
                                                  (ifgreater (var "_y") (var "_x") e4 e3)))))
                                      
                                      
                                      

;; Problem 4

(define mupl-map (fun #f "map" (fun "f2" "lst"
                                    (ifaunit (var "lst")
                                             (aunit)
                                             (apair (call (var "map") (fst (var "lst"))) (call (var "f2") (snd (var "lst"))))))))

(define mupl-mapAddN
  (mlet "map" mupl-map
        (fun #f "i"
             (fun #f "lst"
                  (call (call (var "map") (fun #f "x" (add (var "x") (var "i")))) (var "lst"))))))


;; Challenge Problem

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

; All values (including closures) evaluate to themselves. For example, (eval-exp (int 17)) would return (int 17), not 17.
;Int
(eval-exp (int 5)) 

;Add
(eval-exp (add (int 5) (int 10))) 

; An ifgreater evaluates its first two subexpressions to values v1 and v2 respectively.
; If both values are integers, it evaluates its third subexpression if v1 is a
; strictly greater integer than v2 else it evaluates its fourth subexpression.
;ifgreater
(ifgreater (int 5) (int 4) (int 3) (int 2))
(eval-exp (ifgreater (int 5) (int 4) (int 3) (int 2)))
(eval-exp (ifgreater (int 5) (int 6) (int 3) (int 2)))

;A pair expression evaluates its two subexpressions and produces a (new) pair holding the results.
;Pair
(eval-exp (apair (add (int 5) (int 10)) (int 22)))

; A fst expression evaluates its subexpression. If the result for the subexpression is a pair,
; then the result for the fst expression is the e1 field in the pair.
;fst
(eval-exp (fst (apair (int 15) (int 22))))

; A snd expression evaluates its subexpression. If the result for the subexpression is a pair, then
; the result for the snd expression is the e2 field in the pair.
;snd
(eval-exp (snd (apair (int 15) (int 22))))
