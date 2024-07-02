;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_407) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 407.
; Redesign row-filter using foldr.
; Once you have done so, you may merge row-project and row-filter into a single function.
; Hint The foldr function in ISL+ may consume two lists and process them in parallel.

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
;  Stop! Read this test carefully. What's wrong?
(check-expect (db-content (project school-db '("Name" "Present")))
              projected-content)

(define (project db labels)
  (local ((define schema (db-schema db))
          (define content (db-content db))
          (define schema-labels (map first schema))
          ; Spec -> Boolean
          ; does this spec belong to the new schema
          (define (keep? c)
            (member? (first c) labels))
          ; Row -> Row
          ; retains those columns whose name is in labels
          ; in names is also in lables
          (define (row-project row)
            (row-filter row schema-labels))

          (define (row-filter row schema-names)
            (foldr (lambda (x y r)
                     (if (member? y labels) (cons x r) r)) '() row schema-names)))
            
;            (cond
;              [(empty? schema-names) '()]
;              [(member? (first schema-names) labels)
;               (cons (first row) (row-filter (rest row) (rest schema-names)))]
;              [else (row-filter (rest row) (rest schema-names))])))
    (make-db (filter keep? schema)
             (map row-project content))))