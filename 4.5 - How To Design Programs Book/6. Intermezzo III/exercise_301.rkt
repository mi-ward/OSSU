;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_301) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 301. Draw a box around the scope of each
;binding occurrence of sort and alon in figure 105.

;Then draw arrows from each occurrence of sort to the
;appropriate binding occurrence.

;Now repeat the exercise for the variant in figure 106.
;Do the two functions differ other than in name?

;figure 105
(define (insertion-sort alon)
  (local ((define (sort alon);-----;                      ;
            (cond                  ;                      ;
              [(empty? alon) '()]  ;                      ;
              [else               ;v                      ;
               (add (first alon) (sort (rest alon)))]))   ;
          (define (add an alon)                           ;
            (cond                                         ;
              [(empty? alon) (list an)]                   ;
              [else                                       ;
               (cond                                      ;
                 [(> an (first alon)) (cons an alon)]     ;
                 [else (cons (first alon)                 ;
                             (add an (rest alon)))])])))  ;
  (sort alon))) 

(define (sort alon)
  (local ((define (sort alon);-----;                      ;
            (cond                  ;                      ;
              [(empty? alon) '()]  ;                      ;
              [else               ;v                      ;
               (add (first alon) (sort (rest alon)))]))   ;
          (define (add an alon)                           ;
            (cond                                         ;
              [(empty? alon) (list an)]                   ;
              [else                                       ;
               (cond                                      ;
                 [(> an (first alon)) (cons an alon)]     ;
                 [else (cons (first alon)                 ;
                             (add an (rest alon)))])])))  ;
  (sort alon)))

;These are the same other than name
                    