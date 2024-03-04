;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_372) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;Exercise 372
;Before you read on, equip the definition of render-item1 with tests.
;Make sure to formulate these tests in such a way that they don’t depend on the BT constant.
;Then explain how the function works; keep in mind that the purpose statement explains only what it does.

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

; An XEnum.v1 is one of: 
; – (cons 'ul [List-of XItem.v1])
; – (cons 'ul (cons Attributes [List-of XItem.v1]))
; An XItem.v1 is one of:
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons Attributes (cons XWord '())))

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
(define BT (circle 2 'solid 'white))


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

(define e0
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))))

(define e0-rendered
  (above/align
   'left
   (beside/align 'center BT (text "one" 12 'black))
   (beside/align 'center BT (text "two" 12 'black))))

; XItem.v1 -> Image 
; renders an item as a "word" prefixed by a bullet
(define (render-item1 i)
  (local ((define content (xexpr-content i))
          (define element (first content))
          (define a-word (word-text element))
          (define item (text a-word 12 'white)))
    (beside/align 'center BT item)))

(check-expect (render-item1 '(li (word ((text "one")))))
              (beside/align 'center (circle 2 'solid 'white) (text "one" 12 'white)))

(check-expect (render-item1 '(li (word ((text "two")))))
              (beside/align 'center (circle 2 'solid 'white) (text "two" 12 'white)))

;function works by extracting the string from the Xword, then rendering the bullet and rendering the string as text


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
