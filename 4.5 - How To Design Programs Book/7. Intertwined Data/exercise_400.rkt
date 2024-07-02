;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |exercise 400|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 400.
; Design the function DNAprefix.
; The function takes two arguments, both lists of 'a, 'c, 'g, and 't, symbols that occur in DNA descriptions.
; The first list is called a pattern, the second one a search string.
; The function returns #true if the pattern is identical to the initial part of the search string; otherwise it returns #false.


(define PATTERN1 (list 'a 'c 'g 't))
(define PATTERN2 (list 'a 'c 'g 't 'g 'g 'g))
(define PATTERN3 (list 'a 'c 'c 'g 't 'g 'g 'g 'a 't))

(define SEARCH1 (list 'a))
(define SEARCH2 (list 'c))
(define SEARCH3 (list 'a 'c))
(define SEARCH4 (list 'a 'c 't))
(define SEARCH5 (list 'a 'c 'g 't))

(check-expect (DNAprefix '() '()) #true)
(check-expect (DNAprefix '() SEARCH1) #false)
(check-expect (DNAprefix PATTERN3 '()) #true)
(check-expect (DNAprefix PATTERN1 SEARCH1) #true)
(check-expect (DNAprefix PATTERN2 SEARCH1) #true)
(check-expect (DNAprefix PATTERN3 SEARCH1) #true)
(check-expect (DNAprefix PATTERN1 SEARCH2) #false)
(check-expect (DNAprefix PATTERN2 SEARCH2) #false)
(check-expect (DNAprefix PATTERN3 SEARCH2) #false)
(check-expect (DNAprefix PATTERN3 SEARCH3) #true)
(check-expect (DNAprefix PATTERN3 SEARCH4) #false)
(check-expect (DNAprefix PATTERN1 SEARCH5) #true)

(define (DNAprefix pattern search)
  (cond
    [(empty? search) #true]   ;[(and (empty? pattern) (empty? search)) #true]
                              ;[(and (cons? pattern) (empty? search)) #true]
    [(empty? pattern) #false] ;[(and (empty? pattern) (cons? search)) #false]
    [else                     ;[(and (cons? pattern) (cons? search))
     (and (symbol=? (first pattern) (first search)) (DNAprefix (rest pattern) (rest search)))]))

; Also design DNAdelta.
; This function is like DNAprefix but returns the first item in the search string beyond the pattern.
; If the lists are identical and there is no DNA letter beyond the pattern, the function signals an error.
; If the pattern does not match the beginning of the search string, it returns #false.
; The function must not traverse either of the lists more than once.

(check-error (DNAdelta '() '()) "missing")
(check-error (DNAdelta '() SEARCH1) "missing")
(check-expect (DNAdelta PATTERN3 '()) 'a)
(check-expect (DNAdelta PATTERN1 SEARCH1) 'c)
(check-expect (DNAdelta PATTERN2 SEARCH1) 'c)
(check-expect (DNAdelta PATTERN3 SEARCH1) 'c)
(check-expect (DNAdelta PATTERN1 SEARCH2) #false)
(check-expect (DNAdelta PATTERN2 SEARCH2) #false)
(check-expect (DNAdelta PATTERN3 SEARCH2) #false)
(check-expect (DNAdelta PATTERN3 SEARCH3) 'c)
(check-expect (DNAdelta PATTERN3 SEARCH4) #false)
(check-error (DNAdelta PATTERN1 SEARCH5) "missing")

(define (DNAdelta pattern search)
  (cond
    [(empty? pattern) (error "missing")] ;[(and (empty? pattern) (empty? search)) (error "missing")]
                                         ;[(and (empty? pattern) (cons? search)) (error "missing")]
    [(empty? search) (first pattern)]    ;[(and (cons? pattern) (empty? search)) (first pattern)]
    [else                                ;[(and (cons? pattern) (cons? search))
     (if (symbol=? (first pattern) (first search))
         (DNAdelta (rest pattern) (rest search))
         #false)]))

; Can DNAprefix or DNAdelta be simplified?
; yes, both can be simplified by identifying and revising the conditional statements that are doing the same thing.
; see updated examples in code