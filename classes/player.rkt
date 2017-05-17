#lang racket/gui
(provide player% player)
(require "characters.rkt")

(define player%
  (class character%
    (super-new)
    (inherit-field
     _height
     _width
     _x-pos
     _y-pos
     _DMG
     _DMG-roof
     _speed-roof
     _health-roof
     _speed
     _health
     _can-fire
     _alive
     _facing-direction)
    (inherit move-x
             move-y
             set-height
             set-width
             set-x-pos
             set-y-pos
             get-width
             get-height
             set-speed
             set-health
             set-DMG)
   
    (set! _facing-direction -1)
    (set-speed _speed-roof)
    (set-health _health-roof)

    ;; Type == 3 , DMG
    ;; Type == 4 , SPEED
    ;; Type == 5 ; HEALTH

    ;; player bitmap
    (define player-bitmap
      (read-bitmap "../images/player.png"))

    (define/override (get-bitmap)
      player-bitmap)

    (set-height (send player-bitmap get-height))
    (set-width (send player-bitmap get-width))

    ))


;; player
(define player
  (new player%))
