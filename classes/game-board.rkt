#lang racket
(provide game-board%)

(define game-board%
  (class object%
    ;;Members of class character
    (init-field
     _name
     [_width 1000]
     [_height 1000]
     [_list-of-characters (make-hash)]
     [_list-of-items (make-hash)])

    ;; Functions that returns the class members
    (define/public (get-name)
      _name)
    
    (define/public (get-width)
      _width)

    (define/public (get-height)
      _height)
    
    ;; ------------------------------------

    ;; Returns a list of which characters that exists in the game.
    (define/public (get-list-of-charcters)
      (hash-keys _list-of-characters))

    ;; Adds character to the hash-table with characters.
    (define/public (add-character character)
      (hash-set! _list-of-characters (send character get-name) character))
    
    ;; Removes the character from the hash-table with characters.
    (define/public (delete-character character)
      (hash-remove! _list-of-characters (send character get-name)))

    ;; Returns a list of existing items on the map
    (define/public (get-list-of-items)
      (hash-keys _list-of-items))
    
    ;; Adds item to the hash-table with items
    (define/public (add-item item)
      (hash-set! _list-of-items (send item get-name) item))

    ;; Removes the item from the hash-table with items.
    (define/public (delete-item item)
      (hash-remove! _list-of-items (send item get-name)))
    
    (super-new)))
