#lang racket
(provide game-board%)

(define game-board%
  (class object%
    ;;Members of class character
    (init-field
     _name
     [_width 1000]
     [_height 1000]
     [*list-of-characters* (make-hash)])

    ;; Functions that returns the class members
    (define/public (get-name)
      _name)
    
    (define/public (get-width)
      _width)

    (define/public (get-height)
      _height)
    
    ;; ------------------------------------

    ;; Fucntion returns a list of which characters that exists in the game.
    (define/public (get-list-of-charcters)
      (hash-keys *list-of-characters*))

    ;; Functions adds character to the hash-table which characters.
    (define/public (add-character character)
      (if (hash-has-key? *list-of-characters* (send character get-name))
          #f
          (begin
            (hash-set! *list-of-characters* (send character get-name) character)
            #t)))
    
    ;; Fucntion removes the character from the hash-table with characters.
    (define/public (delete-character character)
      (if (hash-has-key? *list-of-characters*  (send character get-name))
          (hash-remove! *list-of-characters* (send character get-name))
          #f))


    (super-new)))