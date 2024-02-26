;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_333) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 333

;Design the function how-many, which determines how many files
;a given Dir.v2 contains. Exercise 332 provides you with data examples.
;Compare your result with that of exercise 331.

(define-struct dir [name content])

; A Dir.v2 is a structure: 
;   (make-dir String LOFD)
 
; An LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a String. 

(define Text (make-dir "Text" (list "part1" "part2" "part3")))
(define Code (make-dir "Code" (list "hang" "draw")))
(define Docs (make-dir "Docs" (list "read!")))
(define Libs (make-dir "Libs" (list Code Docs)))
(define TS (make-dir "TS" (list Text "read!" Libs)))

;Dir.v2 -> Number
;determines how many files a given Dir.v2 contains


(define (how-many? dir)
  (foldr + 0 (map (lambda (d) (if (string? d) 1 (how-many? item)))
                  (dir-content dir))))

(check-expect (how-many? Docs) 1)
(check-expect (how-many? Code) 2)
(check-expect (how-many? Libs) 3)
(check-expect (how-many? Text) 3)
(check-expect (how-many? TS) 7)

