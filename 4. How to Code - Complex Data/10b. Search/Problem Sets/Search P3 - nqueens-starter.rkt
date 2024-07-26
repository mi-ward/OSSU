;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Search P3 - nqueens-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(require spd/tags)
(require racket/list)

;;; nqueens-starter.rkt
;
;
;This project involves the design of a program to solve the n queens puzzle.
;
;This starter file explains the problem and provides a few hints you can use
;to help with the solution.
;
;The key to solving this problem is to follow the recipes! It is a challenging
;problem, but if you understand how the recipes lead to the design of a Sudoku
;solve then you can follow the recipes to get to the design for this program.
;  
;
;The n queens problem consists of finding a way to place n chess queens
;on a n by n chess board while making sure that none of the queens attack each
;other.
;
;; example: 4 queens = 4 x 4 chess board
;
;The BOARD consists of n^2 individual SQUARES arranged in 4 rows of 4 columns.
;The colour of the squares does not matter. Each square can either be empty
;or can contain a queen.
;
;
;A POSITION on the board refers to a specific square.
;
;A queen ATTACKS every square in its row, its column, and both of its diagonals.
;
;A board is VALID if none of the queens placed on it attack each other.
;
;A valid board is SOLVED if it contains n queens.
;
;
;There are many strategies for solving nqueens, but you should use the following:
;  
;- Use a backtracking search over a generated arb-arity tree that
;is trying to add 1 queen at a time to the board. If you find a
;valid board with 4 queens produce that result.
;
;- You should design a function that consumes a natural - N - and
;tries to find a solution.
;
;NOTE 1: You can tell whether two queens are on the same diagonal by comparing
;the slope of the line between them. If one queen is at row and column (r1, c1)
;and another queen is at row and column (r2, c2) then the slope of the line
;between them is: (/ (- r2 r1) (- c2 c1)).  If that slope is 1 or -1 then the
;queens are on the same diagonal.

;; CONSTANTS

(define E #false)
(define N 4)
(define Q "Queen")
(define B0  (list E E E E
                  E E E E
                  E E E E
                  E E E E))
(define B14 (list E Q E E
                  E E E E
                  E E E E
                  E E E E))
(define B13 (list E Q E E
                  E E E Q
                  E E E E
                  E E E E))
(define B12 (list E Q E E
                  E E E Q
                  Q E E E
                  E E E E))
(define B1s (list E Q E E
                  E E E Q
                  Q E E E
                  E E Q E))

(define BXr  (list Q Q E E
                   E E E E
                   E E E E
                   E E E E))

(define BXc  (list E E E E
                   E E E E
                   E E E Q
                   E E E Q))
(define BXd  (list E E E E
                   E E E E
                   E E E Q
                   E E Q E))

(define demo (list 1   2  3  4
                   5   6  7  8
                   9  10 11 12
                   13 14 15 16))


      

;; DD
;; A BOARD is Listof Squares
;; interp. typically an X by X square, but we interpret through a list (X * X) length

;; FUNCTIONS


;Number -> Board or False
(define (n-queens n)
  (local [(define board (build-list (* n n) (lambda (x) #false)))
          (define (n-queens-bd bd n_a)
            (if (solved? bd n_a)
                bd
                (n-queens-lobd (next-boards bd n_a) (sub1 n_a))))
          (define (n-queens-lobd lobd n_b)
            (cond [(empty? lobd) false] ; empty because next-boards won't have produced anything cause (next-boards bd (n = 0))
                  [else (local [(define try (n-queens-bd (first lobd) n_b))]
                          (if (not (false? try))
                              try
                              (n-queens-lobd (rest lobd) n_b)))]))]
    (n-queens-bd board n)))

(check-expect (n-queens 4) B1s)
        
;RC POS
(define (r-c->pos r c) (+ (* r N) c)) 

(define (solved? bd n)
  (if (empty? bd)
      #false
      (local [(define attacks (append (create-rows bd)
                                      (create-cols bd)
                                      (create-diags bd)))]
        (and (<= n 0) (andmap no-duplicate-queens? attacks)))))

(check-expect (solved? B1s 0)  #true)
(check-expect (solved? BXr 2) #false)
(check-expect (solved? BXc 2) #false)
(check-expect (solved? BXd 2) #false)
(check-expect (solved? BXr 0) #false)
(check-expect (solved? BXc 0) #false)
(check-expect (solved? BXd 0) #false)

;Lst -> Boolean
(define (no-duplicate-queens? lst)
  (<= (length (filter (lambda (x) (equal? "Queen" x)) lst)) 1))

(check-expect (no-duplicate-queens? (list "Queen" "Queen" #false #false)) #false)
(check-expect (no-duplicate-queens? (list  #false  #false #false "Queen")) #true)




;Board -> List of Rows
; turns board into X number of Rows
(define (create-rows board)
  (if (empty? board)
      '()
      (cons (take board N) (create-rows (drop board N)))))

(check-expect (create-rows B0) (list
                                (list E E E E)
                                (list E E E E)
                                (list E E E E)
                                (list E E E E)))

(check-expect (create-rows B1s) (list
                                 (list E Q E E)
                                 (list E E E Q)
                                 (list Q E E E)
                                 (list E E Q E)))


;Board -> List of Columns
; turns board into X number of columns
(define (create-cols board)
  (local [(define (create-col-row r c)
            (cond
              [(= r N) '()]
              [else
               (cons (list-ref board (r-c->pos r c)) (create-col-row (add1 r) c))]))
    
          (define (create-col* r c)
            (cond
              [(= c N) '()]
              [else (cons (create-col-row r c) (create-col* r (add1 c)))]))]
          
    (create-col* 0 0)))

(check-expect (create-cols B0) (list
                                (list E E E E)
                                (list E E E E)
                                (list E E E E)
                                (list E E E E)))

(check-expect (create-cols B1s) (list
                                 (list E E Q E)
                                 (list Q E E E)
                                 (list E E E Q)
                                 (list E Q E E)))

; define diagonals
; Board -> List of Diagonals
(define (create-diags board)
  (local [(define (create-diag-lst-for r c)
            (cond
              [(or (= N r) (= N c) (< r 0) (< c 0)) '()]
              [else
               (cons (list-ref board (r-c->pos r c)) (create-diag-lst-for (add1 r) (add1 c)))]))
          (define (create-diag-lst-back r c)
            (cond
              [(or (= N r) (= N c) (< r 0) (< c 0)) '()]
              [else
               (cons (list-ref board (r-c->pos r c)) (create-diag-lst-back (add1 r) (sub1 c)))]))

          (define (create-diag* r c)
            (cond
              [(= c N) (create-diag* (add1 r) 0)]
              [(= r N) (list '())]
              [else (append (list (create-diag-lst-for r c)
                                  (create-diag-lst-back r c))
                            (create-diag* r (add1 c)))]))]
    (filter (lambda (x) (> (length x) 1)) (create-diag* 0 0))))
          
              

;Board Number -> Listof Boards
;Produce a list of (length board) boards with a Queen in each square (could potentially check validity here to make it faster/reduce iterations)
;if n is 0 produce empty
(define (next-boards board n)
  (if (or (<= n 0)
          (empty? board)
          (not (local [(define attacks (append (create-rows board)
                                          (create-cols board)
                                          (create-diags board)))]
            (andmap no-duplicate-queens? attacks))))
      '()
      (local [(define len (length board))
              (define (add-queen board i)
                (if (equal? (list-ref board i) "Queen")
                    '()
                    (append (take board i) (list "Queen") (drop board (add1 i)))))
              (define (next-boards* board i)
                (cond
                  [(= i len) '()]
                  [else (cons (add-queen board i)
                              (next-boards* board (add1 i)))]))]
        (next-boards* board 0))))
            
(list
 Q E E E E E E E
 E E E E Q E E E
 E E E E E E E Q
 E E E E E Q E E
 E E Q E E E E E
 E E E E E E Q E
 E Q E E E E E E
 E E E Q E E E E)