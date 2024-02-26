;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_337) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 337
;Use List-of to simplify the data definition Dir.v3.
;Then use ISL+’s list-processing functions from figures
;95 and 96 to simplify the function definition(s) for the
;solution of exercise 336. 

(define-struct file [name size content])

; A File.v3 is a structure: 
;   (make-file String N String)

(define-struct dir.v3 [name dirs files])

; A Dir.v3 is a structure: 
;   (make-dir.v3 String Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir.v3 Dir*) / (List-of Dir.v3)
 
; A File* is one of: 
; – '()
; – (cons File.v3 File*)  / (List-of File.v3)


(define Text (make-dir.v3 "Text" '() (list (make-file "part1" 99 "")
                                           (make-file "part2" 52 "")
                                           (make-file "part3" 17 ""))))
(define Code (make-dir.v3 "Code" '() (list (make-file "hang" 8 "")
                                           (make-file "draw" 2 ""))))
(define Docs (make-dir.v3 "Docs" '() (list (make-file "read!" 19 ""))))
(define Libs (make-dir.v3 "Libs" (list Code Docs) '()))
(define TS (make-dir.v3 "TS" (list Text Libs) (list (make-file "read!" 10 ""))))

;Dir.v3 -> N
;determines how many files are in Dir.v3
(define (how-many? dir)
  (foldr + (length (dir.v3-files dir)) (map how-many? (dir.v3-dirs dir))))


(check-expect (how-many? Text) 3)
(check-expect (how-many? Code) 2)
(check-expect (how-many? Docs) 1)
(check-expect (how-many? Libs) 3)
(check-expect (how-many? TS) 7)
