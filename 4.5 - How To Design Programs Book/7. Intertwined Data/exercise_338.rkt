;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_338) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)

;Exercise 338

;Use create-dir to turn some of your directories into ISL+ data representations.
;Then use how-many from exercise 336 to count how many files they contain.

;Why are you confident that how-many produces correct results for these directories?
; because of my previous tests I ran

(define (how-many? dir)
    (foldr + (length (dir-files dir)) (map how-many? (dir-dirs dir))))

(define OSSU (create-dir "/Users/michael/dev/OSSU"))
(define OSSU2 (create-dir "/Users/michael/dev/OSSU/4.5 - How To Design Programs Book/7. Intertwined Data"))

(how-many? OSSU2)
