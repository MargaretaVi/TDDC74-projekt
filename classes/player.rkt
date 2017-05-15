#lang racket/gui
(provide player% player)
(require "characters.rkt")
(require "../functions.rkt")

(define player%
  (class character%
    (inherit-field
     _x-pos
     _y-pos
     _DMG
     _DMG-roof
     _speed
     _health
     _can-fire)
    (inherit move-x
             move-y
             fire)
    (init-field
     _name
     [_list-of-power-ups '()])
    
      (define/public (get-name)
      _name)
    
     ;; Returns a list of power ups that the character currently holds
     (define/public (get-list-of-power-ups)
       _list-of-power-ups)

    ;; Removes power-up  from list with power-ups
     (define/public (delete-power-up power-up)
       (delete-from-list _list-of-power-ups power-up))

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
 
    ;; Actions depending on pressed key
    (define/public (keyboard-input input-list)
      (cond
        ((send input-list pressed? #\d)
         (move-x _speed))
        ((send input-list pressed? #\a)
         (move-x (- 0 _speed)))
        ((send input-list pressed? #\w)
         (move-y (- 0 _speed)))
        ((send input-list pressed? #\s)
         (move-y _speed))
        ((send input-list pressed? #\space)
         (unless (not _can-fire)   
           (fire)))))
    
     ;; player bitmap
    (define player-bitmap
      (make-object bitmap% "../images/player-bit.png"))
  
    (super-new)))
     
(define player
  (new character%
       [_width 11]
       [_height 11]))
