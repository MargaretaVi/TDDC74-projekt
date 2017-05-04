#lang racket
(provide player%)
(require "characters.rkt")
(require "../functions.rkt")

(define player%
  (class character%
    (inherit-field
     _DMG
     _DMG-roof
     _speed
     _health)
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
    
    (define/public (power-up power-up)
      (cond
        ((eq? (send power-up get-type) 1)
         ;; There is a DMG roof
         (if (> _DMG _DMG-roof)
          (set! _DMG _DMG-roof)
          (set! _DMG (+ _DMG (send power-up get-value )))))
        ((eq? (send power-up get-type) 2)
         (set! _speed (+ _speed (send power-up get-value )))) 
        ((eq? (send power-up get-type) 3 )
          (set! _health (+ _health (send power-up get-value ))))))

    (super-new)))
     
      
    
    
