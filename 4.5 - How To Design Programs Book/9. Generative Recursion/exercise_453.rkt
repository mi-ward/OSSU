;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_453) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 453.
; Design the function tokenize.
; It turns a Line into a list of tokens.
; Here a token is either a 1String or a String that consists of
; lower-case letters and nothing else.

; That is, all white-space 1Strings are dropped;
; all other non-letters remain as is; and all consecutive letters
; are bundled into “words.”

;Hint Read up on the string-whitespace? function. 

; A Line is a [List-of 1String]

; A File is one of: 
; – '()
; – (cons "\n" File)
; – (cons 1String File)
; interpretation represents the content of a file 
; "\n" is the newline character

; File -> [List-of Line]
; converts a file into a list of lines 
 
(check-expect (file->list-of-lines
                (list "a" "b" "c" "\n"
                      "d" "e" "\n"
                      "f" "g" "h" "\n"))
              (list (list "a" "b" "c")
                    (list "d" "e")
                    (list "f" "g" "h")))
 
; File -> [List-of Line]
; converts a file into a list of lines 
(define (file->list-of-lines afile)
  (cond
    [(empty? afile) '()]
    [else
     (cons (first-line afile)
           (file->list-of-lines (remove-first-line afile)))]))
 
; File -> Line
; retrieves the first 1strings of a file up to but not including the
; newline character
(define (first-line afile)
  (cond
    [(empty? afile) '()]
    [(string=? (first afile) NEWLINE) '()]
    [else (cons (first afile) (first-line (rest afile)))]))
 
; File -> File
; removes the first line from the file including the newline character
(define (remove-first-line afile)
  (cond
    [(empty? afile) '()]
    [(string=? (first afile) NEWLINE) (rest afile)]
    [else (remove-first-line (rest afile))]))
 
(define NEWLINE "\n") ; the 1String

(define howareyou (list
  "h" "o" "w" " " "a" "r" "e" " " "y" "o" "u" "\n"
  "d" "o" "i" "n" "g" "?" "\n"
  "a" "n" "y" " " "p" "r" "o" "g" "r" "e" "s" "s" "?"))

(define line1 (list "h" "o" "w" " " "a" "r" "e" " " "y" "o" "u" "!" "\n"))

; A Token is one of:
; - 1string
; - String

; Line -> [List-of Tokens]
(define (tokenize line)
  (cond
    [(string=? (first line) "\n") '()]
    [(string-whitespace? (first line)) (tokenize (rest line))]
    [(false? (member? (first line) (explode "abdefghijklmnopqrstuvwxyz")))
     (append (cons (first line) (tokenize (rest line))))]
    [else (cons (implode (tokens line)) (tokenize (remove-tokens line)))]))

(define (tokens line)
  (cond [(empty? line) '()]
        [(member? (first line) (explode "abcdefghijklmnopqrstuvwxyz"))
         (cons (first line) (tokens (rest line)))]
        [else '()]))
      

(define (remove-tokens line)
  (if (member? (first line) (explode "abcdefghijklmnopqrstuvwxyz"))
      (remove-tokens (rest line))
      line))

(check-expect (tokenize line1) (list "how" "are" "you" "!"))
    
                                                                   
     


