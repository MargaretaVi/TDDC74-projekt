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

    ;; Decides what happens when collided with an object
    (define/public (collision-action object)
      (cond
        ((or (equal? (send object get-type) 1)
             (equal? (send object get-type) 2)
             (equal? (send object get-type) 6))
         (begin
           (set! _health (- _health 1))
           (unless (not (< _health 0))
             (set! _alive #f))))       
        ((equal? (send object get-type) 3)
         (if (> (send this get-DMG) _DMG-roof)
             (set-DMG _DMG-roof)
             (set-DMG (+ (send this get-DMG)
                         (send object get-value)))))
        ((equal? (send object get-type) 4)
         (set-speed (+ _speed (send object get-value)))) 
        ((equal? (send object get-type) 5)
         (set-health (+ _health (send object get-value))))))
 
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
