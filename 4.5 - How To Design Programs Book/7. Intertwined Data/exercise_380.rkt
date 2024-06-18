;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_380) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;Exercise 380
;Reformulate the data definition for 1Transition so that
;it is possible to restrict transitions to certain keystrokes.
;Try to formulate the change so that find continues to work without change.
;What else do you need to change to get the complete program to work?
; - the big-bang function
;Which part of the design recipe provides the answer(s)?
; - the signature
;See exercise 229 for the original exercise statement.

; An FSM is a [List-of 1Transition]

; A 1Transition is a structure:
; (make-1Transition (cons FSM-State (cons FSM-State '())) key-event)
(define-struct 1Transition [FSM key-event])


; An FSM-State is a non-empty String that specifies a color

; data examples
(define fsm-traffic
  (list (make-1Transition '("red" "green") "g")
        (make-1Transition '("green" "yellow") "y")
        (make-1Transition '("yellow" "red") "r")))

; FSM FSM-State -> FSM-State
; matches the keys pressed by a player with the given FSM
(define (simulate state0 transitions)
  (big-bang state0 ; FSM-State
    [to-draw (lambda (current) (overlay
                                (text current 12 "black")
                                (square 100 "solid" current)))]
    [on-key (lambda (current key-event)
              (if (string=? key-event
                            (1Transition-key-event
                             (first (filter (lambda (1T) (string=? current (first (1Transition-FSM 1T)))) transitions)))) 
                  (find (map 1Transition-FSM transitions) current) current))]))


              

; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist
(define (find alist x)
  (local [(define fm (assoc x alist))]
    (if (cons? fm) (second fm) (error "not found"))))

(check-expect (find (list (list 1 2)) 1) 2)
(check-expect (find (list (list 1 2) (list 3 4)) 1) 2)
(check-expect (find (list (list 1 2) (list 3 4)) 3) 4)
(check-error (find (list (list 1 2) (list 3 4)) 4) "not found")