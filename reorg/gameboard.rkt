#lang racket
(require "../classes/sound.rkt")
(define gameboard%
  (class object%
    (super-new)
  ;;Members of class character
    (init-field
     _width
     _height
     [_num-of-power-ups 5]
     [_num-of-enemies 10]
     [_num-of-asteroids 10]; allowed num of power up at one instance
     [_score 0]
     [_list-of-player '()]
     [_list-of-enemies '()]
     [_list-of-power-ups '()]
     [_list-of-asteroids '()]
     [_list-of-projectiles '()]
     [_paused #f])

    ;; ---- getters -------
    (define/public (get-width)
      _width)

    (define/public (get-height)
      _height)

    (define/public (get-score)
      _score)

    (define/public (get-num-of-power-ups)
      _num-of-power-ups)
    
    (define/public (get-num-of-enemies)
      _num-of-power-ups)
    
    (define/public (get-num-of-asteroids)
      _num-of-power-ups)

    (define/public (get-list-of-player)
      _list-of-player)

    (define/public (get-list-of-enemies)
      _list-of-enemies)

    (define/public (get-list-of-power-ups)
      _list-of-power-ups)

    (define/public (get-list-of-projectiles)
      _list-of-projectiles)

    (define/public (get-list-of-asteroids)
      _list-of-asteroids)

    ;;---- setters, add and remove -----
    (define/public (increase-score _scorevalue)
      (set! _score _scorevalue))
    
    (define/public (add-player player)
      (set! _list-of-player (append (list player) _list-of-player)))
    
    (define/public (add-enemy enemy)
      (set! _list-of-enemies (append (list enemy) _list-of-enemies)))

    (define/public (add-power-up power-up)
      (set! _list-of-power-ups (append (list power-up) _list-of-power-ups)))

    (define/public (add-projectile projectile)
      (set! _list-of-projectiles
            (append (list projectile) _list-of-projectiles)))

    (define/public (add-asteroid asteroid)
      (set! _list-of-asteroids (append (list asteroid) _list-of-asteroids)))

    (define/public (delete-player player)
      (remove player _list-of-player))

    (define/public (delete-enemy enemy)
      (remove enemy _list-of-enemies ))

    (define/public (delete-power-up power-up)
      (remove power-up _list-of-power-ups))
    
    (define/public (delete-projectile projectile)
      (remove projectile _list-of-projectiles ))
    
    (define/public (delete-asteroid asteroid)
      (remove asteroid _list-of-asteroids ))

    (define/public (set-list-of-player lst)
      (set! _list-of-player lst))

    (define/public (set-list-of-enemies lst)
      (set! _list-of-enemies lst))

    (define/public (set-list-of-power-ups lst)
      (set! _list-of-power-ups lst))

    (define/public (set-list-of-projectiles lst)
      (set! _list-of-projectiles lst))
    
    (define/public (set-list-of-asteroids lst)
      (set! _list-of-asteroids lst))

    #|
    ;; ----------------
    (define pause-window (new dialog%
                              [parent game-window]
                              [label "Pause menu"]))
  
    (define play-button (new button%
                             [parent pause-window]
                             [callback (lambda (button event) (pause/play))]
                             [label "Play"]))
    (send play-button show #t)
    
    ;;Pause function
    (define/public (pause/play)
      (if _paused
          (begin
            (playing-sound background)
            (send update-timer start 16)
            (set! _paused (not _paused))
            (send pause-window show #f)
            (send player not-fireable)
            (send spawn-enemy-timer stop)
            (send spawn-power-up-timer stop)
            (send spawn-asteroid-timer stop))
          (begin
            (stopping-sound)
            (send update-timer stop)
            (set! _paused (not _paused))
            (send pause-window show #t) 
            (send player fireable)
            (send spawn-enemy-timer start 4000)
            (send spawn-power-up-timer start 10000)
            (send spawn-asteroid-timer start 2000))))

|#
))