;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_369) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 369
;Design find-attr
;The function consumes a list of attributes and a symbol. ;If the attributes list associates the symbol with a string,
;the function retrieves this string; otherwise it returns #false.—Consider using assq to define the function.

(define a0 '((initial "X")))
(define a1 '((X "X") (initial "ini") (asd "dsa")))
(define a2 '((X "X")))

;[List-of Attributes] Symbol -> String or false
;retrieve the string related to the symbol if the symbol exists otherwise false
(define (find-attr attr-list sym)
  (if (false? (assq sym attr-list)) #false (second (assq sym attr-list))))

(check-expect (find-attr a0 'initial) "X")
(check-expect (find-attr a1 'initial) "ini")
(check-expect (find-attr a2 'initial) #false)




