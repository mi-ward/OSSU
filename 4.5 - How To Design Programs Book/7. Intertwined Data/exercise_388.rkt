;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_388) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] [List-of Number] -> [List-of Number]
; multiplies the corresponding items on:
; hours and wages/h 
; assume the two lists are of equal length 

(define (wages*.v2 hours wages/h)
  (cond 
    [(empty? hours) '()]
    [else
     (cons (weekly-wage (first hours) (first wages/h)) (wages*.v2 (rest hours) (rest wages/h)))]))

#;
(define (wages*.v2 hours wages/h)
  (cond
    [(empty? hours) ...]
    [else
     (... (first hours)
          ... (first wages/h) ...
          ... (wages*.v2 (rest hours) (rest wages/h)))]))


(check-expect (wages*.v2 '() '()) '())
(check-expect (wages*.v2 (list 5.65) (list 40)) (list 226.0))
(check-expect (wages*.v2 '(5.65 8.75) '(40.0 30.0)) '(226.0 262.5))

; Number Number -> Number
; computes the weekly wage from pay-rate and hours
(define (weekly-wage pay-rate hours)
  (* pay-rate hours))

;Exercise 388.
; In the real world, wages*.v2 consumes lists of employee structures and lists of work records.
; An employee structure contains an employee’s name, social security number, and pay rate.
; A work record also contains an employee’s name and the number of hours worked in a week.
; The result is a list of structures that contain the name of the employee and the weekly wage.

; Modify the program in this section so that it works on these realistic versions of data.
; Provide the necessary structure type definitions and data definitions.
; Use the design recipe to guide the modification process.

(define-struct employee [name ssn pay-rate])
(define CHAD (make-employee "Chad" "123456789" 80))
(define BRAD (make-employee "Brad" "222334444" 6))
(define THAD (make-employee "Thad" "999880000" 45))

(define-struct work-record [employee-name hours-worked])
(define WR1 (make-work-record "Chad" 40))
(define WR2 (make-work-record "Brad" 50))
(define WR3 (make-work-record "Thad" 35))

(define (wages*.v3 employees wrs)
  (cond
    [(empty? employees) '()]
    [else
     (cons (weekly-wage.v2 (first employees) wrs) (wages*.v3 (rest employees) wrs))]))

(define (weekly-wage.v2 employee list-of-wrs)
  (cond
    [(empty? list-of-wrs) 0]
    [(string=? (employee-name employee) (work-record-employee-name (first list-of-wrs))) (* (employee-pay-rate employee) (work-record-hours-worked (first list-of-wrs)))]
    [else
     (weekly-wage.v2 employee (rest list-of-wrs))]))


(check-expect (wages*.v3 '() '()) '())
(check-expect (wages*.v3  (list CHAD THAD BRAD) (list WR2 WR1 WR3)) (list 3200 1575 300))