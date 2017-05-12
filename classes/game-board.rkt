#lang racket/gui
(provide game-board%)
(require "../functions.rkt")
(require "../graphics.rkt")

(define game-board%
  (class object%
    ;;Members of class character
    (init-field
     _width
     _height
     _num-of-power-ups
     [_score 0]
     [*list-of-player* '()]
     [*list-of-enemies* '()]
     [*list-of-power-ups* '()]
     [*list-of-asteroids* '()]
     [*list-of-projectiles* '()]
     [_paused #f])

    ;; Functions that returns the class members
    
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
    
    ;; Returns a list of which player that exists in the game. (should only be 1)
    (define/public (get-list-of-player)
      *list-of-player*)

    ;; Adds player to the list with player.
    (define/public (add-player player)
      (add-to-list *list-of-player* player))
    
    ;; Removes player from the list with player.
    (define/public (delete-player player)
      (delete-from-list *list-of-player* player))

    ;; Returns a list of which enemies that exists in the game.
    (define/public (get-list-of-enemies)
      *list-of-enemies*)

    ;; Adds character to the list with enemies.
    (define/public (add-enemie enemie)
      (add-to-list *list-of-enemies* enemie))
    
    ;; Removes the enemies from the list with enemies.
    (define/public (delete-enemie enemie)
      (delete-from-list *list-of-enemies* enemie))

    ;; Returns a list of existing items on the map
    (define/public (get-list-of-power-ups)
      *list-of-power-ups*)
    
    ;; Adds item to the list with power-ups
    (define/public (add-power-up power-up)
      (add-to-list *list-of-power-ups* power-up))

    ;; Removes the item from the list with items.
    (define/public (delete-power-up power-up)
      (delete-from-list *list-of-power-ups* power-up))

    ;; Returns a list of existing projectiles on the map
    (define/public (get-list-of-projectiles)
      *list-of-projectiles*)
    
    ;; Adds item to the list with projectiles
    (define/public (add-projectile projectile)
      (add-to-list *list-of-projectiles* projectile))

    ;; Removes the projectile from the list with projectiles.
    (define/public (delete-projectile projectile)
      (delete-from-list *list-of-projectiles* projectile))

    ;; Returns a list of existing asteroids on the map
    (define/public (get-list-of-asteroids)
      *list-of-asteroids*)
    
    ;; Adds item to the list with projectiles
    (define/public (add-asteroid asteroid)
      (add-to-list *list-of-asteroids* asteroid))

    ;; Removes the projectile from the list with projectiles.
    (define/public (delete-asteroid asteroid)
      (delete-from-list *list-of-asteroids* asteroid))
    
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
