;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_340) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)

;Exercise 340.

;Design the function ls, which lists the names of all files and directories in a given Dir.

(define OSSU1 (create-dir "/Users/michael/dev/OSSU"))
(define OSSU2 (create-dir "/Users/michael/dev/OSSU/4.5 - How To Design Programs Book/7. Intertwined Data"))
(define OSSU3 (create-dir "/Users/michael/dev/OSSU/4.5 - How To Design Programs Book"))

;Dir -> (List of String)
; lists names of all files and directories in a given dir
(define (ls a)
  (sort (append (map dir-name (dir-dirs a))
          (map file-name (dir-files a))) string<=?))

;List-of Dir -> List-of String
(define (traverse-dirlist dirlist)
  (cond [(empty? dirlist) '()]
        [else
         (append (traverse-dirs (first dirlist))
                 (traverse-dirlist (rest dirlist)))]))

;Dir -> List-of String
(define (traverse-dirs dir)
  (cond [(empty? (dir-dirs dir)) (ls dir)]
        [else (traverse-dirlist (dir-dirs dir))]))

;=====================================================

(define (ls_all dir)
  (local [(define (traverse-dirlist dirlist)
            (cond [(empty? dirlist) '()]
                  [else
                   (append (traverse-dirs (first dirlist))
                           (traverse-dirlist (rest dirlist)))]))
          
          (define (traverse-dirs dir)
            (cond [(empty? (dir-dirs dir)) (append (map dir-name (dir-dirs dir)) (map file-name (dir-files dir)))]
                  [else (traverse-dirlist (dir-dirs dir))]))]
    (traverse-dirs dir)))


(check-expect (sort (ls_all OSSU1) string<=?) (sort (traverse-dirs OSSU1) string<=?))


(define (ls2 d)
  (sort (append (map (lambda (dir) (string-append (dir-name dir)))
                     (dir-dirs d))
                (map file-name (dir-files d))) string<?))

(ls OSSU1)
(ls2 OSSU1)

(check-expect (ls OSSU1) (ls2 OSSU1))