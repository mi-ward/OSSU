;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_329) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 329

;How many times does a file name read! occur in the directory tree TS?
; -- twice

;Can you describe the path from the root directory to the occurrences?
; -- TS/read!
; -- TS/Libs/Docs/read!

;What is the total size of all the files in the tree?
; -- (+ 10 99 52 17 19 8 2)
; -- 207

;What is the total size of the directory if each directory node has size 1?
; -- (+ 207 5)
; -- 212

;How many levels of directories does it contain?
; -- 5