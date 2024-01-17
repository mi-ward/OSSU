;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_289) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 289.

;Use ormap to define find-name.
;The function consumes a name and a list of names.
;It determines whether any of the names on the latter
;are equal to or an extension of the former.

;String [List-of String] -> Boolean
;Determines whether any of the names on the latter
;are equal to or an extension of the former.
(define (find-name name lon)
  (ormap (lambda (a) (cond [(< (string-length a) (string-length name)) #false]
                           [(string=? name a) #true]
                           [(string=? name (substring a 0 (string-length name))) #true]
                           [else #false])) lon))

(check-expect (find-name "don" (list "don" "ron" "ra" "tom"))    #true)
(check-expect (find-name "don" (list "ron" "donald" "ra" "tom")) #true)
(check-expect (find-name "don" (list "ron" "ra" "tom"))  #false)
(check-expect (find-name "don" (list "ron" "jim" "tom")) #false)

;With andmap you can define a function
;that checks all names on a list of names
;that start with the letter "a".

;[List-of String] -> Boolean
;checks that all names start with a
(define (starts-with-a lon)
  (andmap (lambda (name) (string=? "a" (string-ith name 0))) lon))

(check-expect (starts-with-a (list "don" "dan" "rick" "steve")) #false)
(check-expect (starts-with-a (list "don" "dan" "arthur" "steve")) #false)
(check-expect (starts-with-a (list "ashley" "andy" "arthur" "artie")) #true)
(check-expect (starts-with-a (list "ashley" "andy" "arthur" "martie")) #false)


;Should you use ormap or andmap to
;define a function that ensures that
;no name on some list exceeds some given width?

;either

;Number [List-of String] -> Boolean
;ensures no name on list exceeds given width
(define (width-doesnt-exceed-and? width los)
  (andmap (lambda (name) (<= (string-length name) width)) los))

(check-expect (width-doesnt-exceed-and? 5 (list "don" "dan" "donna")) #true)
(check-expect (width-doesnt-exceed-and? 5 (list "don" "daniel" "donna")) #false)

;Number [List-of String] -> Boolean
;ensures no name on list exceeds given width
(define (width-exceeds-or? width los)
  (ormap (lambda (name) (> (string-length name) width)) los))

(check-expect (width-exceeds-or? 5 (list "don" "dan" "donna")) #false)
(check-expect (width-exceeds-or? 5 (list "don" "daniel" "donna")) #true)

