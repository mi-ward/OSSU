;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname hw5) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define (racketlist->mupllist lst)
  (if (null? lst)
      (aunit)
      (apair (car lst) (racketlist->mupllist (cdr lst)))))


(define (mupllist->racketlist lst)
  (cond
    [(isaunit lst) '()]
    [(pair? lst) (cons (fst lst) (mupllist->racketlist (snd lst)))]))

(define (eval-exp e env)
  (match e
    [(int n) e]
    [(var s) (envlookup s env)]
    [(add e1 e2) 
     (let ([v1 (eval-exp e1 env)]
           [v2 (eval-exp e2 env)])
       (if (and (int? v1) (int? v2))
           (int (+ (int-val v1) (int-val v2)))
           (error "Type error in addition")))]
    ;; Add other cases here
    ))

(define (envlookup s env)
  (match env
    [(list) (error "unbound variable")]
    [(cons (cons s1 v) rest) (if (string=? s s1) v (envlookup s rest))]))

(define (ifaunit e1 e2 e3)
  (ifgreater (isaunit e1) (int 0) e3 e2))

(define (mlet* bindings body)
  (if (null? bindings)
      body
      (mlet (car (car bindings))
            (cdr (car bindings))
            (mlet* (cdr bindings) body))))

(define (ifeq e1 e2 e3 e4)
  (mlet ((_x e1) (_y e2))
        (ifgreater (add (add _x _y) (int -2)) (int 0) e3 e4)))

(define mupl-map
  (fun #f "f"
       (fun #f "lst"
            (ifaunit (var "lst")
                     (aunit)
                     (apair (call (var "f") (fst (var "lst")))
                            (call (call (var "mupl-map") (var "f")) (snd (var "lst")))))))

  (define mupl-mapAddN
  (fun #f "n"
       (mlet ("f" (fun #f "x" (add (var "x") (var "n"))))
             (call (var "mupl-map") (var "f")))))


  (define (compute-free-vars exp)
  ;; Function implementation here
  )

(define (eval-exp-c e env)
  ;; Modified interpreter implementation here
  )
