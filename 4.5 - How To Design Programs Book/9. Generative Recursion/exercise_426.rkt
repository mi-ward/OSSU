;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_426) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 426.
; Complete the hand-evaluation from above. A close inspection of the evaluation suggests an additional trivial case for quick-sort<.
; Every time quick-sort< consumes a list of one item, it returns it as is. After all, the sorted version of a list of one item is the list itself.

; Modify quick-sort< to take advantage of this observation. Evaluate the example again. How many steps does the revised algorithm save? 4 steps

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers alon pivot))
                    (list pivot)
                    (quick-sort< (largers alon pivot))))]))

; [List-of Numbers N] -> List-of Number
; retrieve all numbers in list smaller than pivot
(define (smallers lon pivot)
  (filter (lambda (x) (< x pivot)) lon))

; [List-of Numbers N] -> List-of Number
; ; retrieve all numbers in list larger than pivot
(define (largers lon pivot)
  (filter (lambda (x) (> x pivot)) lon))

(quick-sort< (list 11 8 14 7))
;1a==
(append (quick-sort< (list 8 7))
        (list 11)
        (quick-sort< (list 14)))

;1b==
(append (append (quick-sort< (list 7))
                (list 8)
                (quick-sort< '()))
        (list 11)
        (quick-sort< (list 14)))

;1c==
(append (append (append (quick-sort< '())
                        (list 7)
                        (quick-sort< '()))
                (list 8)
                (quick-sort< '()))
        (list 11)
        (quick-sort< (list 14)))

;1d==
(append (append (append '()
                        (list 7)
                        '())
                (list 8)
                '())
        (list 11)
        (quick-sort< (list 14)))
;1e==
(append (append (list 7)
                (list 8)
                '())
        (list 11)
        (quick-sort< (list 14)))
;1f==
(append (append (list 7)
                (list 8)
                '())
        (list 11)
        (append (list 14)
                (quick-sort< '())))
;1g==
(append (append (list 7)
                (list 8)
                '())
        (list 11)
        (append (list 14)
                '()))
;1h==
(append (list 7 8)
        (list 11)
        (append (list 14)
                '()))
;1i==
(append (list 7 8)
        (list 11)
        (list 14))
;1j==
(list 7 8 11 14)



;2a==
(append (quick-sort< (list 8 7))
        (list 11)
        (quick-sort< (list 14)))

;2b==
(append (append (quick-sort< (list 7))
                (list 8)
                (quick-sort< '()))
        (list 11)
        (quick-sort< (list 14)))

;2c==
(append (append (list 7)
                (list 8)
                '())
        (list 11)
        (quick-sort< (list 14)))

;2d==
(append (append (list 7)
                (list 8)
                '())
        (list 11)
        (list 14))
;2e==
(append (list 7 8)      
        (list 11)
        (list 14))
;2f==
(list 7 8 11 14))