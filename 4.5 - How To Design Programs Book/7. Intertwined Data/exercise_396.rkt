;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_396) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/batch-io)
(require 2htdp/image)
; Exercise 396.
; Hangman is a well-known guessing game.
; One player picks a word, the other player gets told how many letters the word contains.
; The latter picks a letter and asks the first player whether and where this letter occurs in the chosen word.
; The game is over after an agreed-upon time or number of rounds.

; Figure 136 presents the essence of a time-limited version of the game.
; See Local Definitions Add Expressive Power for why checked-compare is defined locally.

; The goal of this exercise is to design compare-word, the central function.
; It consumes the word to be guessed, a word s that represents how much/little the guessing player has discovered, and the current guess. The function produces s with all "_" where the guess revealed a letter.

; Once you have designed the function, run the program like this:
(define LOCATION "/usr/share/dict/words") ; on OS X
(define AS-LIST (read-lines LOCATION))
(define LETTERS (explode "abcdefghijklmnopqrstuvwxyz"))
(define SIZE (length AS-LIST))

; See figure 74 for an explanation. Enjoy and refine as desired!

; =================================================================

; An HM-Word is a [List-of Letter or "_"]
; interpretation "_" represents a letter to be guessed 
 
; HM-Word N -> String
; runs a simplistic hangman game, produces the current state
(define (play the-pick time-limit)
  (local ((define the-word  (explode the-pick))
          (define the-guess (make-list (length the-word) "_"))
          ; HM-Word -> HM-Word
          (define (do-nothing s) s)
          ; HM-Word KeyEvent -> HM-Word 
          (define (checked-compare current-status ke)
            (if (member? ke LETTERS)
                (compare-word the-word current-status ke)
                current-status)))
    (implode
     (big-bang the-guess ; HM-Word
       [to-draw render-word]
       [on-tick do-nothing 1 time-limit]
       [on-key  checked-compare]))))
 
; HM-Word -> Image
(define (render-word w)
  (text (implode w) 22 "black"))

;[List-of 1String] [List-of 1String] 1String -> [List-of 1String]
(define (compare-word word guess attempt)
  (cond
    [(empty? word) '()]
    [(and (string=? attempt (first word)) (string=? attempt (first guess))) (cons (first guess) (compare-word (rest word) (rest guess) attempt))]
    [(and (string=? attempt (first word)) (false? (string=? attempt (first guess)))) (cons (first word) (compare-word (rest word) (rest guess) attempt))]
    [(and (false? (string=? attempt (first word))) (false? (string=? attempt (first guess)))) (cons (first guess) (compare-word (rest word) (rest guess) attempt))]))

(check-expect (compare-word '("c" "a" "t") '("_" "_" "_") "t") '("_" "_" "t"))
(check-expect (compare-word '("c" "a" "t" "t") '("_" "_" "_" "_") "t") '("_" "_" "t" "t"))

(play (list-ref AS-LIST (random SIZE)) 10)

