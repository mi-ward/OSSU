#lang racket

;; Problema 1: Funci�n para sumar dos n�meros
(define (suma x y)
  (+ x y))

;; Problema 2: Funci�n para verificar si un n�mero es par
(define (es-par n)
  (zero? (modulo n 2)))

;; Problema 3: Funci�n para calcular el factorial de un n�mero
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

;; Problema 4: Funci�n para encontrar el m�ximo de una lista de n�meros
(define (maximo lista)
  (apply max lista))

;; Problema 5: Funci�n para invertir una lista
(define (invertir lista)
  (reverse lista))

;; Funci�n auxiliar para pruebas
(define (pruebas)
  (begin
    (printf "Suma de 3 y 5: ~a\n" (suma 3 5))
    (printf "�Es 4 par? ~a\n" (es-par 4))
    (printf "Factorial de 5: ~a\n" (factorial 5))
    (printf "M�ximo de (1 3 5 2 4): ~a\n" (maximo '(1 3 5 2 4)))
    (printf "Lista invertida de (1 2 3): ~a\n" (invertir '(1 2 3)))))

;; Llamar a la funci�n de pruebas
(pruebas)
