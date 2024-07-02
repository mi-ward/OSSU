;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_411) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 411.
; Design join, a function that consumes two databases: db-1 and db-2.
; The schema of db-2 starts with the exact same Spec that the schema of db-1 ends in.
; The function creates a database from db-1 by replacing the last cell in each row
; with the translation of the cell in db-2.

;Here is an example. Take the databases in figure 137.
; The two satisfy the assumption of these exercises, that is,
; the last Spec in the schema of the first is equal to the first Spec of the second.
;Hence it is possible to join them:

; Name    Age     Description
; String  Integer String
;  "Alice" 35      "presence"
;  "Bob"   25      "absence"
;  "Carol" 30      "presence"
;  "Dave"  32      "absence"

; Its translation maps #true to "presence" and #false to "absence".

; Hints (1) In general, the second database may “translate” a cell to a row of values,
; not just one value. Modify the example by adding additional terms to the row
; for "presence" and "absence".

; (2) It may also “translate” a cell to several rows,
; in which case the process adds several rows to the new database.
; Here is a second example, a slightly different pair of databases from those in figure 137:

; Name    Age     Present   | Present  Description
; String  Integer Boolean   | Boolean  String
; "Alice" 35      #true     | #true    "presence"
; "Bob"   25      #false    | #true    "here"
; "Carol" 30      #true     | #false   "absence"
; "Dave"  32      #false    | #false   "there"

; Joining the left database with the one on the right yields a database with eight rows:


; Name    Age     Description
; String  Integer String
; "Alice" 35      "presence"
; "Alice" 35      "here"
; "Bob"   25      "absence"
; "Bob"   25      "there"
; "Carol" 30      "presence"
; "Carol" 30      "here" 
; "Dave"  32      "absence"
; "Dave"  32      "there"

; (3) Use iterative refinement to solve the problem.
; For the first iteration, assume that a “translation” finds only one row per cell.
; For the second one, drop the assumption.

; Note on Assumptions
; This exercise and the entire section mostly rely on informally stated assumptions
; about the given databases.
; Here, the design of join assumes that “the schema of db-2 starts with the exact same Spec
; that the schema of db-1 ends in.”
; In reality, database functions must be checked functions in the spirit of Input Errors.
; Designing checked-join would be impossible for you, however.
; A comparison of the last Spec in the schema of db-1 with the first one in db-2 calls
; for a comparison of functions. For practical solutions, see a text on databases.

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

(define attendance-schema
  `(("Present"      ,boolean?)
    ("Description" ,string?)))

(define attendance-content
  `((#true "presence")
    (#false "absence")))

(define attendance-content2
  `((#true "presence")
    (#true "here")
    (#false "absence")
    (#false "there")))

(define attendance-db
  (make-db attendance-schema
           attendance-content))

(define attendance-db2
  (make-db attendance-schema
           attendance-content2))

(define projected-schema
  `(("Name" ,string?) ("Present" ,boolean?)))

(define projected-content
  `(("Alice" #true)
    ("Bob"   #false)
    ("Carol" #true)
    ("Dave"  #false)))

(define projected-db
  (make-db projected-schema projected-content))

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

; DB DB -> DB
; Creates a database from db-1 by replacing the last cell in each row with the
; translation of the cell in db-2
(define (join db1 db2)
  (local ((define schema1  (db-schema db1))
          (define schema2  (db-schema db2))
          (define content1 (db-content db1))
          (define content2 (db-content db2))
          (define (join-schema schema1 schema2)
            (cond
              [(empty? schema1) '()]
              [(string=? (first (first schema1)) (first (first schema2))) (rest schema2)]
              [else
               (cons (first schema1) (join-schema (rest schema1) schema2))]))
          
          (define (join-content content1 content2)
            (cond
              [(empty? content1) '()]
              [else (append (join-rows (first content1) content2)
                            (join-content (rest content1) content2))]))

          (define (join-rows row content)
            (cond [(empty? content) '()]
                  [(boolean=? (last row) (first (first content))) (cons (join-row row content) (join-rows row (rest content)))]
                  [else (join-rows row (rest content))]))

          (define (last row)
            (cond [(empty? row) '()]
                  [(empty? (rest row)) (first row)]
                  [else (last (rest row))]))
          
          (define (join-row row content)
            (cond
              [(empty? (rest row)) (replace (first row) content)]
              [else
               (cons (first row) (join-row (rest row) content))]))
          
          (define (replace cell content)
            (cond
              [(boolean=? cell (first (first content))) (rest (first content))]
              [else
               (replace cell (rest content))])))
    (make-db
     (join-schema schema1 schema2)
     (join-content content1 content2))))



;(join-schema content1 content2)))
          


               
                   

(check-expect (map first (db-schema (join school-db attendance-db))) (map first `(("Name"        ,string?)
                                                                                  ("Age"         ,integer?)
                                                                                  ("Description" ,string?))))
                                                      

(check-expect (db-content (join school-db attendance-db)) `(("Alice" 35 "presence")
                                                            ("Bob"   25 "absence")
                                                            ("Carol" 30 "presence")
                                                            ("Dave"  32 "absence")))
                                                        

(check-expect (map first (db-schema (join school-db attendance-db2))) (map first `(("Name"        ,string?)
                                                                                   ("Age"         ,integer?)
                                                                                   ("Description" ,string?))))


(check-expect (db-content (join school-db attendance-db2)) `(("Alice" 35 "presence")
                                                             ("Alice" 35 "here")
                                                             ("Bob"   25 "absence")
                                                             ("Bob"   25 "there")
                                                             ("Carol" 30 "presence")
                                                             ("Carol" 30 "here")
                                                             ("Dave"  32 "absence")
                                                             ("Dave"  32 "there")))
              
                                              


  
