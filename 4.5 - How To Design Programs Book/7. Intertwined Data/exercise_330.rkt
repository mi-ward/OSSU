;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_330) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 330

;Translate the directory tree in figure 123
;into a data representation according to model 1.

; A Dir.v1 (short for directory) is one of: 
; – '()
; – (cons File.v1 Dir.v1)
; – (cons Dir.v1 Dir.v1)
 
; A File.v1 is a String.

(define listv
  (list (list "part1" "part2" "part3")
        "read!"
        (list (list "hang" "draw")
              (list "read!"))))

(define consv
  (cons (cons "part1" (cons "part2" (cons "part3" '())))
        (cons "read!"
        (cons (cons (cons "hang" (cons "draw" '()))
              (cons (cons "read!" '()) '())) '()))))

(equal? listv consv)
