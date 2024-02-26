;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_343) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)

;Exercise 343

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

;==================================================================

;Design the function ls-R, which lists the paths to all files contained in a given Dir.

;Dir  -> [List-of Path]
(define (ls-R dir)
  (append (create-file-paths (dir-name dir) (dir-files dir))
          (create-dir-paths (dir-name dir) (dir-dirs dir))))

(check-expect (ls-R TS)
              (list (list "TS" "read!")
                    (list "TS" "Text" "part1")
                    (list "TS" "Text" "part2")
                    (list "TS" "Text" "part3")
                    (list "TS" "Libs" "Code" "hang")
                    (list "TS" "Libs" "Code" "draw")
                    (list "TS" "Libs" "Docs" "read!")))

;[List-of Files] -> [List-of Path]
(define (create-file-paths dir-name files)
  (cond [(empty? files) '()]
        [else
         (cons (list dir-name (file-name (first files)))
               (create-file-paths dir-name (rest files)))]))

(check-expect (create-file-paths "TS" (dir-files TS))
              (list (list "TS" "read!")))

(check-expect (create-file-paths "Text" (dir-files Text))
              (list (list "Text" "part1")
                    (list "Text" "part2")
                    (list "Text" "part3")))



;[List-of Dir] -> [List-of Path]
(define (create-dir-paths dir-name dir-list)
  (cond [(empty? dir-list) '()]
        [else
         (append (map (lambda (lst) (cons dir-name lst)) (ls-R (first dir-list)))
                 (create-dir-paths dir-name (rest dir-list)))]))


(check-expect (create-dir-paths "Libs" (list Code Docs)) 
              (list (list "Libs" "Code" "hang")
                    (list "Libs" "Code" "draw")
                    (list "Libs" "Docs" "read!")))

;========================================================

(define (ls-R.v2 dir)                           
  (append (map (lambda (fil) (list (dir-name dir) (file-name fil))) (dir-files dir))
          (foldr append '() (map (lambda (map_list) (map (lambda (lst) (cons (dir-name dir) lst)) (ls-R map_list))) (dir-dirs dir)))))


(check-expect (ls-R.v2 TS)
              (list (list "TS" "read!")
                    (list "TS" "Text" "part1")
                    (list "TS" "Text" "part2")
                    (list "TS" "Text" "part3")
                    (list "TS" "Libs" "Code" "hang")
                    (list "TS" "Libs" "Code" "draw")
                    (list "TS" "Libs" "Docs" "read!")))

    


