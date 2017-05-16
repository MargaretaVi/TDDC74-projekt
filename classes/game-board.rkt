#lang racket/gui
(provide game-board%)
(require "../functions.rkt")
(require "../graphics.rkt")
(require "player.rkt")
(require "enemie.rkt")
(require "Items.rkt")
(require "key-handler.rkt")

(define game-board%
  (class object%
    
    ;;Members of class character
    (init-field
     _width
     _height
     _num-of-power-ups ; allowed num of power up at one instance
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

    (define/public (get-num-of-power-ups)
      _num-of-power-ups)
    ;; ------------------------------------

    ;; Increases scorevalue
    (define/public (increase-score _scorevalue)
      (set! _score (+ _score _scorevalue)))
    
    ;; Returns a list of which player that exists in the game. 
    (define/public (get-list-of-player)
      _list-of-player)

    ;; Returns a list of which enemies that exists in the game.
    (define/public (get-list-of-enemies)
      _list-of-enemies)

    ;; Returns a list of existing items on the map
    (define/public (get-list-of-power-ups)
      _list-of-power-ups)

    ;; Returns a list of existing projectiles on the map
    (define/public (get-list-of-projectiles)
      _list-of-projectiles)

    ;; Returns a list of existing asteroids on the map
    (define/public (get-list-of-asteroids)
      _list-of-asteroids)
    
    ;; Adds player to the list with player.
    (define/public (add-player player)
      (set! _list-of-player
            (append (list player) _list-of-player)))
    
    ;; Adds character to the list with enemies.
    (define/public (add-enemy enemy)
      (set! _list-of-enemies
            (append (list enemy) _list-of-enemies)))

    ;; Adds item to the list with power-ups
    (define/public (add-power-up power-up)
      (set! _list-of-power-ups
            (append (list power-up) _list-of-power-ups)))

    ;; Adds item to the list with projectiles
    (define/public (add-projectile projectile)
      (set! _list-of-projectiles
            (append (list projectile) _list-of-projectiles)))

    ;; Adds item to the list with projectiles
    (define/public (add-asteroid asteroid)
      (set! _list-of-asteroids
            (append (list asteroid) _list-of-asteroids)))

    ;; Removes player from the list with player.
    (define/public (delete-player player)
      (remove player _list-of-player))

    ;; Removes the enemies from the list with enemies.
    (define/public (delete-enemy enemy)
      (remove enemy _list-of-enemies ))

    ;; Removes the item from the list with items.
    (define/public (delete-power-up power-up)
      (remove power-up _list-of-power-ups))
    
    ;; Removes the projectile from the list with projectiles.
    (define/public (delete-projectile projectile)
      (remove projectile _list-of-projectiles ))
    
    ;; Removes the asteroid from the list with asteroids.
    (define/public (delete-asteroid asteroid)
      (remove asteroid _list-of-asteroids ))

    ;; set the list to a new kind of list
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
                         [width 900]
                         [height 700]
                         [label "Space invader"]))
                             
(send game-window show #t)
    
    
(define game-board (new game-board%
                        [_width 900]
                        [_height 700]
                        [_num-of-power-ups 5]))

;; canvas-class for the game
(define game-canvas%
  (class canvas%
    (init-field
     keyboard-handler)
    (inherit get-dc)

    (define/override (on-char key-event)
      (keyboard-handler key-event))
    
    ;; draw object function
    (define/public (draw-object object dc)
      (send dc draw-bitmap (send object get-bitmap)
            (send object get-x-pos) (send object get-y-pos)))
    
    (define/override (on-paint)
      (let ([background-dc (get-dc)])
        (send background-dc set-background "black")
        (send background-dc clear)
        (render-function this background-dc)))
    (super-new)))

;; Render function
(define (render-function canvas dc)
  ;;Draw player
  (for-each (lambda (player)
              (send canvas draw-object player dc))
            (send game-board get-list-of-player))
  
  ;;Draw projectiles
  (for-each (lambda (object)
              (send object update)
              (send canvas draw-object object dc))
            (send game-board get-list-of-projectiles))

  ;;Draw enemies
  (for-each (lambda (enemy)
              (send enemy update)
              (send canvas draw-object enemy dc))
            (send game-board get-list-of-enemies))

  ;;Draw power-ups
  (for-each (lambda (object)
              (send object update)
              (send canvas draw-object object dc))
            (send  game-board  get-list-of-power-ups))

  ;;draw asteroids
  (for-each (lambda (asteroid)
              (send asteroid update)
              (send canvas draw-object asteroid dc))
            (send game-board get-list-of-asteroids)))


;; Keyboard actions, depends on input
(define (keyboard-input key-event)
  (let
      ((key-tag (send key-event get-key-code)))
    (cond
      ((equal? key-tag #\d)
       (send player move-x (send player get-speed)))
      ((equal? key-tag  #\a)
       (send player move-x (- 0 (send player get-speed)))) 
      ((equal? key-tag #\w)
       (send player move-y (- 0 (send player get-speed)))) 
      ((equal? key-tag  #\s)
       (send player move-y (send player get-speed))) 
      ((equal? key-tag  #\space)
       (unless (not (send player can-fire?)) (fire)))
      ((equal? key-tag 'escape)
       (send game-board pause/play)))))

;; Fire-function when space is pressed
(define (fire)
  (let ((type_tmp 0))
    (if (> (send player get-DMG) 5)
        (set! type_tmp 5)
        (set! type_tmp 4))
    ;; creates a projectile each and adds to list of projectiles
    (send game-board add-projectile
          (new projectile%
               [_height 11]
               [_width 11]
               [_x-pos (+ (send player get-x-pos) (exact-round (/ (send player get-width) 2)))]
               [_y-pos (- (send player get-y-pos) (send player get-height) 2)]
               [_type type_tmp]
               [_facing-direction (send player get-facing-direction)]
               [_DMG (send player get-DMG)]))))

;; Create enemy object and adds it to game board
(define (spawn-enemy)
  (let ((tmp (create-enemy)))
    (send tmp random-spawn-pos game-board)
    (send tmp set-width (send (send tmp get-bitmap) get-width))
    (send tmp set-height (send (send tmp get-bitmap) get-height))
    (send game-board add-enemy tmp)))

;; Create power-up object and adds it to game board
(define (spawn-power-up)
  (unless (>= (length (send game-board get-list-of-power-ups)) 
              (send game-board get-num-of-power-ups))
    (let ((tmp (create-power-up)))
      (send tmp random-spawn-pos game-board)
      (send game-board add-power-up tmp))))

;; Create power-up object and adds it to game board
(define (spawn-asteroid)
  (let ((tmp (create-asteroid)))
    (send tmp random-spawn-pos game-board)
    (send tmp set-width (send (send tmp get-bitmap) get-width))
    (send tmp set-height (send (send tmp get-bitmap) get-height))
    (send game-board add-asteroid tmp)))

;;check interactions of object 
(define (check-objects)
  
  (for-each (lambda (power-up)
              (unless (not (out-of-bounce? power-up game-board))
                (send game-board set-list-of-power-ups
                      (send game-board delete-power-up power-up)))
              (unless (not (collision? player power-up))
                (send player collision-action power-up)
                (send game-board set-list-of-power-ups
                      (send game-board delete-power-up power-up))))
            (send game-board get-list-of-power-ups))

  (for-each (lambda (asteroid)
              (unless (not (out-of-bounce? asteroid game-board))
                (send game-board set-list-of-asteroids
                      (send game-board delete-asteroid asteroid)))
              (unless (not (collision? player asteroid))
                (send player collision-action asteroid)
                (send game-board set-list-of-asteroids
                      (send game-board delete-asteroid asteroid))))
            (send game-board get-list-of-asteroids))

  (for-each (lambda (enemy)
              (unless (not (out-of-bounce? enemy game-board))
                (send game-board set-list-of-enemies
                      (send game-board delete-enemy enemy)))
              (unless (not (collision? player enemy))
                (send game-board set-list-of-enemies
                      (send game-board delete-enemy enemy))))
            (send game-board get-list-of-enemies))

  (for-each (lambda (projectile)
              (for-each (lambda (enemy)
                          (unless (not (collision? projectile enemy))
                            (send game-board set-list-of-enemies
                                  (send game-board delete-enemy enemy))
                            (send game-board set-list-of-projectiles
                                  (send game-board delete-projectile projectile))))
                        (send game-board get-list-of-enemies))
              (for-each (lambda (asteroid) 
                          (unless (not (collision? projectile asteroid))
                            (send game-board set-list-of-asteroids
                                  (send game-board delete-asteroid asteroid))
                            (send game-board set-list-of-projectiles
                                  (send game-board delete-projectile projectile))))
                          (send game-board get-list-of-asteroids)))
            (send game-board get-list-of-projectiles)))
                          
                                  
;; Instantiation of objects
;; ---------------------
(send player set-x-pos (- (exact-round (/ (send game-board get-width) 2))30))
(send player set-y-pos (- (send game-board get-height) 80))
(send game-board add-player player)

;;canvas
(define canvas (new game-canvas%
                    [parent game-window]
                    [keyboard-handler keyboard-input]
                    [paint-callback render-function]))

(send canvas show #t)

;;Uppdate canvas
(define (refresh-canvas)
  (send canvas refresh))

;;Update canvas timer
(define update-timer (new timer% [notify-callback refresh-canvas]))                         
(send update-timer start 16 #f)

;;Enemy spawn timer
(define spawn-enemy-timer (new timer% [notify-callback spawn-enemy]))
(send spawn-enemy-timer start 1000 #f)

;;power-up spawn timer
(define spawn-power-up-timer (new timer% [notify-callback spawn-power-up]))
(send spawn-power-up-timer start 10000 #f)

;;asteroid spawn timer
(define spawn-asteroid-timer (new timer% [notify-callback spawn-asteroid]))
(send spawn-asteroid-timer start 1000 #f)

;;collision timer
(define check-object-timer (new timer% [notify-callback check-objects]))
(send check-object-timer start 16 #f)
;; ------------------
