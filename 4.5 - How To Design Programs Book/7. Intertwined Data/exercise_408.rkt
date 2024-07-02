;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_408) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 408.
; Design the function select.
; It consumes a database, a list of labels, and a predicate on rows.
; The result is a list of rows that satisfy the given predicate,
; projected down to the given set of labels.

(define-struct db [schema content])

(define school-schema
  `(("Name"    ,string?)
    ("Age"     ,integer?)
    ("Present" ,boolean?)))
 
(define school-content
  `(("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))

(define school-db
  (make-db school-schema
           school-content))

(define projected-content
  `(("Alice" #true)
    ("Bob"   #false)
    ("Carol" #true)
    ("Dave"  #false)))

(define projected-schema
  `(("Name" ,string?) ("Present" ,boolean?)))

(define projected-db
  (make-db projected-schema projected-content))

(define (project db labels)
  (local ((define schema (db-schema db))
          (define content (db-content db))
          ; Spec -> Boolean
          ; does this spec belong to the new schema
          (define (keep? c)
            (member? (first c) labels))
          ; Row -> Row
          ; retains those columns whose name is in labels
          ; in names is also in lables
          (define (row-project row)
            (foldr (lambda (cell m c) (if m (cons cell c) c))
                   '()
                   row
                   mask))
          (define mask (map keep? schema)))
    (make-db (filter keep? schema)
             (map row-project content))))

(check-expect (db-content (project school-db '("Name" "Present")))
              projected-content)



; DB [List-of Labels] Predicate -> [List-of Rows]
(define (select db labels predicate)
  (local ((define schema  (db-schema  db))
          (define content (db-content db))
          (define temp-db (make-db schema (filter predicate content))))
    (db-content (project temp-db labels))))

(define (present? row)
  (third row))
          
           

(check-expect (select school-db (list "Name") present?)
              '(("Alice")
                ("Carol")))


