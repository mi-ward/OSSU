;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_341) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)

;Exercise 341
;Design du, a function that consumes a Dir and computes the total size of all the files in the entire directory tree.
;Assume that storing a directory in a Dir structure costs 1 file storage unit.
;In the real world, a directory is basically a special file, and its size depends on how large its associated directory is.

(define OSSU1 (create-dir "/Users/michael/dev/OSSU"))
(define OSSU2 (create-dir "/Users/michael/dev/OSSU/4.5 - How To Design Programs Book/7. Intertwined Data"))
(define OSSU3 (create-dir "/Users/michael/dev/OSSU/4.5 - How To Design Programs Book"))

(define Text (make-dir "Text" '() (list (make-file "part1" 99 "")
                                        (make-file "part2" 52 "")
                                        (make-file "part3" 17 ""))))
(define Code (make-dir "Code" '() (list (make-file "hang" 8 "")
                                        (make-file "draw" 2 ""))))
(define Docs (make-dir "Docs" '() (list (make-file "read!" 19 ""))))
(define Libs (make-dir "Libs" (list Code Docs) '()))
(define TS (make-dir "TS" (list Text Libs) (list (make-file "read!" 10 ""))))

;Dir -> Number

(check-expect (du OSSU1) 339644763)
(check-expect (du TS) (+ 99 52 17 1 8 2 1 19 1 1 10 1))
(check-expect (du Libs) 32)
(check-expect (du Code) 11)

(define (du dir)
  (foldr + (foldr + 1 (map file-size (dir-files dir)))
         (map du (dir-dirs dir))))
