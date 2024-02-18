;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_332) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 332

;Translate the directory tree in figure 123 into a data representation according to model 2. 

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

(make-dir
 "TS"
 (list
  (make-dir "Text" (list "part1" "part2" "part3"))
  "read!"
  (make-dir
   "Libs"
   (list (make-dir "Code" (list "hang" "draw")) (make-dir "Docs" (list "read!"))))))