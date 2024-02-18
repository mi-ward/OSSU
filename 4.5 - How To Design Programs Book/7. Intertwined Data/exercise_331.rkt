;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_331) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 331

;Design the function how-many,
;which determines how many files a given Dir.v1 contains.
;Remember to follow the design recipe; exercise 330 provides you with data examples.

; A Dir.v1 (short for directory) is one of: 
; – '()
; – (cons File.v1 Dir.v1)
; – (cons Dir.v1 Dir.v1)
 
; A File.v1 is a String.

(define consv
  (cons (cons "part1" (cons "part2" (cons "part3" '())))
        (cons "read!"
              (cons (cons (cons "hang" (cons "draw" '()))
                          (cons (cons "read!" '()) '())) '()))))


(define Text (list "part1" "part2" "part3"))
(define Code (list "hang" "draw"))
(define Docs (list "read!"))
(define Libs (list Code Docs))
(define TP (list Text "read!" Libs))

(equal? consv TP)

;Dir.v1 -> Number
;determines how many files a Dir.v1 contains
(define (how-many dir)
  (cond [(empty? dir) 0]
        [else (+ (if (string? (first dir))
                     1
                     (how-many (first dir)))
                 (how-many (rest dir)))]))

(check-expect (how-many Docs) 1)
(check-expect (how-many Code) 2)
(check-expect (how-many Libs) 3)
(check-expect (how-many Text) 3)
(check-expect (how-many TP) 7)

               

