#lang racket
(provide player%)
(require "characters.rkt")

(define player%
  (class character%
    (init-field
     _name
     [*list-of-power-ups* (make-hash)])
    
      (define/public (get-name)
      _name)
    
     ;; Returns a list of power ups that the character currently holds
     (define/public (get-list-of-power-ups)
       (hash-keys *list-of-power-ups*))

    ;; Removes power-up 
     (define/public (delete-power-up power-up)
       (if (hash-has-key? *list-of-power-ups*  (string power-up))
           (hash-remove! *list-of-power-ups* (string power-up))
           #f))


    (super-new)))
     
      
    
    
