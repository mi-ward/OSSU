;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_397) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 397.

;In a factory, employees punch time cards as they arrive in the morning and leave in the evening.

;Electronic time cards contain an employee number and record the number of hours worked per week.

;Employee records always contain the name of the employee, an employee number, and a pay rate.

;Design wages*.v3.
;The function consumes a list of employee records and a list of time-card records.
;It produces a list of wage records, which contain the name and weekly wage of an employee.
;The function signals an error if it cannot find an employee record for a time card or vice versa.

;Assumption There is at most one time card per employee number

; A timecard is (make-timecard String Numbers)
(define-struct timecard [en hours])

;An  employee-record is a (make-employee-record String String Number)
(define-struct employee-record [name en rate])

;A wage-record is a (make-wage-record String Number)
(define-struct wage-record [name total-pay])

;[List-of employee-record] [List-of timecard] -> [List-of wage-record]
; produces the weekly pay for employees
(define (wages*.v3 ers tcs)
  (local
    [(define (weekly-wage er tcs)
      (cond
      [(empty? tcs) (make-wage-record (employee-record-name er) 0)]
      [(string=? (employee-record-en er) (timecard-en (first tcs)))
          (make-wage-record (employee-record-name er) (* (employee-record-rate er) (timecard-hours (first tcs))))]
      [else
       (weekly-wage er (rest tcs))]))]
          
          
  (cond
    [(and (empty? ers) (empty? tcs)) '()]
    [(and (empty? ers) (cons? tcs)) '()]
    [(and (cons? ers) (empty? tcs)) '()]
    [(and (cons? ers) (cons? tcs))
     (cons (weekly-wage (first ers) tcs)
          (wages*.v3 (rest ers) tcs))])))


(define TC1 (make-timecard "111" 40))
(define TC2 (make-timecard "222" 35))
(define TC3 (make-timecard "333" 20))
(define TC4 (make-timecard "444" 40))
(define TC5 (make-timecard "555" 45))

(define ER1 (make-employee-record "John" "111" 10))
(define ER2 (make-employee-record "Jim" "222" 12))
(define ER3 (make-employee-record "Jordan" "333" 15))
(define ER4 (make-employee-record "Joanna" "444" 8))
(define ER5 (make-employee-record "Justin" "555" 6))

(check-expect (wages*.v3 `(,ER1) '()) '())
(check-expect (wages*.v3 `(,ER1) `(,TC1)) `(,(make-wage-record "John" 400)))
(check-expect (wages*.v3 `(,ER1 ,ER2) `(,TC1)) `(,(make-wage-record "John" 400) ,(make-wage-record "Jim" 0)))
(check-expect (wages*.v3 `(,ER2 ,ER1) `(,TC1)) `(,(make-wage-record "Jim" 0) ,(make-wage-record "John" 400)))
(check-expect (wages*.v3 `(,ER1) `(,TC2)) `(,(make-wage-record "John" 0)))
(check-expect (wages*.v3 `(,ER1) `(,TC1 ,TC2)) `(,(make-wage-record "John" 400)))
(check-expect (wages*.v3 `(,ER5 ,ER2, ER3, ER1, ER4) `(,TC4 ,TC3 ,TC1 ,TC5 ,TC2))
              `(,(make-wage-record "Justin" 270) ,(make-wage-record "Jim" (* 12 35)) ,(make-wage-record "Jordan" 300) ,(make-wage-record "John" 400) ,(make-wage-record "Joanna" 320)))




