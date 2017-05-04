#lang racket
(provide game-board%)
(require "../functions.rkt")

(define game-board%
  (class object%
    ;;Members of class character
    (init-field
     _name
     [_score 0]
     [_width 1000]
     [_height 1000]
     [_list-of-characters '()]
     [_list-of-items '()])

    ;; Functions that returns the class members
    (define/public (get-name)
      _name)
    
    (define/public (get-width)
      _width)

    (define/public (get-height)
      _height)

    (define/public (get-score)
      _score)
    ;; ------------------------------------

    ;; Increases scorevalue
    (define/public (increase-score _scorevalue)
      (set! _score (+ _score _scorevalue)))
    
    ;; Returns a list of which characters that exists in the game.
    (define/public (get-list-of-charcters)
      _list-of-characters)

    ;; Adds character to the hash-table with characters.
    (define/public (add-character character)
      (add-to-list _list-of-characters character))
    
    ;; Removes the character from the hash-table with characters.
    (define/public (delete-character character)
      (delete-from-list _list-of-characters character))

    ;; Returns a list of existing items on the map
    (define/public (get-list-of-items)
      _list-of-items)
    
    ;; Adds item to the hash-table with items
    (define/public (add-item item)
      (add-to-list _list-of-items item))

    ;; Removes the item from the hash-table with items.
    (define/public (delete-item item)
      (delete-from-list _list-of-items item))
    
    (super-new)))
