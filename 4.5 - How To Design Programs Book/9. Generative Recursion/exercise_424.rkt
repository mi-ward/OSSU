;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise_424) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 424.
;Draw a quick-sort diagram like the one in figure 148 for (list 11 9 2 18 12 14 4 1)

;                             (list 11 9 2 18 12 14 4 1)
;                          |              |                   |
;                   (list 9 2 4 1)        11           (list 18 12 14)
;                  |       |     |        v           |                  |
;        (list 2 4 1)      9    '()       v       (list 12 14)           18    '()
;              |            v     v       v          |                   v     v
;  (list 1)    2    (list 4)  v    v      v     '()  12   (list 14)    '(18)
;      |       v        |      v    v     v          v       |           v
; '()  1  '()  v   '()  4  '()  v    v    v          v '()  14 '()      v
;   v  v   v   v     v  v   v   v    v    v          v       v          v
;    v  v  v   v       v  v     v    v    v          '(12)  '(14)       v
;     v  v  v  v       '(4)     v    v    v              v     v       v
;       '(1)   v        v       v    v    v               v    v      v
;         v    v       v       v     v    v                v   v    v
;          v   v    v        v     v      v               '(12 14 18)
;          '(1 2 4)         v    v        v                  v
;                v         v    v         v                 v
;                 v       v    v          v                v
;                    '(1 2 4 9)          11        '(12 14 18)
;                            v            v          v
;                              v          v         v
;                                v        v       v
;                               '(1 2 4 9 11 12 14 18)