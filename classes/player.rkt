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
    (init-field
     [_list-of-power-ups '()])
   
    (set! _facing-direction -1)
    (set-speed 20)
     ;; Returns a list of power ups that the character currently holds
     (define/public (get-list-of-power-ups)
       _list-of-power-ups)

    ;; Removes power-up  from list with power-ups
     (define/public (delete-power-up power-up)
       (remove power-up _list-of-power-ups ))

    ;; Type == 1 , DMG
    ;; Type == 2 , SPEED
    ;; Type == 3 ; HEALTH
    ;; *power-up* is a object from class *power-up*

    ;; Decides what happens when collided with an object
    (define/public (collision-action object)
      (cond
        ((eq? (send object get-type) 3)
         ;; There is a DMG roof
         (if (> _DMG _DMG-roof)
          (set! _DMG _DMG-roof)
          (set! _DMG (+ _DMG (send object get-value )))))
        ((eq? (send object get-type) 4)
         (set! _speed (+ _speed (send object get-value )))) 
        ((eq? (send object get-type) 5)
         (set! _health (+ _health (send object get-value ))))))
 
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
