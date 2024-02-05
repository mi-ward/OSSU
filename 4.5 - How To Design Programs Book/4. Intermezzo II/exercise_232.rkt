;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_232) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 232
;Eliminate quasiquote and unquote from the following expressions
;so that they are written with list instead:

`(1 "a" 2 #false 3 "c")
(list 1 "a" 2 #false 3 "c")
(cons 1 (cons "a" (cons 2 (cons #false (cons 3 (cons "c" '()))))))

;this table-like shape:

       `(("alan" ,(* 2 500))
         ("barb" 2000)
         (,(string-append "carl" " , the great") 1500)
         ("dawn" 2300))

(list (list "alan" 1000)
      (list "barb" 2000)
      (list "carl , the great" 1500)
      (list "dawn" 2300))

;and this second web page where
(define title "ratings")

`(html
  (head
   (title ,title))
  (body
   (h1 ,title)
   (p "A second web page")))

(list 'html
      (list 'head
            (list 'title "ratings"))
      (list 'body (list 'h1 "ratings")
      (list 'p "A second web page")))

;====

;String String ->
; produces a web page with given author and title
(define (my-first-web-page author title)
  `(html
    (head
     (title ,title)
     (meta ((http-equiv "content-type")
            (content "text-html"))))
    (body
     (h1 ,title)
     (p "I, " ,author ", made this page."))))

(my-first-web-page "Matthias" "Hello World")




