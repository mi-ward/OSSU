;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_283) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 283
(define-struct IR [name price])
(define th 10)
;Confirm that DrRacket’s stepper can deal with lambda.
;Use it to step through the third example and also to
;determine how DrRacket evaluates the following expressions:

((lambda (ir) (<= (IR-price ir) th))
 (make-IR "bear" 10))
(<= (IR-price (make-IR "bear" 10)) th)
(<= 10 th)
(<= 10 10)
#true
;==
(map (lambda (x) (* 10 x))
     '(1 2 3))
(list (* 10 1) (* 10 2) (* 10 3))
(list 10 20 30)

 
(foldl (lambda (name rst)
         (string-append name ", " rst))
       "etc."
       '("Matthew" "Robby"))
"Robby, Matthew, etc."


(filter (lambda (ir) (<= (IR-price ir) th))
        (list (make-IR "bear" 10)
              (make-IR "doll" 33)))
(list (make-IR "bear" 10))
