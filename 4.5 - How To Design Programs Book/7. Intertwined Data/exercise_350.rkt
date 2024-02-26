;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_350) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 350. What is unusual about the definition of this program with respect to the design recipe?

; It avoids need to have a resolution for certain cases by invoking errors in order to keep the input params very specific.
; It takes a single argument which is made up of 3 parts.


;Note One unusual aspect is that parse uses length on the list argument. Real parsers avoid length because it slows the functions down.