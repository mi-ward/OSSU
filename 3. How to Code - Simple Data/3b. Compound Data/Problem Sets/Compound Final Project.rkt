;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Compound Final Project|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; space traveler
;; block that moves around based on gradual speed increase


;; Constants

(define WIDTH 500)
(define HEIGHT 500)
(define MTS (empty-scene WIDTH HEIGHT))
(define BLOCK (square 5 "solid" "red"))

(define CTR-Y (/ HEIGHT 2))
(define CTR-X (/ WIDTH 2))
(define X_ACCEL 10)
(define Y_ACCEL 10)

;; DATA
(define-struct ship (x y dx dy))
;; Ship is (make-ship Number[0, WIDTH], Number [0, HEIGHT], Number, Number)
;; defines the x, y coordinates of the ship as well as the directional acceleration of the ship
(define S1 (make-ship 0 0 0 0))
(define S2 (make-ship 250 250 4 -1))

(define (fn-for-ship s)
  (... (ship-x s)
       (ship-y s)
       (ship-dx s)
       (ship-dy s)))

;; Template rules used:
;;  - compound data: 4 fields - Number[0, WIDTH], Number [0, HEIGHT], Number, Number

;; Functions
; =============

;; Ship is Ship
;; start the ship with (main (make-ship CTR-X CTR-Y 0 0))
;; displays the ship, allows movement with arrow keys, resets position with space bar
(define (main s)
  (big-bang s           ;; Ship
    (on-tick  move)      ;; Ship -> Ship
    (to-draw  render)      ;; Ship -> Image
    (on-key   key-handler)))    ;; Ship KeyEvent -> Ship

;; <no tests for main>

;; Ship -> Ship
;; move the ship based on current set acceleration

(check-expect (move (make-ship 0 0 0 0)) (make-ship 0 0 0 0))
(check-expect (move (make-ship 0 0 5 7)) (make-ship 5 7 5 7))
(check-expect (move (make-ship 5 7 1 -1)) (make-ship 6 6 1 -1))
(check-expect (move (make-ship 200 300 -1 -1)) (make-ship 199 299 -1 -1))
(check-expect (move (make-ship WIDTH HEIGHT 2 2)) (make-ship (+ WIDTH 2) (+ HEIGHT 2) 2 2))
              

(define (move s)
  (make-ship (+ (ship-x s) (ship-dx s))
             (+ (ship-y s) (ship-dy s))
             (ship-dx s)
             (ship-dy s)))
       
;(define (move s) s)  ;stub

;; Ship -> Image
;; places image of ship on MTS
;; if ship goes out of bounds reset location to opposite side still traveling in the same direction
;(define (render s) MTS) ;; stub

(check-expect (render (make-ship 0 0 0 0)) (place-image BLOCK 0 0 MTS))
(check-expect (render (make-ship CTR-X CTR-Y 0 0)) (place-image BLOCK CTR-X CTR-Y MTS))
(check-expect (render (make-ship CTR-X CTR-Y 10 10)) (place-image BLOCK CTR-X CTR-Y MTS))
(check-expect (render (make-ship CTR-X CTR-Y -10 -1)) (place-image BLOCK CTR-X CTR-Y MTS))
(check-expect (render (make-ship CTR-X CTR-Y 10 -1)) (place-image BLOCK CTR-X CTR-Y MTS))
(check-expect (render (make-ship CTR-X CTR-Y -10 1)) (place-image BLOCK CTR-X CTR-Y MTS))
(check-expect (render (make-ship (+ 3 WIDTH) (+ 3 HEIGHT) -10 -1)) (place-image BLOCK 3 3 MTS))
(check-expect (render (make-ship (+ 3 WIDTH) CTR-Y -10 -1)) (place-image BLOCK 3 CTR-Y MTS))
(check-expect (render (make-ship CTR-X (+ 3 HEIGHT) -10 -1)) (place-image BLOCK CTR-X 3 MTS))
(check-expect (render (make-ship CTR-X (- 0 100) -10 -1)) (place-image BLOCK CTR-X (- HEIGHT 100) MTS))
(check-expect (render (make-ship (- 0 100) CTR-Y -10 -1)) (place-image BLOCK (- WIDTH 100) CTR-Y MTS))
(check-expect (render (make-ship (- 0 100) (- 0 100) -10 -1)) (place-image BLOCK (- WIDTH 100) (- HEIGHT 100) MTS))


(define (render s)
  (place-image BLOCK (modulo (ship-x s) WIDTH) (modulo (ship-y s) HEIGHT) MTS))     

;; Ship KeyEvent -> Ship
;; accelerates or descelerates the ship based on keyboard arrow input, space key resets location
;(define (key-handler ke s) s)  ;; stub

(check-expect (key-handler (make-ship 0 0 0 0) "left") (make-ship 0 0 (- 0 X_ACCEL) 0))
(check-expect (key-handler (make-ship 0 0 0 0) "right" ) (make-ship 0 0 (+ 0 X_ACCEL) 0))
(check-expect (key-handler (make-ship 0 0 0 0) "down") (make-ship 0 0 0 (+ 0 Y_ACCEL)))
(check-expect (key-handler (make-ship 0 0 0 0) "up" ) (make-ship 0 0 0 (- 0 Y_ACCEL)))
(check-expect (key-handler (make-ship 0 0 0 0) " ") (make-ship CTR-X CTR-Y 0 0))
(check-expect (key-handler (make-ship 250 113 10 -1) " ") (make-ship CTR-X CTR-Y 0 0))
(check-expect (key-handler (make-ship CTR-X CTR-Y 0 0) " ") (make-ship CTR-X CTR-Y 0 0))
(check-expect (key-handler (make-ship 250 113 10 -1) "a") (make-ship 250 113 10 -1))


(define (key-handler s ke)
  (cond [(key=? ke "left")  (make-ship (ship-x s) (ship-y s) (- (ship-dx s) X_ACCEL)    (ship-dy s)         )]
        [(key=? ke "right") (make-ship (ship-x s) (ship-y s) (+ (ship-dx s) X_ACCEL)    (ship-dy s)         )]
        [(key=? ke "up")    (make-ship (ship-x s) (ship-y s)    (ship-dx s)          (- (ship-dy s) Y_ACCEL))]
        [(key=? ke "down")  (make-ship (ship-x s) (ship-y s)    (ship-dx s)          (+ (ship-dy s) Y_ACCEL))]
        [(key=? ke " ")     (make-ship  CTR-X      CTR-Y         0                    0                     )]
        [else               (make-ship (ship-x s) (ship-y s)    (ship-dx s)             (ship-dy s)         )]))
  

     
(main (make-ship CTR-X CTR-Y 0 0))