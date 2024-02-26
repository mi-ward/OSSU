;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_339) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)

;Exercise 339
;Design find?.
;The function consumes a Dir and a file name and determines whether or not a file with this name occurs in the directory tree.

; Dir String -> Boolean
; determines whether or not a file with this name occurs in the directory tree
(define (find? dir file_name)
  (cond [(member? file_name (map file-name (dir-files dir))) #true]
        [(empty? (dir-dirs dir)) #false]
        [else (ormap (lambda (d) (find? d file_name)) (dir-dirs dir))]))


(define OSSU1 (create-dir "/Users/michael/dev/OSSU"))
(define OSSU2 (create-dir "/Users/michael/dev/OSSU/4.5 - How To Design Programs Book/7. Intertwined Data"))

(check-expect (find? OSSU2 "exercise_309.rkt") #false)
(check-expect (find? OSSU2 "exercise_310.rkt") #true)
(check-expect (find? OSSU1 "exercise_310.rkt") #true)
(check-expect (find? OSSU1 "exercise_339.rkt") #true)