;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_288) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 288.
;Use build-list and lambda to define a function that
;creates the list (list 0 ... (- n 1)) for any natural number n;

;Number -> List
;creates the list (list 0 ... (- n 1)) for any natural number n
(define (count i)
  (build-list i (lambda (x) x)))

(check-expect (count 10) (list 0 1 2 3 4 5 6 7 8 9))

;creates the list (list 1 ... n) for any natural number n;
;Number -> List
;creates the list (list 1 ... n) for any natural number n
(define (non-zero-index-count i)
  (build-list i (lambda (x) (+ x 1))))

(check-expect (non-zero-index-count 10) (list 1 2 3 4 5 6 7 8 9 10))

;creates the list (list 1 1/2 ... 1/n) for any natural number n;
;Number -> List
;creates the list (list 1 1/2 ... 1/n) for any natural number n
(define (fractize n)
  (build-list n (lambda (x) (/ 1 (add1 x)))))

(check-expect (fractize 8) (list 1 1/2 1/3 1/4 1/5 1/6 1/7 1/8))

;creates the list of the first n even numbers; and
(define (evens n)
  (build-list n (lambda (x) (* (add1 x) 2))))

(check-expect (evens 5) (list 2 4 6 8 10))

;creates a diagonal square of 0s and 1s; see exercise 262.
(define (diagonal i)
  (build-list i (lambda (x) (build-list i (lambda (y) (if (= x y) 1 0))))))

(check-expect (diagonal 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))

;Also define tabulate with lambda.
;Design tabulate, which is the abstraction of the two functions
;in figure 92. When tabulate is properly designed,
;use it to define a tabulation function for sqr and tan.

;Fn [List-of Number] -> [List-of Number]
;You can input a function and it applies it to 0 up to n-1
(define (tabulate fn n)
  (cons (fn 0) (build-list n (lambda (x) (fn (add1 x))))))

(check-expect (tabulate sqr 5) (list (sqr 0) (sqr 1) (sqr 2) (sqr 3) (sqr 4) (sqr 5)))
(check-within (tabulate sqrt 5) (list (sqrt 0) (sqrt 1) (sqrt 2) (sqrt 3) (sqrt 4) (sqrt 5)) .001)
(check-within (tabulate tan 5) (list (tan 0) (tan 1) (tan 2) (tan 3) (tan 4) (tan 5)) .001)


