#lang racket

(require 2htdp/universe)
(require 2htdp/image)
(require 2htdp/batch-io)

;;---------------------------------------------

; Exercise 384. Figure 133 mentions read-xexpr/web.
; See figure 132 for its signature and purpose statement
; and then read its documentation to determine the difference to its “plain” relative.

;; - The difference between read-xepr/web and read-plain-xexpr/web is that plain does not include any whitespace.

;;---------------------------------------------

; Figure 133 is also missing several important pieces,
; in particular the interpretation of data and purpose statements for all the locally defined functions.
; Formulate the missing pieces so that you get to understand the program.

; An Xexpr.v3 is one of:
;  – Symbol
;  – String
;  – Number
;  – (cons Symbol (cons Attribute*.v3 [List-of Xexpr.v3]))
;  – (cons Symbol [List-of Xexpr.v3])
; 
; An Attribute*.v3 is a [List-of Attribute.v3].
;   
; An Attribute.v3 is a list of two items:
;   (list Symbol String)

;;---------------------------------------------

(define PREFIX "https://finance.yahoo.com/quote/"); "Https://www.google.com/finance?q=")
(define SIZE 22) ; font size 
 
(define-struct data [(price #:mutable) (delta #:mutable)])
; A StockWorld is a structure: (make-data String String)
 
; String -> StockWorld
; retrieves the stock price of co and its change every 15s
(define (stock-alert co)
  ; String -> String
  ; creates a URL string
  (local ((define url (string-append PREFIX co))
          ; [StockWorld -> StockWorld]
          ; retrieves stock data from url
          (define (retrieve-stock-data __w)
            ; [String -> XEXPR] -> StockWorld
            ; collects price and delta from url
            (local ((define x (read-xexpr/web url)))
              (make-data (get x "price")
                         (get x "priceChange"))))
          ; StockWorld -> Image
          ; generates UI
          (define (render-stock-data w)
            (local (; [StockWorld String -> String] -> Image
                    ; renders the data
                    (define (word sel col)
                      (text (sel w) SIZE col)))
              (overlay (beside (word data-price 'black)
                               (text "  " SIZE 'white)
                               (word data-delta 'red))
                       (rectangle 300 35 'solid 'white)))))
    (big-bang (retrieve-stock-data 'no-use)
      [on-tick retrieve-stock-data 15]
      [to-draw render-stock-data])))





