;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_457) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 457.
; Design the function double-amount which computes
; how many months it takes to double a given amount of
; money when a savings account pays interest at a
; fixed rate on a monthly basis.

(define (double-amount amount interest)
  (local ((define goal (* 2 amount))
          (define (double-amount-local amount month)
            (cond
              [(>= amount goal) month]
              [else (double-amount-local (monthly-interest amount interest) (add1 month))]))
          (define (monthly-interest amount interest)
            (+ amount (* amount interest))))
    (double-amount-local amount 0)))
     

(check-expect (double-amount 100 0.01) 70)
(check-expect (double-amount 100 0.02) 36)
(check-expect (double-amount 99 0.03) 24)
(check-expect (double-amount 50 0.04) 18)
(check-expect (double-amount 10 0.05) 15)
(check-expect (double-amount 1 0.06) 12)
(check-expect (double-amount 4 0.07) 11)


