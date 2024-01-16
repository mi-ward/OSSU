;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_278) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 278.
;Feeding Worms explains how another one of the oldest computer games work.
;The game features a worm that moves at a constant speed in a player-controlled direction.
;When it encounters food, it eats the food and grows.
;When it runs into the wall or into itself, the game is over.

;This project can also benefit from the abstract list-processing functions in ISL.
;Look for places to use them and replace existing code, a piece at a time.
;Tests will ensure that you aren’t introducing mistakes. 