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


    (super-new)))
     
      
    
    
