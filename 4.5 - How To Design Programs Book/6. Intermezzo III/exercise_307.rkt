;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_307) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)
;Exercise 307
;Define find-name
;The function consumes a name and a list of names.
;It retrieves the first name on the latter that is equal to,
;or an extension of, the former.


;String [List-of String] -> String
;It retrieves the first name on the latter that is equal to,
;or an extension of, the former.
(define (find-name name lon)
  (for/or ([n lon])
    (if (or (string=? name n)
            (string=? name (substring n 0 (string-length name))))
        n
        #false)))
        
(check-expect (find-name "dan" (list "steve" "daniel" "dan")) "daniel")


;Define a function that ensures that no name on some list of names exceeds
;some given width. Compare with exercise 271.

(define (no-name-exceeds n lon)
  (for/and ([name lon])
    (if (> (string-length name) n) #false #true)))

(check-expect (no-name-exceeds 5 (list "peter" "jeffery" "steve")) #false)
(check-expect (no-name-exceeds 5 (list "peter" "jeff" "steve")) #true)
        