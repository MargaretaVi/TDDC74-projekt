#lang racket
(require rsound)
(provide (all-defined-out))
;; ----sound----
(define shoot (rs-read "../music/bullet.wav"))
(define background (rs-read "../music/Defense_Line.wav"))

(define (playing-sound sound-path)
  (play sound-path))

(define (stopping-sound)
  (stop))                   
;;---