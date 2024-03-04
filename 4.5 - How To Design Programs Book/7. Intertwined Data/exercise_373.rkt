;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_373) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))



(require 2htdp/image)

;Exercise 373
;Figure 128 is missing test cases. Develop test cases for all the functions.


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
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (list XWord)))
; – (cons 'li (cons XEnum.v2 '()))
; – (cons 'li (cons [List-of Attribute] (list XEnum.v2)))
; 
; An XEnum.v2 is one of:
; – (cons 'ul [List-of XItem.v2])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v2]))


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

(check-expect (render-item1 '(li (word ((text "one")))))
              (beside/align 'center (circle 1 'solid 'white)
                            (text " " 12 'white)
                            (text "one" 12 'white)))

(check-expect (render-item1 '(li (word ((text "two")))))
              (beside/align 'center (circle 1 'solid 'white)
                            (text " " 12 'white)
                            (text "two" 12 'white)))

;function works by extracting the string from the Xword, then rendering the bullet and rendering the string as text
 
; Image -> Image
; marks item with bullet  
(define (bulletize item)
  (beside/align 'center BT item))

(check-expect (bulletize (text "text" SIZE COLOR))
              (beside/align 'center BT (text "text" SIZE COLOR)))
 
; XEnum.v2 -> Image
; renders an XEnum.v2 as an image 
(define (render-enum xe)
  (local ((define content (xexpr-content xe))
          ; XItem.v2 Image -> Image 
          (define (deal-with-one item so-far)
            (above/align 'left (render-item item) so-far)))
    (foldr deal-with-one empty-image content)))

(check-expect (render-enum '(ul (li (word ((text "one"))))))
              (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white) (text "one" 12 'white)))
(check-expect (render-enum '(ul (li (word ((text "one")))) (li (word ((text "two"))))))
              (above/align 'left (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white) (text "one" 12 'white))
                           (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white) (text "two" 12 'white))))
 
; XItem.v2 -> Image
; renders one XItem.v2 as an image 
(define (render-item an-item)
  (local ((define content (first (xexpr-content an-item))))
    (bulletize
     (cond
       [(word? content)
        (text (word-text content) SIZE 'white)]
       [else (render-enum content)]))))

(check-expect (render-item '(li (word ((text "one")))))
              (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white) (text "one" 12 'white)))
(check-expect (render-item '(li (word ((text "two")))))
              (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white) (text "two" 12 'white)))

(check-expect (render-item '(li (link ((link "two.com")))))
              (beside/align 'center (circle 1 'solid 'white) (text " " 12 'white)))


;Explanation:
;1) pulls the content out of the xexpr
;2) creates a function for separating the first item from the rest of the xexpr
;3) creates a function to run above align against the the rendered-item version of the first item and the rest of the items
;4) runs a fold function with this created function with a base case of empty-image
;5) render-item checks if the first item is a word, if it is it creates a text render with a bullet, otherwise bulletize keeps looking for words

; XEnum.v1 -> Image 
; renders a simple enumeration as an image 
(define (render-enum1 xe) empty-image)



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
(check-expect (render-enum1 e0) empty-image)