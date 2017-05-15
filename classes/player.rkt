#lang racket/gui
(provide player% player)
(require "characters.rkt")

(define player%
  (class character%
    (super-new)
    (inherit-field
     _x-pos
     _y-pos
     _DMG
     _DMG-roof
     _speed
     _health
     _can-fire
     _facing-direction)
    (inherit move-x
             move-y)
    (init-field
     [_list-of-power-ups '()])
   
    (set! _facing-direction -1)
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

    ;; Function that decides what happens when a power up is picked up
    (define/public (power-up power-up)
      (cond
        ((eq? (send power-up get-type) 1)
         ;; There is a DMG roof
         (if (> _DMG _DMG-roof)
          (set! _DMG _DMG-roof)
          (set! _DMG (+ _DMG (send power-up get-value )))))
        ((eq? (send power-up get-type) 2)
         (set! _speed (+ _speed (send power-up get-value )))) 
        ((eq? (send power-up get-type) 3)
         (set! _health (+ _health (send power-up get-value ))))))
 
     ;; player bitmap
    (define player-bitmap
      (make-object bitmap% "../images/player.png"))

    (define/override (get-bitmap)
      player-bitmap)
  
  ))
     
(define player
  (new player%
       [_width 11]
       [_height 11]))
