;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_365) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 365. Interpret the following elements of Xexpr.v2 as XML data:

'(server ((name "example.org")))
;<server name="example.org" />

'(carcas (board (grass)) (player ((name "sam"))))
;<carcas> <board> <grass /> </board> <player name="sam" /> </carcas>

'(start)
;<start />

;Which ones are elements of Xexpr.v0 or Xexpr.v1?
; - The last one cause no attributes