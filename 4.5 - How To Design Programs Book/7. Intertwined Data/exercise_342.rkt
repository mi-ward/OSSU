;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_342) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)

;Exercise 342

(define OSSU1 (create-dir "/Users/michael/dev/OSSU"))
(define OSSU2 (create-dir "/Users/michael/dev/OSSU/4.5 - How To Design Programs Book/7. Intertwined Data"))
(define OSSU3 (create-dir "/Users/michael/dev/OSSU/4.5 - How To Design Programs Book"))

(define Text (make-dir "Text" '() (list (make-file "part1" 99 "")
                                        (make-file "part2" 52 "")
                                        (make-file "part3" 17 ""))))
(define Code (make-dir "Code" '() (list (make-file "hang" 8 "")
                                        (make-file "draw" 2 ""))))
(define Docs (make-dir "Docs" '() (list (make-file "read!" 19 ""))))
(define Libs (make-dir "Libs" (list Code Docs) '()))
(define TS (make-dir "TS" (list Text Libs) (list (make-file "read!" 10 ""))))

;Design find. The function consumes a directory d and a file name f.
;If (find? d f) is #true, find produces a path to a file with name f;
;otherwise it produces #false.

;Hint While it is tempting to first check whether the file name occurs
;in the directory tree, you have to do so for every single sub-directory.
;Hence it is better to combine the functionality of find? and find.

;Challenge The find function discovers only one of the two files named read! in figure 123.
;Design find-all, which generalizes find and produces the list of all paths that
;lead to f in d. What should find-all produce when (find? d f) is #false?

;Is this part of the problem really a challenge compared to the basic problem?

;File Dir -> String or #false
;finds the file and produces it
(define (find? dir file)
  (cond [(member? file (map file-name (dir-files dir))) #true]
        [(empty? (dir-dirs dir)) #false]
        [else (ormap (lambda (d) (find? d file)) (dir-dirs dir))]))

;Dir FileName -> String or #false
;produces a path to a file with name f, otherwise false
(define (find dir fn)
  (cond [(and (find? dir fn) (empty? (filter (lambda (d) (find? d fn)) (dir-dirs dir)))) (string-append (dir-name dir) "/" fn)]
        [(find? dir fn) (string-append (dir-name dir) "/"  (find (first (filter (lambda (d) (find? d fn)) (dir-dirs dir))) fn))]
        [else #false]))
      
(check-expect (find TS "part8") #false)
(check-expect (find TS "part1") "TS/Text/part1")
(check-expect (find TS "hang") "TS/Libs/Code/hang")
(check-expect (find TS "read!") "TS/Libs/Docs/read!")

;(define (find file dir)
;  (cond [(not (find? file dir)) #false]
;        [(empty? dir) file]
;        [else
;         (cons (dir-name dir) (foldr append  (lambda (d) (find file d)) (dir-dirs dir)))]))
        


        
;[(find? file dir) (string-append (dir-name dir) "/" (filter dir? (map (lambda (d) (find file d)) (dir-dirs dir))))]))
        
      


                
  
      
  
