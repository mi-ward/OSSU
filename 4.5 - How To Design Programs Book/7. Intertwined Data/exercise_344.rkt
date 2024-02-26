;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_344) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)

;Exercise 344

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

(define (ls-R.v2 dir)                           
  (append (map (lambda (fil) (list (dir-name dir) (file-name fil))) (dir-files dir))
          (foldr append '() (map (lambda (map_list) (map (lambda (lst) (cons (dir-name dir) lst)) (ls-R.v2 map_list))) (dir-dirs dir)))))

(define (find-all file dir)
  (local [(define (has-file? path)
            (string=? file (list-ref path (- (length path) 1))))]
  (filter has-file? (ls-R.v2 dir))))

(check-expect (find-all "read!" TS) (list (list "TS" "read!") (list "TS" "Libs" "Docs" "read!")))