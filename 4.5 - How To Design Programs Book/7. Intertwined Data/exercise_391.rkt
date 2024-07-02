;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_391) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 391.
; Design replace-eol-with using the strategy of Processing Two Lists Simultaneously: Case 3.
; Start from the tests. Simplify the result systematically.

; [List-of Number] [List-of Number] -> [List-of Number]
; replaces the final '() in front with end
(define (replace-eol-with front end)
  (cond
    [(and (empty? front) (empty? end)) '()]
    [(and (cons? front) (empty? end)) front]
    [(and (empty? front) (cons? end)) end]
    [(and (cons? front) (cons? end))
     (cons (first front) (replace-eol-with (rest front) end))]))

(check-expect (replace-eol-with '() '()) '())
(check-expect (replace-eol-with '() '(1 2)) '(1 2))
(check-expect (replace-eol-with '(1 2) '()) '(1 2))
(check-expect (replace-eol-with '(1 2) '(3 4)) '(1 2 3 4))


(define (replace-eol-with.v2 front end)
  (cond
    [(empty? front) end]
    [(cons? front)
     (cons (first front) (replace-eol-with.v2 (rest front) end))]))

(check-expect (replace-eol-with.v2 '() '()) '())
(check-expect (replace-eol-with.v2 '() '(1 2)) '(1 2))
(check-expect (replace-eol-with.v2 '(1 2) '()) '(1 2))
(check-expect (replace-eol-with.v2 '(1 2) '(3 4)) '(1 2 3 4))