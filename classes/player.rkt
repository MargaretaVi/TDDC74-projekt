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
             set-speed)
   
    (set! _facing-direction -1)
    (set-speed 20)

    ;; Type == 3 , DMG
    ;; Type == 4 , SPEED
    ;; Type == 5 ; HEALTH

    ;; Decides what happens when collided with an object
    (define/public (collision-action object)
      (cond
        ((or (equal? (send object get-type) 1) (equal? (send object get-type) 2)
         (set! _health (- _health (send object get-DMG)))
         (unless (not (< _health 0))
           (set! _alive #f))))       
        ((equal? (send object get-type) 3)
         ;; There is a DMG roof
         (if (> _DMG _DMG-roof)
          (set! _DMG _DMG-roof)
          (set! _DMG (+ _DMG (send object get-value )))))
        ((equal? (send object get-type) 4)
         (set! _speed (+ _speed (send object get-value )))) 
        ((equal? (send object get-type) 5)
         (set! _health (+ _health (send object get-value ))))
        ((equal? (send object get-type) 6))))
 
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
