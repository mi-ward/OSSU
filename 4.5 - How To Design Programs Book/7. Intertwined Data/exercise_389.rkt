;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_389) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 389.
; Design the zip function, which consumes a list of names, represented as strings, and a list of phone numbers, also strings.
; It combines those equally long lists into a list of phone records:
(define-struct phone-record [name number])

; A PhoneRecord is a structure:
;   (make-phone-record String String)

; Assume that the corresponding list items belong to the same person.

; [List-of String] [List-of String] -> [List-of phone-record]

(define (zip names numbers)
  (cond
    [(empty? names) '()]
    [else
     (cons (make-phone-record (first names) (first numbers)) (zip (rest names) (rest numbers)))]))

(check-expect (zip '() '()) '())
(check-expect (zip (list "Jim") (list "555-7878")) (list (make-phone-record "Jim" "555-7878")))
(check-expect (zip (list "Jim" "Janet") (list "555-7878" "555-1234")) (list (make-phone-record "Jim" "555-7878") (make-phone-record "Janet" "555-1234")))
(check-expect (zip (list "Jim" "Janet" "John") (list "555-7878" "555-1234" "555-0911"))
              (list (make-phone-record "Jim" "555-7878") (make-phone-record "Janet" "555-1234") (make-phone-record "John" "555-0911")))