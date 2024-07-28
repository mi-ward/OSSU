;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ta-solver-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; ta-solver-starter.rkt



;  PROBLEM 1:
;
;  Consider a social network similar to Twitter called Chirper. Each user has a name, a note about
;  whether or not they are a verified user, and follows some number of people.
;
;  Design a data definition for Chirper, including a template that is tail recursive and avoids
;  cycles.
;
;  Then design a function called most-followers which determines which user in a Chirper Network is
;  followed by the most people.
;

(define-struct user (name verified? following))
; A User is (make-user String Boolean (list of Users)

(define U0 (make-user "User0" #true '()))
(define U1 (make-user "User1" #true (list U0)))
(define U2 (make-user "User2" #true (list U0 U1)))
(define U3 (make-user "User3" #true (list U0 U2)))
(define U4 (make-user "User4" #true (list U0 U2)))
(define U5 (make-user "User5" #true (list U0 U3)))
(define U6 (make-user "User6" #true (list U0 U4)))
(define U7 (make-user "User7" #true (list U0 U4)))
(define U8 (make-user "User8" #true (list U0 U7)))
(define U9 (make-user "User9" #true (list U0 U3)))

; A Network is a List-of Users
(define N1 (list U0 U1 U2 U3 U4 U5 U6 U7 U8 U9))
(define N2 (list U0 U1 U2 U3 U4))
(define N3 (list U5 U6 U7 U8 U9))
(define N4 (list U1 U2 U3 U4 U5 U6 U7 U8 U9))

(check-expect (most-followers N1) U0)
(check-expect (most-followers N2) U0)
(check-expect (most-followers N3) U7)
(check-expect (most-followers N4) U4)

(define (most-followers lou0)
  (local [(define (fn-for-user todo rsf)
            (fn-for-lou todo rsf))
          (define (fn-for-lou todo rsf)
            (cond
              [(empty? todo) rsf]
              [else (fn-for-user (rest todo) (count (user-following (first todo)) rsf))]))
          
          (define (count lou rsf)
            (cond
              [(empty? lou) rsf]
              [else
               (count (rest lou) (count-one (first lou) rsf))]))
          
          (define (count-one u rsf)
            (if (member u lou0)
                (if (member u (map first rsf))
                    (add-to u rsf)
                    (cons (list u 1) rsf))
                rsf))
          
          (define (add-to u rsf)
            (cond
              [(empty? rsf) '()]
              [else
               (if (string=? (user-name (first (first rsf))) (user-name u))
                   (cons (list u (add1 (second (first rsf)))) (rest rsf))
                   (cons (first rsf) (add-to u (rest rsf))))]))
          
          (define (most-followers* lorsf0)
            (local [(define (most-followers* lorsf acc)
                      (cond
                        [(empty? lorsf) (first acc)]
                        [else
                         (if (> (second (first lorsf)) (second acc))
                             (most-followers* (rest lorsf) (first lorsf))
                             (most-followers* (rest lorsf) acc))]))]
              (most-followers* (rest lorsf0) (first lorsf0))))]
            
           
    
    
    (most-followers* (fn-for-lou lou0 '()))))


(define-struct user2 (name verified? following))
;; User is (String Boolean (listof User))
;; interp. user's name, verified status, and list of other users they follow
(define UA (make-user2 "A" true (list (make-user2 "B" true empty))))

(define UB
  (shared ((-A- (make-user2 "A" true (list -B-)))
           (-B- (make-user2 "B" true (list -A-))))
    -A-))

(define UC
  (shared ((-A- (make-user2 "A" true (list -B-)))
           (-B- (make-user2 "B" true (list -C-)))
           (-C- (make-user2 "C" true (list -A-))))
    -A-))

(define UD
  (shared ((-A- (make-user2 "A" true (list -B- -D-)))
           (-B- (make-user2 "B" true (list -C- -E-)))
           (-C- (make-user2 "C" true (list -B-)))
           (-D- (make-user2 "D" true (list -E-)))
           (-E- (make-user2 "E" true (list -F- -A-)))
           (-F- (make-user2 "F" true (list))))
    -A-))
        
(define (most-followers2 u)
  (local [(define (fn-for-user u todo visited acc)
            (if (member (user2-name u) visited)
                (fn-for-lou todo visited acc)
                (fn-for-lou (append (user2-following u) todo)
                            (append (list (user2-name u)) visited)
                            (append (user2-following u) acc))))

          (define (fn-for-lou todo visited acc)
            (cond
              [(empty? todo) acc]
              [else
               (fn-for-user (first todo) (rest todo) visited acc)]))

            
            
          (define (count-most-followers lou0)
            (local [(define-struct result [user count])
                    
                    (define (add-to u lor)
                      (cond
                        [(empty? lor) '()]
                        [(string=? (user2-name u) (user2-name (result-user (first lor))))
                         (cons (make-result u (add1 (result-count (first lor))))
                               (rest lor))]
                        [else (cons (first lor) (add-to u (rest lor)))]))
                    
                    (define (count-most-followers lou wfl)
                      (cond
                        [(empty? lou) wfl]
                        [(member (first lou) (map (lambda (x) (result-user x))  wfl))
                         (count-most-followers (rest lou) (add-to (first lou) wfl))]
                        [else
                         (count-most-followers (rest lou) (cons (make-result (first lou) 1) wfl))]))

                    (define (largest lor)
                      (local [(define (largest lor acc)
                                (cond [(empty? lor) (result-user acc)]
                                      [else
                                       (if (>= (result-count (first lor)) (result-count acc))
                                           (largest (rest lor) (first lor))
                                           (largest (rest lor) acc))]))]
                        (largest (rest lor) (first lor))))]
                      
              (largest (count-most-followers lou0 '()))))]
    (count-most-followers (fn-for-user u '() '() '()))))


(check-expect (most-followers2 UA) (make-user2 "B" true empty))
(check-expect (most-followers2 UB) UB)
(check-expect (most-followers2 UC) UC)
(check-expect (most-followers2 UD) (shared ((-A- (make-user2 "A" true (list -B- -D-)))
                                            (-B- (make-user2 "B" true (list -C- -E-)))
                                            (-C- (make-user2 "C" true (list -B-)))
                                            (-D- (make-user2 "D" true (list -E-)))
                                            (-E- (make-user2 "E" true (list -F- -A-)))
                                            (-F- (make-user2 "F" true (list))))
                                     -E-))

(check-expect (most-followers2 UA) (first (user2-following UA)))
(check-expect (most-followers2 (shared ((-A- (make-user2 "A" true (list -B- -C-)))
                                        (-B- (make-user2 "B" true (list -C-)))
                                        (-C- (make-user2 "C" true (list -A-))))
                                 -A-))
              (shared ((-A- (make-user2 "A" true (list -B- -C-)))
                       (-B- (make-user2 "B" true (list -C-)))
                       (-C- (make-user2 "C" true (list -A-))))
                -C-))
(check-expect (most-followers2 (shared ((-A- (make-user2 "A" true (list -B- -C-)))
                                        (-B- (make-user2 "B" true empty))
                                        (-C- (make-user2 "C" true (list -B-))))
                                 -A-))
              (shared ((-A- (make-user2 "A" true (list -B- -C-)))
                       (-B- (make-user2 "B" true empty))
                       (-C- (make-user2 "C" true (list -B-))))
                -B-))
(check-expect (most-followers2 (shared ((-A- (make-user2 "A" true (list -B- -C-)))
                                        (-B- (make-user2 "B" true (list -A-)))
                                        (-C- (make-user2 "C" true (list -A-))))
                                 -A-))
              (shared ((-A- (make-user2 "A" true (list -B- -C-)))
                       (-B- (make-user2 "B" true (list -A-)))
                       (-C- (make-user2 "C" true (list -A-))))
                -A-))
(check-expect (most-followers2 (shared ((-A- (make-user2 "A" true (list -B- -C- -D-)))
                                        (-B- (make-user2 "B" true (list -C- -D-)))
                                        (-C- (make-user2 "C" true (list -D-)))
                                        (-D- (make-user2 "C" true (list -A-))))
                                 -A-))
              (shared ((-A- (make-user2 "A" true (list -B- -C- -D-)))
                       (-B- (make-user2 "B" true (list -C- -D-)))
                       (-C- (make-user2 "C" true (list -D-)))
                       (-D- (make-user2 "C" true (list -A-))))
                -D-))

;  PROBLEM 2:
;
;  In UBC's version of How to Code, there are often more than 800 students taking
;  the course in any given semester, meaning there are often over 40 Teaching Assistants.
;
;  Designing a schedule for them by hand is hard work - luckily we've learned enough now to write
;  a program to do it for us!
;
;  Below are some data definitions for a simplified version of a TA schedule. There are some
;  number of slots that must be filled, each represented by a natural number. Each TA is
;  available for some of these slots, and has a maximum number of shifts they can work.
;
;  Design a search program that consumes a list of TAs and a list of Slots, and produces one
;  valid schedule where each Slot is assigned to a TA, and no TA is working more than their
;  maximum shifts. If no such schedules exist, produce false.
;
;  You should supplement the given check-expects and remember to follow the recipe!


;; Slot is Natural
;; interp. each TA slot has a number, is the same length, and none overlap

(define-struct ta (name max avail))
;; TA is (make-ta String Natural (listof Slot))
;; interp. the TA's name, number of slots they can work, and slots they're available for

(define SOBA (make-ta "Soba" 2 (list 1 3)))
(define UDON (make-ta "Udon" 1 (list 3 4)))
(define RAMEN (make-ta "Ramen" 1 (list 2)))

(define NOODLE-TAs (list SOBA UDON RAMEN))

(define-struct assignment (ta slot))
;; Assignment is (make-assignment TA Slot)
;; interp. the TA is assigned to work the slot

(define SOLVED1 (reverse (list
                 (make-assignment UDON 4)
                 (make-assignment SOBA 3)
                 (make-assignment RAMEN 2)
                 (make-assignment SOBA 1))))

;; Schedule is (listof Assignment)


;; ============================= FUNCTIONS


;; (listof TA) (listof Slot) -> Schedule or false
;; produce valid schedule given TAs and Slots; false if impossible

;
(check-expect (schedule-tas empty empty) empty)
(check-expect (schedule-tas empty (list 1 2)) false)
(check-expect (schedule-tas (list SOBA) empty) empty)

(check-expect (schedule-tas (list SOBA) (list 1)) (list (make-assignment SOBA 1)))
(check-expect (schedule-tas (list SOBA) (list 2)) false)
(check-expect (schedule-tas (list SOBA) (list 1 3)) (list (make-assignment SOBA 1)
                                                          (make-assignment SOBA 3)))

(check-expect (schedule-tas NOODLE-TAs (list 1 2 3 4)) SOLVED1)

(check-expect (schedule-tas NOODLE-TAs (list 1 2 3 4 5)) false)


;(define (schedule-tas tas slots) empty) ;stub

; 1. Produce multiple versions of the schedule
; 2. Identify a schedule that fits the criteria
; 3. For each slot, fill with each person who has that time available
; 4. either remove one from the availability or have an upper bound that you compare against for each TA
; 5. Solved can check if all the TAs have been used

(define (schedule-tas tas slots)
  (local [(define (fn-for-slots slots)
            (if (complete? tas slots)
                slots
                (fn-for-los (next-schedule tas slots))))

          ; create a list of schedules/slots
          (define (fn-for-los slots)
            (cond
              [(empty? slots) #false]
              [else (if (not (false? (fn-for-slots (first slots))))
                        (fn-for-slots (first slots))
                        (fn-for-los (rest slots)))]))]
    (fn-for-slots slots)))

(define (complete? tas slots)
  (cond [(empty? slots) #true]
        [(ormap number? slots) #false]
        [else (local [(define all-assignments? (andmap assignment? slots)) ;all slots have been filled
                      (define all-tas-assigned? (andmap (lambda (x) (member x (map (lambda (x) (ta-name (assignment-ta x))) slots))) (map ta-name tas)))] ;all TAs have been assigned
                ; no TAs below 0 available time
                (andmap identity (list all-assignments? all-tas-assigned?)))])) ; checks if all slots have been filled and all TAs have been utilized

(check-expect (complete? NOODLE-TAs SOLVED1) #true)

; creates a list of schedules in the first slot available
(define (next-schedule tas0 slots0)
  (local [(define (find-next-slot slots) ; find next available slot
            (cond
              [(empty? slots) empty]
              [else
               (if (not (assignment? (first slots)))
                   (first slots)
                   (find-next-slot (rest slots)))]))
          
          (define first-slot (find-next-slot slots0)) ;make local constant
          
          (define (tas-registered-for-that-slot tas fs)    
            (filter (lambda (x) (member fs (ta-avail x))) tas0)) ; analyze tas to discover tas available for that slot

          (define tas-registered (tas-registered-for-that-slot tas0 first-slot)) ; CONSTANT

          (define (currently-scheduled-tas tas slots)               ; identify tas currently scheduled
            (map assignment-ta (filter assignment? slots)))

          (define currently-scheduled (currently-scheduled-tas tas0 slots0))

          (define (available? schedule0 ta0) ; determine if a ta has availability
            (local [(define (available? schedule ta acc)
                      (cond [(= acc (ta-max ta)) #false]
                            [(empty? schedule) #true]
                            [else (if (equal? (first schedule) ta)
                                      (available? (rest schedule) ta (add1 acc))
                                      (available? (rest schedule) ta acc))]))]
              (available? schedule0 ta0 0)))
                
          (define tas-available (filter (lambda (x) (available? currently-scheduled x)) tas-registered)) ; loop through tas registered and see if they're currently scheduled and have availability
            
          
          (define (assign-to-slot tas fs)
            (map (lambda (x) (make-assignment x fs)) tas-available))  ; assign tas to open slot

          (define list-of-assignments (assign-to-slot tas-available first-slot))

          (define (place-into-slot assignment slots)
            (cond [(empty? slots0) '()]
                  [else
                   (if (assignment? (first slots))
                       (cons (first slots) (place-into-slot assignment (rest slots)))
                       (cons assignment (rest slots)))]))]

    (map (lambda (x) (place-into-slot x slots0))  list-of-assignments)))
                   

; place assigned tas into list
            

          
(define ERIKA (make-ta "Erika" 1 (list 1 3 7 9))) ;x
(define RYAN (make-ta "Ryan" 1 (list 1 8 10))) ;x
(define REECE (make-ta "Reece" 1 (list 5 6))) ;x
(define GORDON (make-ta "Gordon" 2 (list 2 3 9))) ;x
(define DAVID (make-ta "David" 2 (list 2 8 9))) ;x ;x
(define KATIE (make-ta "Katie" 1 (list 4 6))) ;x
(define AASHISH (make-ta "Aashish" 2 (list 1 10))) ;x
(define GRANT (make-ta "Grant" 2 (list 1 11)))
(define RAEANNE (make-ta "Raeanne" 2 (list 1 11 12)))
(define ALEX (make-ta "Alex" 1 (list 7)))
(define ERIN (make-ta "Erin" 1 (list 4))) ;x
(define QUIZ-TAs-1 (list ERIKA RYAN REECE GORDON DAVID KATIE AASHISH GRANT RAEANNE))
(define QUIZ-TAs-2 (list ERIKA RYAN REECE GORDON DAVID KATIE AASHISH GRANT RAEANNE ALEX))
(define QUIZ-TAs-3 (list ERIKA RYAN REECE GORDON DAVID KATIE AASHISH GRANT RAEANNE ERIN))
(check-expect (schedule-tas QUIZ-TAs-1
                     (list 1 2 3 4 5 6 7 8 9 10 11 12))
              false)

(check-expect (schedule-tas QUIZ-TAs-2
                     (list 1 2 3 4 5 6 7 8 9 10 11 12))
              false)

(check-expect (schedule-tas QUIZ-TAs-3
                     (list 1 2 3 4 5 6 7 8 9 10 11 12))
              true)

                                         
              
              


;
;(define (schedule-tas tas slots schedule)
;  (if (filled? schedule)
;      schedule
;      (fill-slots tas slots schedule))
;
;  (define (schedule-tas tas slots)
;    (local [(define (fn-for-tas tas)
;              (cond
;                [(empty? tas) ...]
;                [else
;                 ... (tas-name (first tas))
;                 ... (tas-slot (first tas))]))
;          
;            (define (fn-for-slots slots)
;              [(empty? slots) ...]
;              [else
;               ... (first slots)
;               (fn-for-slots (rest slots))])]
;      (fn-for-tas ...)))
;     
;     

