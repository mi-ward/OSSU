;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Evaluation Rules|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Local is just an expression, doesn't evaluate stuff outside of it

(define b 1)

(+ b
   (local [(define b 2)]
     (* b b))
   b)

(+ 1
   (local [(define b 2)]
     (* b b))
   b)

;1. Renameing
;2. Lifting
;3. Replace local expression

;1 <- rename to a global unique name
(+ 1
   (local [(define b_0 2)]
     (* b_0 b_0))
   b)

;2 <- lift out the definition
(define b_0 2)

;3 <- now it's just a global expression
(+ 1
   (* b_0 b_0)
   b)


(+ 1
   (* 2 b_0)
   b)

(+ 1
   (* 2 2)
   b)

(+ 1
   4
   b)

(+ 1
   4
   1)

6

