;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_437) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 437.
; Define solve and combine-solutions so that

;Figure 153: From generative to structural recursion

#;
(define (general P)
  (cond
    [(trivial? P) (solve P)]
    [else
     (combine-solutions
       P
       (general
         (generate P)))]))
 
#;
(define (special P)
  (cond
    [(empty? P) (solve P)]
    [else
     (combine-solutions
       P
       (special (rest P)))]))

;  - special computes the length of its input,

(define (special_length P)
  (local ((define (solve P) 0)
          (define (combine-solutions P rest_p) (+ 1 (special_length (rest P)))))
  (cond
    [(empty? P) (solve P)]
    [else (combine-solutions P (special_length (rest P)))])))

(check-expect (special_length (list 1 2 3)) 3)

;  - special negates each number on the given list of numbers, and

(define (special_negate P)
  (local ((define (solve P) '())
          (define (combine-solutions P rest_P) (cons (if (<= (first P) 0) (first P) (- (first P))) (special_negate (rest P)))))
  (cond
    [(empty? P) (solve P)]
    [else
     (combine-solutions P (special_negate (rest P)))])))

(check-expect (special_negate (list 1 2 3)) (list -1 -2 -3))
(check-expect (special_negate (list 1 2 3 0)) (list -1 -2 -3 0))

;  - special uppercases the given list of strings.
(define (special_upper P)
  (local ((define (solve P) '())
          (define (upper P) (string-append (string-upcase (substring P 0 1)) (substring P 1)))
          (define (combine-solutions P rest_P) (cons (upper (first P)) (special_upper rest_P))))
    (cond
      [(empty? P) (solve P)]
      [else
       (combine-solutions P (special_upper (rest P)))])))

(check-expect (special_upper (list "abc")) (list "Abc"))
(check-expect (special_upper (list "abc" "def")) (list "Abc" "Def"))
            
;What do you conclude from these exercises?
; The structural template and generative templates are not too different from one another. The generative template can easily be adapted to cover structure recursion cases.