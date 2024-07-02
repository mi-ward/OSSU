;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |exercise 404|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 404
; Design the function andmap2.
; It consumes a function f from two values to Boolean and two equally long lists.
; Its result is also a Boolean. Specifically, it applies f to pairs of
; corresponding values from the two lists, and if f always produces #true, andmap2
; produces #true, too. Otherwise, andmap2 produces #false.

; In short, andmap2 is like andmap but for two lists.

(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)

(define-struct spec [label predicate])
; Spec is a structure: (make-spec Label Predicate)

 
; A Schema is a [List-of Spec]
; A Spec is a [List Label Predicate]
; A Label is a String
; A Predicate is a [Any -> Boolean]
 
; A (piece of) Content is a [List-of Row]
; A Row is a [List-of Cell]
; A Cell is Any
; constraint cells do not contain functions 
 
; integrity constraint In (make-db sch con), 
; for every row in con,
; (I1) its length is the same as sch's, and
; (I2) its ith Cell satisfies the ith Predicate in sch

(define ROW1 (list "Alice" 35 #true))
(define ROW2 (list "Bob" 25 #false))
(define ROW3 (list "Carol" 30 #true))
(define ROW4 (list "Dave" 32 #false))
(define ROW5 (list #true "presence"))
(define ROW6 (list #false "absence"))
(define ROW7 (list "John" 36 #false '()))
                    
(define SPEC1 (list "Name"        string?))  ;(list "Name"        string?)) 
(define SPEC2 (list "Number"      integer?)) ;(list "Number"      integer?))
(define SPEC3 (list "Present"     boolean?)) ;(list "Present"     boolean?))
(define SPEC4 (list "Present"     boolean?)) ;(list "Present"     boolean?))
(define SPEC5 (list "Description" string?))  ;(list "Description" string?))

(define SCHEMA1 (list SPEC1 SPEC2 SPEC3 ))
(define SCHEMA2 (list SPEC4 SPEC5))

(define CONTENT1 (list ROW1 ROW2 ROW3 ROW4))
(define CONTENT2 (list ROW5 ROW6))
(define CONTENT3 (list ROW7))

(define DB1 (make-db SCHEMA1 CONTENT1))
(define DB2 (make-db SCHEMA2 CONTENT2))
(define DB3 (make-db SCHEMA1 CONTENT3))
  

(define (andmap2 f lst1 lst2)
  (cond
    [(and (empty? lst1) (empty? lst2)) #true]
    [(and (cons?  lst1) (empty? lst2)) #false]
    [(and (empty? lst1) (cons?  lst2)) #false]
    [(and (cons?  lst1) (cons?  lst2))
     (and (f (first lst1) (first lst2))
          (andmap2 f (rest lst1) (rest lst2)))]))

(check-expect (andmap2 = (list 1 2 3 4) (list 1 2 3 4)) #true)
(check-expect (andmap2 = (list 1 2 3 4) (list 1 2 3 5)) #false)

; DB -> Boolean
; do all rows in db satisfy (I1) and (I2)
 
(check-expect (integrity-check DB1) #true)
(check-expect (integrity-check DB2) #true)
(check-expect (integrity-check DB3) #false)

#;
(define (integrity-check db)
  (local (; Row -> Boolean
          ; does row satisfy (I1) and (I2)
          (define (row-integrity-check row)
            (and (= (length row)
                    (length (db-schema db)))
                 (andmap (lambda (s c) [(second s) c])
                         (db-schema db)
                         row))))
    (andmap row-integrity-check (db-content db))))

#;
(define (integrity-check.v2 db)
  (local ((define schema (db-schema db))
          ; Row -> Boolean
          ; does row satisfy (I1) and (I2)
          (define (row-integrity-check row)
            (and (= (length row)
                    (length (db-schema db)))
                 (andmap (lambda (s c) [(second s) c])
                         schema
                         row))))
    (andmap row-integrity-check (db-content db))))

(define (integrity-check.v3 db)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
          (define width   (length schema))
          ; Row -> Boolean
          ; does row satisfy (I1) and (I2)
          (define (row-integrity-check row)
            (and (= (length row)
                    (length (db-schema db)))
                 (andmap (lambda (s c) [(second s) c])
                         schema
                         row))))
    (andmap row-integrity-check (db-content db))))

