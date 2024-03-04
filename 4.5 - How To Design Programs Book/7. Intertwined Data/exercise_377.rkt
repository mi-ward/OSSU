;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_377) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;Exercise 377
;Design a program that replaces all "hello"s with "bye" in an enumeration.

(define x1 '(ul (li (word ((text "hello"))))))
(define x2 '(ul (li (word ((text "hello"))))
                (li (word ((text "hello"))))))
(define x3 '(ul (li (ul (li (word ((text "hallo"))))))
                (li (word ((text "hillo"))))))

                

;XEnum.v2 -> Number
;replace hellos with bye
(define (enum-hello-replace xe)
  (local [(define content (xexpr-content xe))]
    (cons 'ul (map item-hello-replace content))))

(check-expect (enum-hello-replace x1) '(ul (li (word ((text "bye"))))))
(check-expect (enum-hello-replace x2) '(ul (li (word ((text "bye"))))
                (li (word ((text "bye"))))))
(check-expect (enum-hello-replace x3) x3)

;XItem.v2 -> Number
; count the number of hellos
(define (item-hello-replace item)
  (local [(define content (first (xexpr-content item)))]
    (cond [(word? content) (if (string=? (word-text content) "hello") '(li (word ((text "bye")))) item)]
          [else (cons 'li (list (enum-hello-replace content)))])))



;XItem.v2 -> Number
; count the number of hello's


; An XWord is '(word ((text String))).

;An Xexpr.v2 is a list:
; - Xword
; - (cons Symbol Body)
; - (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr.v2]

; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

;A possible-loa is one of:
; - [List-of Attribute]
; - Xexpr.v2

; An XItem.v2 is one of: 
; – (cons 'li  XWord)
; - (cons 'li (cons (cons Symbol (cons String) '()) (list-of Attribute)) (cons 'word ((test String))))
; – (cons 'li XEnum.v2)
; – (cons 'li (cons (cons Symbol (cons String) '()) (list-of Attribute)) (cons XEnum.v2 (list-of XEnum.v2)))
; 
; An XEnum.v2 is one of:
; – (cons 'ul (cons XItem.v2 [List-of XItem.v2]))
; – (cons 'ul (cons (cons Symbol (cons String) '()) (list-of Attribute)) (cons XItem.v2 [List-of XItem.v2]))

(define a0 '((initial "X")))
(define a1 '((X "X") (initial "ini") (asd "dsa")))
(define a2 '((X "X")))
(define word1 '(word ((text "String"))))
(define word2 '(word ((text "word"))))
(define word3 '(word ((text "wordstring"))))
(define word4 '(blorp ((text "wordstring"))))
(define e0_ '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))
(define SIZE 12) ; font size 
(define COLOR "white") ; font color 
(define BT ; a graphical constant 
  (beside (circle 1 'solid 'white) (text " " SIZE COLOR)))

(define e0
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))))

(define e0-rendered
  (above/align
   'left
   (beside/align 'center BT (text "one" 12 'white))
   (beside/align 'center BT (text "two" 12 'white))))


; Xexpr.v2 -> Symbol
; produce the name of Xexpr.v2 (xe)
(define (xexpr-name xe) (first xe))

; Xexpr.v2 -> [List-of Xexpr.v2]
; produce the content in an xexpr (xe)
(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local [(define loa-or-x (first optional-loa+content))]
         (if (list-of-attributes? loa-or-x)
             (rest optional-loa+content)
             optional-loa+content))])))

; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe
(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local [(define loa-or-x (first optional-loa+content))]
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

;[List-of Attributes] Symbol -> String or false
;retrieve the string related to the symbol if the symbol exists otherwise false
(define (find-attr attr-list sym)
  (if (false? (assq sym attr-list)) #false (second (assq sym attr-list))))

;Xword -> Boolean
;checks whether xword has a value
(define (word? xword)
  (symbol=? 'word (first xword)))

;Xword -> String
;extracts the string from a word
(define (word-text xword)
  (if (word? xword)
      (find-attr (second xword) 'text)
      '()))
      

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

; XItem.v1 -> Image 
; renders an item as a "word" prefixed by a bullet
(define (render-item1 i)
  (local ((define content (xexpr-content i))
          (define element (first content))
          (define a-word (word-text element))
          (define item (text a-word 12 'white)))
    (beside/align 'center BT item)))

; Image -> Image
; marks item with bullet  
(define (bulletize item)
  (beside/align 'center BT item))

;XItem.v2 -> Image
(define (render-item item)
  (local [(define content (first (xexpr-content item)))]
    (cond [(word? content) (beside/align 'center BT (text (word-text content) 12 'white))]
          [else (beside/align 'center BT (render-enum content))])))

;Xenum.v2 -> Image
(define (render-enum xenum)
  (local [(define content (xexpr-content xenum))
          (define (handle-one item the-rest) (above/align 'left (render-item item) the-rest))]
    (foldr handle-one empty-image content)))

(check-expect (xexpr-name e0_) 'machine)
(check-expect (xexpr-name e1) 'machine)
(check-expect (xexpr-name e2) 'machine)
(check-expect (xexpr-name e3) 'machine)
(check-expect (xexpr-name e4) 'machine)
(check-expect (xexpr-content e0_) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) '((action)))
(check-expect (xexpr-content e3) '((action)))
(check-expect (xexpr-content e4) '((action) (action)))
(check-expect (xexpr-attr e0) '())
(check-expect (xexpr-attr e1) '((initial "X")))
(check-expect (xexpr-attr e2) '())
(check-expect (xexpr-attr e3) '())
(check-expect (xexpr-attr e4) '((initial "X")))
(check-expect (find-attr a0 'initial) "X")
(check-expect (find-attr a1 'initial) "ini")
(check-expect (find-attr a2 'initial) #false)
(check-expect (word? word1) #true)
(check-expect (word? word2) #true)
(check-expect (word? word3) #true)
(check-expect (word? word4) #false)
(check-expect (word-text word1) "String")
(check-expect (word-text word4) '())
(check-expect (render-item '(li (word ((text "one")))))
              (beside/align 'center (circle 1 'solid 'white)
                            (text " " 12 'white)
                            (text "one" 12 'white)))

(check-expect (render-item '(li (word ((text "two")))))
              (beside/align 'center (circle 1 'solid 'white)
                            (text " " 12 'white)
                            (text "two" 12 'white)))
(check-expect (bulletize (text "text" SIZE COLOR))
              (beside/align 'center BT (text "text" SIZE COLOR)))

(check-expect (render-enum '(ul (li (word ((text "one"))))))
              (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white) (text "one" 12 'white)))
(check-expect (render-enum '(ul (li (word ((text "one")))) (li (word ((text "two"))))))
              (above/align 'left (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white) (text "one" 12 'white))
                           (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white) (text "two" 12 'white))))
(check-expect (render-enum '(ul (li (wrd ((text "one")))) (li (wrd ((text "two"))))))
              (above/align 'left (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white))
                           (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white))))




