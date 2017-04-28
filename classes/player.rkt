#lang racket
(provide player%)
(require "characters.rkt")

(define player%
  (class character%
    [inherit-field
     _can-fire
     _cool-down]
    [inherit reset-can-fire]
    (init-field
     [*list-of-power-ups* (make-hash)])

     ;; Returns a list of power ups that the character currently holds
     (define/public (get-list-of-power-ups)
       (hash-keys *list-of-power-ups*))

    ;; Removes power-up 
     (define/public (delete-power-up power-up)
       (if (hash-has-key? *list-of-power-ups*  (string power-up))
           (hash-remove! *list-of-power-ups* (string power-up))
           #f))


    (super-new)))
     
      
    
    
