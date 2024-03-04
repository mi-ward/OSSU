;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_367) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 367
;The design recipe calls for a self-reference in the template for xexpr-attr.
;Add this self-reference to the template and then explain why the finished parsing function does not contain it. 

(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) ...]
      [else (... (first optional-loa+content)
             (xexpr-attr (rest optional-loa+content) ...))])))

;This it isn't necessary to self-reference because all we're trying to capture
;is the first value in the xexpr.


