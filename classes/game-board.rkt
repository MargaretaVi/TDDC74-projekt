#lang racket/gui
(provide game-board%)
(require "../functions.rkt")
(require "../graphics.rkt")

(define game-board%
  (class object%
    ;;Members of class character
    (init-field
     _name
     _width
     _height
     _num-of-power-ups
     [_score 0]
     [_list-of-characters '()]
     [_list-of-power-ups '()]
     [_list-of-asteroids '()]
     [_list-of-projectiles '()]
     [_paused #f])

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

    ;; Adds character to the list with characters.
    (define/public (add-character character)
      (add-to-list _list-of-characters character))
    
    ;; Removes the character from the list with characters.
    (define/public (delete-character character)
      (delete-from-list _list-of-characters character))

    ;; Returns a list of existing items on the map
    (define/public (get-list-of-power-ups)
      _list-of-power-ups)
    
    ;; Adds item to the list with power-ups
    (define/public (add-power-up power-up)
      (add-to-list _list-of-power-ups power-up))

    ;; Removes the item from the list with items.
    (define/public (delete-power-up power-up)
      (delete-from-list _list-of-power-ups power-up))

    ;; Returns a list of existing projectiles on the map
    (define/public (get-list-of-projectiles)
      _list-of-projectiles)
    
    ;; Adds item to the list with power-ups
    (define/public (add-projectile projectile)
      (add-to-list _list-of-projectiles projectile))

    ;; Removes the item from the list with items.
    (define/public (delete-projectile projectile)
      (delete-from-list _list-of-projectiles projectile))

    ;; ----------------
    (define *pause-window* (new dialog%
                                [parent *game-window*]
                                [label "Pause menu"]))
  
    (define *play-button* (new button%
                               [parent *pause-window*]
                               [callback (lambda (button event) (pause/play))]
                               [label "Play"]))
    (send *play-button* show #t)
    ;;Pause function
    (define/public (pause/play)
      (if _paused
          (begin
            (send *update-timer* start 16)
            (set! _paused (not _paused))
            (send *pause-window* show #f))
          (begin
            (send *update-timer* stop)
            (set! _paused (not _paused))
            (send *pause-window* show #t))))

    (super-new)))
