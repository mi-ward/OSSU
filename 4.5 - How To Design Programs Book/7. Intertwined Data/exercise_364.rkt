;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_364) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 364
;Represent this XML data as elements of Xexpr.v2:

;<transition from="seen-e" to="seen-f" />

;<ul><li><word /><word /></li><li><word /></li></ul>

;Which one could be represented in Xexpr.v0 or Xexpr.v1?

; The second example

;===============================================

;An Xexpr.v2 is a list:
; - (cons Symbol Body)
; - (cons Symbol (cons [List-of Attribute] Body))

;A Body is one of:
; - '()
; - (cons Xexpr.v2 Body)

;An Attribute is a list of two items:
;  (cons Symbol (cons String '()))

;<transition from="seen-e" to="seen-f" />
'(transition ((from "seen-e") (to "seen-f")))

;<ul><li><word /><word /></li><li><word /></li></ul>
'(ul (li (word) (word)) (li (word)))