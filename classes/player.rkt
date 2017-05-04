#lang racket
(provide player%)
(require "characters.rkt")

(define player%
  (class character%
    (init-field
     _name
     [_list-of-power-ups (make-hash)])
    
      (define/public (get-name)
      _name)
    
     ;; Returns a list of power ups that the character currently holds
     (define/public (get-list-of-power-ups)
       (hash-keys _list-of-power-ups))

    ;; Removes power-up 
     (define/public (delete-power-up power-up)
       (hash-remove! _list-of-power-ups (send power-up get-name)))

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
     
      
    
    
