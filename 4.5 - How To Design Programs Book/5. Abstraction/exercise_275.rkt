;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_275) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 275

(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(define LOCATION "/usr/share/dict/words")
;(define AS-List (read-lines LOCATION))

(define-struct lc [letter count])

(define DICT1 (list "apple" "banana" "blueberry" "fruit"
                    "kiwi" "lemon" "orange" "pineapple" "strawberry"))

;Dictionary -> LC
; Consume a dictionary and produce an LC
(define (most-frequent dict)
  (local [(define (convert-to-lc letter)
            (make-lc letter (generate-wc letter dict)))
          
          (define (generate-wc l los)
            (cond [(empty? los) 0]
                  [else
                   (if (string=? l (substring (first los) 0 1))
                       (+ 1 (generate-wc l (rest los)))
                       (generate-wc l (rest los)))]))
          (define (lc> lc1 lc2)
            (> (lc-count lc1) (lc-count lc2)))]
    
          
    (first (sort (map convert-to-lc LETTERS) lc>))))

(check-expect (most-frequent DICT1) (make-lc "b" 2))
  
