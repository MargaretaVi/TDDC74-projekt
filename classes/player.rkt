#lang racket/gui
(provide player% player)
(require "characters.rkt")

(define player%
  (class character%
    (super-new)
    (inherit-field
     _DMG _DMG-roof _health-roof _speed _health _facing-direction)
    
    (inherit set-height set-width set-speed set-health
             set-cool-down set-facing-direction)

    ; --- starting values
    (set-facing-direction -1)
    (set-speed 20)
    (set-health _health-roof)
    (set-cool-down 500)

    ;; player bitmap
    (define player-bitmap
      (read-bitmap "../images/player.png"))

    (define/override (get-bitmap)
      player-bitmap)

    (set-height (send player-bitmap get-height))
    (set-width (send player-bitmap get-width))))


;; player
(define player
  (new player%))
