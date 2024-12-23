;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise_276) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/itunes)


;Exercise 276.
;Real-World Data: iTunes explains how to analyze the information in an iTunes XML library.
;Design select-album-date.
;The function consumes the title of an album, a date, and an LTracks.
;It extracts from the latter the list of tracks from the given album that have been played after the date.
(define ADDED_DATE (create-date 2015 2 15 12 11 13))
(define BEFORE_DATE (create-date 2023 6 22 16 19 28))
(define AFTER_DATE (create-date 2024 1 9 11 11 43))

(define GOODTIMESBADTIMES  (create-track "Good Times Bad Times"     "Led Zeppelin" "Led Zeppelin" 1969 1 ADDED_DATE 3 BEFORE_DATE))
(define WLL                (create-track "Whole Lotta Love" "Led Zeppelin" "Led Zeppelin II" 1969 1 ADDED_DATE 3 BEFORE_DATE))
(define IS                 (create-track "Immigrant Song"             "Led Zeppelin" "Led Zeppelin III" 1970  1 ADDED_DATE 3 BEFORE_DATE))
(define BLACK-DOG          (create-track "Black Dog"              "Led Zeppelin" "Led Zeppelin IV" 1971 1 ADDED_DATE 3 AFTER_DATE))
(define ROCK-AND-ROLL      (create-track "Rock and Roll"          "Led Zeppelin" "Led Zeppelin IV" 1971 2 ADDED_DATE 8 AFTER_DATE))
(define BATTLE-OF-EVERMORE (create-track "The Battle of Evermore" "Led Zeppelin" "Led Zeppelin IV" 1971 3 ADDED_DATE 2 AFTER_DATE))
(define STH                (create-track "Stairway to Heaven"     "Led Zeppelin" "Led Zeppelin IV" 1971 4 ADDED_DATE 1 BEFORE_DATE))
(define MMH                (create-track "Misty Mountain Hop"     "Led Zeppelin" "Led Zeppelin IV" 1971 5 ADDED_DATE 6 AFTER_DATE))
(define FS                 (create-track "Four Sticks"            "Led Zeppelin" "Led Zeppelin IV" 1971 6 ADDED_DATE 4 AFTER_DATE))
(define GTC                (create-track "Going to California"    "Led Zeppelin" "Led Zeppelin IV" 1971 7 ADDED_DATE 7 AFTER_DATE))
(define WTLB               (create-track "When the Levee Breaks"  "Led Zeppelin" "Led Zeppelin IV" 1971 8 ADDED_DATE 5 AFTER_DATE))

(define LED-ZEPPELIN
  (list
   GOODTIMESBADTIMES
   (create-track "Babe I'm Gonna Leave You" "Led Zeppelin" "Led Zeppelin" 1969 2 ADDED_DATE 6 BEFORE_DATE)
   (create-track "You Shook Me"             "Led Zeppelin" "Led Zeppelin" 1969 3 ADDED_DATE 4 BEFORE_DATE)
   (create-track "Dazed and Confused"       "Led Zeppelin" "Led Zeppelin" 1969 4 ADDED_DATE 3 BEFORE_DATE)
   (create-track "Your Time Is Gonna Come"  "Led Zeppelin" "Led Zeppelin" 1969 5 ADDED_DATE 2 BEFORE_DATE)
   (create-track "Black Mountain Side"      "Led Zeppelin" "Led Zeppelin" 1969 6 ADDED_DATE 9 BEFORE_DATE)
   (create-track "Communicaton Breakdown"   "Led Zeppelin" "Led Zeppelin" 1969 7 ADDED_DATE 2 BEFORE_DATE)
   (create-track "I Can't Quit You Baby"    "Led Zeppelin" "Led Zeppelin" 1969 8 ADDED_DATE 3 BEFORE_DATE)
   (create-track "How Many More Time"       "Led Zeppelin" "Led Zeppelin" 1969 9 ADDED_DATE 4 BEFORE_DATE)
   ))

(define LED-ZEPPELIN2
  (list
   WLL
   (create-track "What Is and What Should Never Be"        "Led Zeppelin" "Led Zeppelin II" 1969 2 ADDED_DATE 8 BEFORE_DATE)
   (create-track "The Lemon Song"                          "Led Zeppelin" "Led Zeppelin II" 1969 3 ADDED_DATE 2 BEFORE_DATE)
   (create-track "Thank You"                               "Led Zeppelin" "Led Zeppelin II" 1969 4 ADDED_DATE 1 BEFORE_DATE)
   (create-track "Heartbreaker"                            "Led Zeppelin" "Led Zeppelin II" 1969 5 ADDED_DATE 6 BEFORE_DATE)
   (create-track "Living Loving Maid (She's Just a Woman)" "Led Zeppelin" "Led Zeppelin II" 1969 6 ADDED_DATE 4 BEFORE_DATE)
   (create-track "Ramble On"                               "Led Zeppelin" "Led Zeppelin II" 1969 7 ADDED_DATE 7 BEFORE_DATE)
   (create-track "Moby Dick"                               "Led Zeppelin" "Led Zeppelin II" 1969 8 ADDED_DATE 5 BEFORE_DATE)
   (create-track "Bring It On Home"                        "Led Zeppelin" "Led Zeppelin II" 1969 9 ADDED_DATE 3 BEFORE_DATE)
   ))

(define LED-ZEPPELIN3
  (list
   IS
   (create-track "Friends"                    "Led Zeppelin" "Led Zeppelin III" 1970  2 ADDED_DATE 8 BEFORE_DATE)
   (create-track "Celebration Day"            "Led Zeppelin" "Led Zeppelin III" 1970  3 ADDED_DATE 2 BEFORE_DATE)
   (create-track "Since I've Been Loving You" "Led Zeppelin" "Led Zeppelin III" 1970  4 ADDED_DATE 1 BEFORE_DATE)
   (create-track "Out on the Tiles"           "Led Zeppelin" "Led Zeppelin III" 1970  5 ADDED_DATE 6 BEFORE_DATE)
   (create-track "Gallows Pole"               "Led Zeppelin" "Led Zeppelin III" 1970  6 ADDED_DATE 4 BEFORE_DATE)
   (create-track "Tangerine"                  "Led Zeppelin" "Led Zeppelin III" 1970  7 ADDED_DATE 7 BEFORE_DATE)
   (create-track "That's the Way"             "Led Zeppelin" "Led Zeppelin III" 1970  8 ADDED_DATE 7 BEFORE_DATE)
   (create-track "Bron-Y-Aur Stomp"           "Led Zeppelin" "Led Zeppelin III" 1970  9 ADDED_DATE 5 BEFORE_DATE)
   (create-track "Hats Off to (Roy) Harper"   "Led Zeppelin" "Led Zeppelin III" 1970 10 ADDED_DATE 3 BEFORE_DATE)
   ))

(define LED-ZEPPELIN4 (list BLACK-DOG ROCK-AND-ROLL BATTLE-OF-EVERMORE STH MMH FS GTC WTLB))

(define LED-ZEPPELIN-1-4 (append LED-ZEPPELIN LED-ZEPPELIN2 LED-ZEPPELIN3 LED-ZEPPELIN4))

; String Date [List-of Tracks]
; Extract list of tracks (lot) from the album (album) that have been played after given date (date)
(define (select-album-date album date lot)
  (local [(define (played-after-date? track)
            (date-after? (track-played track) date))]
    (filter played-after-date? lot)))

(check-expect (select-album-date "Led Zeppelin IV" (create-date 2024 01 02 17 32 51) LED-ZEPPELIN-1-4)
              (list  BLACK-DOG
                     ROCK-AND-ROLL
                     BATTLE-OF-EVERMORE
                     MMH
                     FS
                     GTC
                     WTLB))

(define (date-after? date1 date2)
  (local [(define (normalize x)
            (if (< (string->number x) 10) (string-append "0" x) x))
          (define (date->list date)
            (list (date-year date) (date-month date) (date-day date) (date-hour date) (date-minute date) (date-second date)))
          (define (date->string date)
            (foldr string-append "" (map normalize (map number->string (date->list date)))))]
    (string>=? (date->string date1) (date->string date2))))
                           
(check-expect (date-after? BEFORE_DATE AFTER_DATE) #false)
(check-expect (date-after? AFTER_DATE BEFORE_DATE) #true)

;Design select-albums.
;The function consumes an LTracks.
;It produces a list of LTracks, one per album. Each album is uniquely identified by its title and shows up in the result only once.

;[List-of Tracks] -> [List-of Tracks]
;produce a list of tracks, one per album
(define (select-albums lot)
  (local [(define (get-all-albums lot) (map track-album lot))
          (define (get-tracks-for-albums a)
            (local [(define (get-track-for-album a lot)
              (if (string=? a (track-album (first lot)))
                  (first lot)
                  (get-track-for-album a (rest lot))))]
            (get-track-for-album a lot)))]
    (map get-tracks-for-albums (unique-items (get-all-albums lot)))))

(define (unique-items loi)
  (cond [(empty? loi) '()]
        [else
         (if (member? (first loi) (rest loi))
             (unique-items (rest loi))
             (cons (first loi) (unique-items (rest loi))))]))

(check-expect (select-albums LED-ZEPPELIN-1-4) (list GOODTIMESBADTIMES WLL IS BLACK-DOG))
