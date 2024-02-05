;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_234) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 234

;===================

; List-of-numbers -> ... nested list ...
; creates a row for an HTML table from l
(define (make-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell (first l))
                (make-row (rest l)))]))

;Number -> ... nested list ...
; creates a cell for an HTML table from a number
(define (make-cell n)
  `(td ,n))

;List-of-numbers List-of-numbers -> ... nested list ...
; creates an HTML table from two lists of numbers
(define (make-table row1 row2)
  `(table ((border "1"))
          (tr ,@(make-row row1))
          (tr ,@(make-row row2))))

;====================

;Create the function make-ranking which consumes a list of
;ranked song titles and produces a list representation of an HTML
;table. Consider this example:

(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

;Hint Although you could design a function that determines the ranking
;from a list of strings, we wish you to focus on the creation of tables
;instead. Thus we supply the following functions:

;[List-of-string] -> [List-of Number String]
;applies ranking to songs and puts in order from 1 - n (length of los)
(define (ranking los)
  (reverse (add-ranks (reverse los))))

;[List-of String] -> [List-of [List-of Number String]
;takes list of songs and applies numerical rank to each
;in a separate list
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))

;Before you use these functions, equip them with signatures and purpose
;statements. Then explore their workings with interactions in DrRacket.
;Part VI expands the design recipe with a way to create simpler functions
;for computing rankings than rankings and add-ranks.

;[List-of Ranked_Song_titles] -> ... nested list ...
;Create the function make-ranking which consumes a list of
;ranked song titles and produces a list representation of an HTML
;table.

(define (make-ranking los)
  (make-rank-table (ranking los)))

(check-expect (make-ranking one-list)
              (list
               'table
               (list (list 'border "1"))
               (list
                'tr
                (list 'td 1)
                (list 'td "Asia: Heat of the Moment"))
               (list
                'tr
                (list 'td 2)
                (list 'td "U2: One"))
               (list
                'tr
                (list 'td 3)
                (list
                 'td
                 "The White Stripes: Seven Nation Army"))))

;[List-of] [List-of Number String] -> ... nested list ...
;creates the table from the ranked list
(define (make-rank-table l)
  `(table ((border "1"))
          ,@(make-rank-table-rows l)))

(define (make-rank-table-rows lolor)
  (cond
    [(empty? lolor) '()]
    [else
     (cons `(tr ,@(make-row (first lolor)))
           (make-rank-table-rows (rest lolor)))]))


                      
              

