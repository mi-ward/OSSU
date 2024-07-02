;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_410) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 410.
; Design the function db-union, which consumes two databases with the exact
; same schema and produces a new database with this schema and the
; joint content of both.

;The function must eliminate rows with the exact same content.
;Assume that the schemas agree on the predicates for each column.

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

(define school-schema2
  `(("Name"    ,string?)
    ("Age"     ,integer?)
    ("Present" ,boolean?)))

(define school-content2
  `(("Fred" 2 #true)
    ("Jim"   3 #false)
    ("Carol"  30 #true)
    ("Billy" 4 #true)
    ("Reena"  5 #false)))

(define school-db
  (make-db school-schema
           school-content))

(define school-db2
  (make-db school-schema2
           school-content2))

(define projected-content
  `(("Alice" #true)
    ("Bob"   #false)
    ("Carol" #true)
    ("Dave"  #false)))

(define projected-schema
  `(("Name" ,string?) ("Present" ,boolean?)))

(define school-schema-reorder
  `(("Present" ,boolean?)
    ("Name"    ,string?)
    ("Age"     ,integer?)))

(define school-schema-reorder-project
  `(("Present" ,boolean?)
    ("Name"    ,string?)))
 
(define school-content-reorder
  `((#true  "Alice"  35)
    (#false "Bob"    25)
    (#true  "Carol"  30)
    (#false "Dave"   32)))

(define school-content-reorder-project
  `((#true  "Alice")
    (#false "Bob"  )
    (#true  "Carol")
    (#false "Dave" )))

(define school-db-reorder
  (make-db school-schema-reorder
           school-content-reorder))

(define school-db-reorder-project
  (make-db school-schema-reorder-project
           school-content-reorder-project))
              
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

; DB [List-of Labels -> DB
; reorders DB based on the provided list of labels
(define (reorder db labels)
  (local ((define updated-db (project db labels))
          (define schema (db-schema updated-db))
          (define content (db-content updated-db))
          (define original-order (map first schema))
          (define (get-indexes order new-order)
            (cond
              [(empty? order) '()]
              [else
               (cons (get-index (first order) new-order)
                     (get-indexes (rest order) new-order))]))
          (define (get-index itm lst)
            (cond
              [(string=? itm (first lst)) 0]
              [else
               (add1 (get-index itm (rest lst)))]))
          (define new-order-idx (get-indexes labels original-order))
          (define (reorder-by-idx lst idx-list)
            (cond
              [(empty? idx-list) '()]
              [else
               (cons (list-ref lst (first idx-list))
                     (reorder-by-idx lst (rest idx-list)))])))
    
    (make-db (reorder-by-idx schema new-order-idx)
             (map (lambda (x) (reorder-by-idx x new-order-idx)) content))
    ))

(check-expect (db-content (reorder school-db '("Present" "Name" "Age"))) school-content-reorder)
(check-expect (db-content (reorder school-db '("Present" "Name"))) school-content-reorder-project)


;DB DB -> DB
; consumes two dbs with same schema
; produces a new database with the same schema and content from both
; rows with the exact same content are eliminated
(define (union db1 db2)
  (make-db (db-schema db1)
           (append (db-content db1)
                   (filter
                    (lambda (x) (false? (member? x (db-content db1))))
                    (db-content db2)))))

  (check-expect (union school-db school-db2) (make-db school-schema 
                                                      `(("Alice" 35 #true)
                                                        ("Bob"   25 #false)
                                                        ("Carol" 30 #true)
                                                        ("Dave"  32 #false)
                                                        ("Fred" 2 #true)
                                                        ("Jim"   3 #false)
                                                        ("Billy" 4 #true)
                                                        ("Reena"  5 #false))))
  