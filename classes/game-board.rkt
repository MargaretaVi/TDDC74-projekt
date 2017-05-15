#lang racket/gui
(provide game-board% game-board)
(require "../functions.rkt")
(require "../graphics.rkt")
(require "player.rkt")
(require "key-handler.rkt")
(define game-board%
  (class object%
    ;;Members of class character
    (init-field
     _width
     _height
     _num-of-power-ups
     [_score 0]
     [_list-of-player '()]
     [_list-of-enemies '()]
     [_list-of-power-ups '()]
     [_list-of-asteroids '()]
     [_list-of-projectiles '()]
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
    
    ;; Returns a list of which player that exists in the game. (should only be 1 member of list)
    (define/public (get-list-of-player)
      _list-of-player)

    ;; Adds player to the list with player.
    (define/public (add-player player)
      (set! _list-of-player (append (list player) _list-of-player)))
    
    ;; Removes player from the list with player.
    (define/public (delete-player player)
      (delete-from-list _list-of-player player))

    ;; Returns a list of which enemies that exists in the game.
    (define/public (get-list-of-enemies)
      _list-of-enemies)

    ;; Adds character to the list with enemies.
    (define/public (add-enemie enemie)
       (set! _list-of-enemies (append (list enemie) _list-of-enemies)))
    
    ;; Removes the enemies from the list with enemies.
    (define/public (delete-enemie enemie)
      (delete-from-list _list-of-enemies enemie))

    ;; Returns a list of existing items on the map
    (define/public (get-list-of-power-ups)
      _list-of-power-ups)
    
    ;; Adds item to the list with power-ups
    (define/public (add-power-up power-up)
      (set! _list-of-power-ups (append (list power-up) _list-of-power-ups)))

    ;; Removes the item from the list with items.
    (define/public (delete-power-up power-up)
      (delete-from-list _list-of-power-ups power-up))

    ;; Returns a list of existing projectiles on the map
    (define/public (get-list-of-projectiles)
      _list-of-projectiles)
    
    ;; Adds item to the list with projectiles
    (define/public (add-projectile projectile)
      (add-to-list _list-of-projectiles projectile))

    ;; Removes the projectile from the list with projectiles.
    (define/public (delete-projectile projectile)
      (delete-from-list _list-of-projectiles projectile))

    ;; Returns a list of existing asteroids on the map
    (define/public (get-list-of-asteroids)
      _list-of-asteroids)
    
    ;; Adds item to the list with projectiles
    (define/public (add-asteroid asteroid)
      (add-to-list _list-of-asteroids asteroid))

    ;; Removes the projectile from the list with projectiles.
    (define/public (delete-asteroid asteroid)
      (delete-from-list _list-of-asteroids asteroid))
    
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
            (send update-timer start 16)
            (set! _paused (not _paused))
            (send pause-window show #f))
          (begin
            (send update-timer stop)
            (set! _paused (not _paused))
            (send pause-window show #t))))
    
    (super-new)))

(define game-window (new frame%
                         [width 1300]
                         [height 1300]
                         [label "Space invader"]))
                             
(send game-window show #t)
    
    
(define game-board (new game-board%
                        [_width 1300]
                        [_height 1300]
                        [_num-of-power-ups 5]))

#|(define (drawing-proc canvas  character  dc)
  (let ((our-picture (make-object bitmap% "AA.png")))
    (send dc draw-bitmap our-picture (send  character  get-x-pos) (send  character get-y-pos))))
|#

;; draw object function
(define (draw-object object dc)
  (send dc draw-bitmap (send object get-bitmap) (send object get-x-pos) (send object get-y-pos)))

;; Render function
(define (render-function canvas dc)

  ;;Draw player  
  (for-each (lambda (player)
              (draw-object player dc))
            (send game-board get-list-of-player))

  ;;Draw enemies
  (for-each (lambda (enemie)
              (draw-object enemie dc))
            (send game-board get-list-of-enemies))

  ;;Draw projectiles
  (for-each (lambda (object)
              (draw-object object dc))
            (send game-board get-list-of-projectiles))

  ;;Draw power-ups
  (for-each (lambda (object)
              (draw-object object dc))
            (send  game-board  get-list-of-power-ups))
  ;;draw asteroids
  (for-each (lambda (asteroid)
              (draw-object asteroid dc))
            (send game-board get-list-of-asteroids)))


;; canvas-class for the game
(define game-canvas%
  (class canvas%
    (init-field
     keyboard-input)
    (inherit get-dc)
    
    (define/override (on-char key-event)
      (keyboard-input key-event))
    
    (define/override (on-paint)
      (let ([my-dc (get-dc)])
        (send my-dc clear)
        (send my-dc set-background "black")))
    (super-new)))

;; Actions depending on pressed key
(define (keyboard-input keyboard-list)
  (cond
    ((send keyboard-list pressed? #\d)
     (send player move-x (send player get-speed))))
  (cond
    ((send keyboard-list pressed? #\a)
     (send player move-x (- 0 (send player get-speed)))))
  (cond
    ((send keyboard-list pressed? #\w)
     (send player move-y (- 0 (send player get-_speed)))))
  (cond
    ((send keyboard-list pressed? #\s)
     (send player move-y (send player get-speed))))
  (cond
    ((send keyboard-list pressed? #\space)
     (unless (not (send player can-fire?))   
       (send player fire)))))

(define (key-fnc key-event)
  (let
      ((key-tag (send key-event get-key-code)))
  (cond
    ((eq? key-tag #\space)
     (send player fire))
    ((eq? key-tag #\a)
     (send player move-x (- 0 (send player get-speed))))
    ((eq? key-tag #\d)
     (send player move-x (send player get-speed)))
    ((eq? key-tag #\w)
     (send player move-y (- 0 (send player get-speed))))
    ((eq? key-tag #\s)
     (send player move-y (send player get-speed)))))
  (send game-window refresh))

;;init game canvas
(define canvas (new game-canvas%
                    [parent game-window]
                    [keyboard-input key-fnc]
                    [paint-callback render-function]))

(send canvas show #t)

;;Return the canvas
(define (get-game-canvas)
  canvas) 

;;Uppdate canvas
(define (refresh-canvas)
  (send canvas refresh))

;;Timer which says when the canvas should update
(define update-timer (new timer%
                          [notify-callback refresh-canvas]))
                           
(send update-timer start 16 #f)