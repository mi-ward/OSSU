;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_233) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 233.

;List-of-numbers -> ...nested list ...
; creates a row for an HTML table from l
(define (make-row l)
  (cond
    [(empty? l) '()]
    (else (cons (make-cell (first l))
                (make-row (rest l))))))

;Number -> ... nested list ...
; creates a cell for an HTML table from a number
(define (make-cell n)
  `(td ,(number->string n)))
;Develop alternatives to the following expressions
;that use only list and produce the same values.

`(0,@'(1 2 3) 4)
(list 0 1 2 3 4)
(check-expect `(0,@'(1 2 3) 4) (list 0 1 2 3 4))

`(("alan" ,(* 2 500))
  ("barb" 2000)
  (,@'("carl" " , the great")     1500)
  ("dawn" 2300))

(list (list "alan" 1000)
      (list "barb" 2000)
      (list "carl" " , the great" 1500)
      (list "dawn" 2300))

(check-expect 
 `(("alan" ,(* 2 500))
   ("barb" 2000)
   (,@'("carl" " , the great")     1500)
   ("dawn" 2300))
 (list (list "alan" 1000)
       (list "barb" 2000)
       (list "carl" " , the great" 1500)
       (list "dawn" 2300)))

`(html
  (body
   (table ((border "1"))
          (tr ((width "200"))
              ,@(make-row '(1 2)))
          (tr ((width "200"))
              ,@(make-row '(99 65))))))

(list 'html
       (list 'body
             (list 'table (list (list 'border '"1")))
             (list 'tr (list (list 'width '"200"))
                   (list (list 'td "1") (list 'td "2")))
             (list 'tr (list (list 'width '"200"))
                   (list (list 'td "99") (list 'td "65")))))
(check-expect
`(html
  (body
   (table ((border "1"))
          (tr ((width "200"))
              ,@(make-row '(1 2)))
          (tr ((width "200"))
              ,@(make-row '(99 65))))))

(list 'html
       (list 'body
             (list 'table (list (list 'border '"1"))
             (list 'tr (list (list 'width '"200"))
                   (list 'td "1") (list 'td "2"))
             (list 'tr (list (list 'width '"200"))
                   (list 'td "99") (list 'td "65"))))))