;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_336) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 336
;Design the function how-many, which determines how many files
;a given Dir.v3 contains. Exercise 335 provides you with data examples.
;Compare your result with that of exercise 333.

;Given the complexity of the data definition, contemplate how anyone
;can design correct functions. Why are you confident that
;how-many produces correct results?
; -- through testing

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
  (local [(define (traverse-dirs dir)
             (cond [(empty? dir) 0]
                   [else (+ (how-many? (first dir))
                            (traverse-dirs (rest dir)))]))]
    
    (+ (length (dir.v3-files dir))
       (traverse-dirs (dir.v3-dirs dir)))))

     

(check-expect (how-many? Text) 3)
(check-expect (how-many? Code) 2)
(check-expect (how-many? Docs) 1)
(check-expect (how-many? Libs) 3)
(check-expect (how-many? TS) 7)
