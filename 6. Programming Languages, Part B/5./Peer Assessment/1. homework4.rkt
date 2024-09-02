#lang racket

;; Problema 1: Función para sumar dos números
(define (suma x y)
  (+ x y))

;; Problema 2: Función para verificar si un número es par
(define (es-par n)
  (zero? (modulo n 2)))

;; Problema 3: Función para calcular el factorial de un número
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

;; Problema 4: Función para encontrar el máximo de una lista de números
(define (maximo lista)
  (apply max lista))

;; Problema 5: Función para invertir una lista
(define (invertir lista)
  (reverse lista))

;; Función auxiliar para pruebas
(define (pruebas)
  (begin
    (printf "Suma de 3 y 5: ~a\n" (suma 3 5))
    (printf "¿Es 4 par? ~a\n" (es-par 4))
    (printf "Factorial de 5: ~a\n" (factorial 5))
    (printf "Máximo de (1 3 5 2 4): ~a\n" (maximo '(1 3 5 2 4)))
    (printf "Lista invertida de (1 2 3): ~a\n" (invertir '(1 2 3)))))

;; Llamar a la función de pruebas
(pruebas)
