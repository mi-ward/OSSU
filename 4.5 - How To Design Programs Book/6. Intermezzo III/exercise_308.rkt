;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_308) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)
;Exercise 308
;Design the function replace, which substitutes the area code 713 with
;281 in a list of phone records.
(define-struct phone [area switch four])

;[List-of Phone] -> [List-of Phone]
;substitutes the area code 713 with 281 in a list of phone records.
(define (replace lop)
  (for/list ([p lop])
    (match p
      [(phone 713 switch four)
       (make-phone 281 switch four)])))

(check-expect (replace (list (make-phone 713 555 5555)
                             (make-phone 713 999 9999)
                             (make-phone 713 123 1234)))
              (list (make-phone 281 555 5555)
                    (make-phone 281 999 9999)
                    (make-phone 281 123 1234)))

