;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |exercise 403|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)
 
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

; Exercise 403.
; A Spec combines a Label and a Predicate into a list.
; While acceptable, this choice violates our guideline of using a
; structure type for a fixed number of pieces of information.

;Here is an alternative data representation:

(define-struct spec [label predicate])
; Spec is a structure: (make-spec Label Predicate)
; Use this alternative definition to represent the databases from figure 137.

(define ROW1 (list "Alice" 35 #true))
(define ROW2 (list "Bob" 25 #false))
(define ROW3 (list "Carol" 30 #true))
(define ROW4 (list "Dave" 32 #false))
(define ROW5 (list #true "presence"))
(define ROW6 (list #false "absence"))
                    
(define SPEC1 (make-spec "Name"        string?))  ;(list "Name"        string?)) 
(define SPEC2 (make-spec "Number"      integer?)) ;(list "Number"      integer?))
(define SPEC3 (make-spec "Present"     boolean?)) ;(list "Present"     boolean?))
(define SPEC4 (make-spec "Present"     boolean?)) ;(list "Present"     boolean?))
(define SPEC5 (make-spec "Description" string?))  ;(list "Description" string?))

(define SCHEMA1 (list SPEC1 SPEC2 SPEC3 ))
(define SCHEMA2 (list SPEC4 SPEC5))

(define CONTENT1 (list ROW1 ROW2 ROW3 ROW4))
(define CONTENT2 (list ROW5 ROW6))

(define DB1 (make-db SCHEMA1 CONTENT1))
(define DB2 (make-db SCHEMA2 CONTENT2))