;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_451) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 451.
; A table is a structure of two fields:
; - the natural number length
; - and a function array
; which consumes natural numbers
; and, for those between 0 and length (exclusive), produces answers:

(define-struct table [length array])
; A Table is a structure:
;   (make-table N [N -> Number])

; Since this data structure is somewhat unusual, it is critical to
; illustrate it with examples:
(define table1 (make-table 3 (lambda (i) i)))
 
; N -> Number
(define (a2 i)
  (if (= i 0)
      pi
      (error "table2 is not defined for i =!= 0")))

(define (a3 i)
  (- i 5))
 
(define table2 (make-table 1 a2))

(define table3 (make-table 10 a3))
(define table4 (make-table 10 (lambda (i) (- i 4))))

; Here table1’s array function is defined for more inputs than its length field allows;
; table2 is defined for just one input, namely 0.

; Finally, we also define a useful function for looking up values in tables:
; Table N -> Number
; looks up the ith value in array of t
(define (table-ref t i)
  ((table-array t) i))


; The root of a table t is a number in (table-array t) that is close to 0.
; A root index is a natural number i such that (table-ref t i) is a root of table t.
; A table t is monotonically increasing if (table-ref t 0) is less than (table-ref t 1),
; (table-ref t 1) is less than (table-ref t 2), and so on.


; Design find-linear. The function consumes a monotonically increasing table and
; finds the smallest index for a root of the table.
; Use the structural recipe for N, proceeding from 0 through 1, 2, and so on to the
; array-length of the given table.
; This kind of root-finding process is often called a linear search.

; Table -> N
; consumes a monotonically increasing table and finds the smallest index
; for a root of the table
(define (find-linear table)
  (local ((define f (table-array table))
          (define l (table-length table))
          (define (linear-helper i)
            (cond
              [(zero? (f i)) i]
              [else (linear-helper (add1 i))])))
    (linear-helper 0)))

(check-expect (find-linear table1) 0)
(check-error  (find-linear table2))
(check-expect (find-linear table3) 5)
(check-expect (find-linear table4) 4)


; Design find-binary, which also finds the smallest index for the root of a
; monotonically increasing table but uses generative recursion to do so.
; Like ordinary binary search, the algorithm narrows an interval down to the
; smallest possible size and then chooses the index.
; Don’t forget to formulate a termination argument.

; Hint The key problem is that a table index is a natural number,
; not a plain number. Hence the interval boundary arguments for find must be
; natural numbers. Consider how this observation changes (1) the nature of
; trivially solvable problem instances, (2) the midpoint computation,
; (3) and the decision as to which interval to generate next.
; To make this concrete, imagine a table with 1024 slots and the root at 1023.
; How many calls to find are needed in find-linear and find-binary, respectively?

(define (find-binary table)
  (local ((define f (table-array table))
          (define l (table-length table))
          (define (binary-helper left right)
            (local ((define f-left (f left))
                    (define f-right (f right))
                    (define mid (quotient (+ right left) 2))
                    (define f-mid (f mid)))
              (cond
                [(zero? f-left) left]
                [(zero? f-right) right]
                [(or (<= f-left 0 f-mid) (>= f-mid 0 f-left))
                 (binary-helper left mid)]
                [(or (<= f-mid 0 f-right) (>= f-right 0 f-mid))
                 (binary-helper mid right)]))))
    (binary-helper 0 (table-length table))))

(check-expect (find-binary table1) 0)
(check-error  (find-binary table2))
(check-expect (find-binary table3) 5)



(check-expect (find-binary (make-table 1 (lambda (i) i))) 0)
(check-expect (find-binary (make-table 2 (lambda (i) (- i 1)))) 1)
(check-expect (find-binary table1) 0)
(check-expect (find-binary table4) 4)

























            