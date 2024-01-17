;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_290) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;Exercise 290.
;Recall that the append function in ISL concatenates the items of two lists or,
;equivalently, replaces '() at the end of the first list with the second list:

(equal? (append (list 1 2 3) (list 4 5 6 7 8))
        (list 1 2 3 4 5 6 7 8))

;Use foldr to define append-from-fold. 

;[List-of X] [List-of X] -> [List-of X]
;concatenate two lists
(define (append-from-fold lstA lstB)
  (foldr (lambda (i lst) (cons i lst)) lstB lstA))

(check-expect (append-from-fold (list 1 2 3) (list 4 5 6 7 8))
              (list 1 2 3 4 5 6 7 8))

;What happens if you replace foldr with foldl?
(define (append-from-foldl lstA lstB)
  (foldl (lambda (i lst) (cons i lst)) lstB lstA))

(append-from-foldl (list 1 2 3) (list 4 5 6 7 8))
(list 3 2 1 4 5 6 7 8)

;Now use one of the fold functions to define functions that compute the sum and the product, respectively, of a list of numbers.
(check-expect ((lambda (i) (foldr + 0 i)) (list 1 2 3)) 6)
(check-expect ((lambda (i) (foldr * 1 i)) (list 1 2 3)) 6)


;With one of the fold functions, you can define a function that horizontally
;composes a list of Images.

;[List-of Image] -> Image
;horizontally compose a list of images
(check-expect ((lambda (i) (foldr beside empty-image i))
               (list
                (square 5 "solid" "red")
                (square 5 "solid" "white")
                (square 5 "solid" "blue"))) (beside (square 5 "solid" "red")
                                                    (square 5 "solid" "white")
                                                    (square 5 "solid" "blue")))

;Hints
;(1) Look up beside and empty-image.
;Can you use the other fold function? it will reverse the image


;Also define a function that stacks a list of images vertically.
;(2) Check for above in the teachpacks.

;[List-of Image] -> Image
;vertically compose a list of images
(check-expect ((lambda (i) (foldr above empty-image i))
               (list
                (square 5 "solid" "red")
                (square 5 "solid" "white")
                (square 5 "solid" "blue"))) (above (square 5 "solid" "red")
                                                   (square 5 "solid" "white")
                                                   (square 5 "solid" "blue")))