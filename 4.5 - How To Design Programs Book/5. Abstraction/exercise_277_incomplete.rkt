;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_277) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 277. Full Space War spells out a game of space war.
;In the basic version, a UFO descends and a player defends with a tank.
;One additional suggestion is to equip the UFO with charges that it can drop at the tank;
;the tank is destroyed if a charge comes close enough.

;Inspect the code of your project for places where it can benefit from existing abstraction,
;that is, processing lists of shots or charges.

;Once you have simplified the code with the use of existing abstractions,
;look for opportunities to create abstractions.
;Consider moving lists of objects as one example where abstraction may pay off.