;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_370) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 370
;Make up three examples for XWords.
;Design word?, which checks whether some ISL+ value is in XWord,
;and word-text, which extracts the value of the only attribute of an instance of XWord.

;[List-of Attributes] Symbol -> String or false
;retrieve the string related to the symbol if the symbol exists otherwise false
(define (find-attr attr-list sym)
  (if (false? (assq sym attr-list)) #false (second (assq sym attr-list))))

; An XWord is '(word ((text String))).

(define word1 '(word ((text "String"))))
(define word2 '(word ((text "word"))))
(define word3 '(word ((text "wordstring"))))
(define word4 '(blorp ((text "wordstring"))))

;Xword -> Boolean
;checks whether xword has a value
(define (word? xword)
  (symbol=? 'word (first xword)))

(check-expect (word? word1) #true)
(check-expect (word? word2) #true)
(check-expect (word? word3) #true)
(check-expect (word? word4) #false)

;Xword -> String
;extracts the string from a word
(define (word-text xword)
  (if (word? xword)
      (find-attr (second xword) 'text)
      '()))

(check-expect (word-text word1) "String")
(check-expect (word-text word4) '())

  