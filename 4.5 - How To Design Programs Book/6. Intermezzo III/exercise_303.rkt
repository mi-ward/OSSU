;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_303) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 303.
;Draw arrows from the shaded occurrences of x
;to their binding occurrences in each of the
;following three lambda expressions:

;1.     ;v-------;
(lambda (x y)    ;
  (+ x (* x y))) ;
    ;^----^------;
;2.     ;v-------;
(lambda (x y)    ;
  (+ x ;<--------;   v------------;
     (local ((define x (* y y)))  ;
       (+ (* 3 x);<---------------;
          (/ 1 x)))))             ;
              ;^------------------;
;3.     ;v-----------;
(lambda (x y)        ;
  (+ x ;<------------;
     
              ;v-----;    
     ((lambda (x)    ;
        (+ (* 3 x);<-;
           (/ 1 x))) ;
     (* y y))));^----;

;Also draw a box for the scope of each shaded x and
;holes in the scope as necessary

;1.
;(lambda (x y)    
   ;[[ (+ [x] (* x y)) ]] )

;2.
;(lambda (x y)
;[  (+ [x]
;[    [ (local ((define x (* y y)))
;[       (+ (* 3 x)
;[          (/ 1 x))))] ] )

;3.
;(lambda (x y)
;[ (+ [x]
;[    [((lambda (x)
;[        (+ (* 3 x)
;[           (/ 1 x)))]
;[      (* y y)))  ])