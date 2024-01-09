;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_275) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 275
(require 2htdp/batch-io)

(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(define LOCATION "/usr/share/dict/words")
(define AS-List (read-lines LOCATION))

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
(check-expect (most-frequent AS-List) (make-lc "s" 22759))

;Dictionary -> List-of Dictionary
; creates a list of dictionaries, one per letter
(define (words-by-first-letter dict)
  (local [(define (generate-words-per-letter letter los)
            (cond [(empty? los) '()]
                  [else
                   (if (string=? letter (substring (first los) 0 1))
                       (cons (first los) (generate-words-per-letter letter (rest los)))
                       (generate-words-per-letter letter (rest los)))]))
          (define (generate-dict letter)
            (generate-words-per-letter letter dict))
          (define (full? lst)
            (not (empty? lst)))]
    (filter full? (map generate-dict LETTERS))))

(check-expect (words-by-first-letter DICT1) (list
                                             (list "apple")
                                             (list "banana" "blueberry")
                                             (list "fruit")
                                             (list "kiwi")
                                             (list "lemon")
                                             (list "orange")
                                             (list "pineapple")
                                             (list "strawberry")))
          
          


