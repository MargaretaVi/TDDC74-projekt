#lang racket/gui
(provide gameboard%)
(require "sound.rkt")
(require "miscellaneous.rkt")
(require "item.rkt")
(require "character.rkt")

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
     [_list-of-player '()]
     [_list-of-enemies '()]
     [_list-of-bosses '()]
     [_list-of-power-ups '()]
     [_list-of-asteroids '()]
     [_list-of-projectiles '()]
     [_paused #f]
     [_sound #f]
     [_boss-alive #t])

    ;; ---- getters -------
    (define/public (get-width)
      _width)

    (define/public (get-height)
      _height)
    
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
    
    (define/public (get-list-of-bosses)
      _list-of-bosses)

    (define/public (get-list-of-power-ups)
      _list-of-power-ups)

    (define/public (get-list-of-projectiles)
      _list-of-projectiles)

    (define/public (get-list-of-asteroids)
      _list-of-asteroids)

    (define/public (boss-alive?)
      _boss-alive)

    (define/public (get-sound)
      _sound)
    ;;---- setters, add and remove -----
   
    (define/public (add-player player)
      (set! _list-of-player (append (list player) _list-of-player)))
    
    (define/public (add-enemy enemy)
      (set! _list-of-enemies (append (list enemy) _list-of-enemies)))

    (define/public (add-boss boss)
      (set! _list-of-bosses (append (list boss) _list-of-bosses)))
    
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
      (remove enemy _list-of-enemies))

    (define/public (delete-boss boss)
      (remove boss _list-of-bosses))

    (define/public (delete-power-up power-up)
      (remove power-up _list-of-power-ups))
    
    (define/public (delete-projectile projectile)
      (remove projectile _list-of-projectiles))
    
    (define/public (delete-asteroid asteroid)
      (remove asteroid _list-of-asteroids))

    (define/public (set-list-of-player lst)
      (set! _list-of-player lst))

    (define/public (set-list-of-enemies lst)
      (set! _list-of-enemies lst))

    (define/public (set-list-of-bosses lst)
      (set! _list-of-bosses lst))

    (define/public (set-list-of-power-ups lst)
      (set! _list-of-power-ups lst))

    (define/public (set-list-of-projectiles lst)
      (set! _list-of-projectiles lst))
    
    (define/public (set-list-of-asteroids lst)
      (set! _list-of-asteroids lst))

    (define/public (boss-killed)
      (set! _boss-alive #f))

    (define/public (set-sound _val)
      (set! _sound _val))

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

    ;Gameover function
    (define/public (game-over)
      (stopping-sound)
      (send dead-window show #t))

    ;Gameover function
    (define/public (winning)
      (stopping-sound)
      (send win-window show #t))))

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

;;---------FUNCTIONS-------------
;; Render function
(define (render-function canvas dc)
  
  ;Display health
  (send dc draw-text "Health" 30 15)
  (send dc draw-text (number->string (send player get-health)) 30 30)
  (send dc set-text-foreground "white")

  ;display score
  (send dc draw-text "Score" (- (send game-board get-width) 70) 15)
  (send dc draw-text (number->string (send player get-value))
        (- (send game-board get-width) 70) 30)
  
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
            (send game-board get-list-of-asteroids))

  ;;draw bosses
  (for-each (lambda (boss)
              (send boss update)
              (send canvas draw-object boss dc))
            (send game-board get-list-of-bosses)))


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
      ((equal? key-tag #\m)
       (sound-on/sound-off))
      ((equal? key-tag  #\space)
       (when (send player can-fire?)
         (begin
           (send player fire game-board)
           (send player not-fireable)
           (send player-shoot-timer start (send player get-cool-down) #t)
           (playing-sound shoot))))
      ((equal? key-tag #\p)
       (send game-board pause/play)))))

(define (sound-on/sound-off)
  (send game-board set-sound (not (send game-board get-sound)))
  (if (send game-board get-sound)
      (playing-sound background)
      (stopping-sound)))

;; Create power-up object and adds it to game board
(define (spawn-power-up)
  (unless (> (length (send game-board get-list-of-power-ups)) 
             (send game-board get-num-of-power-ups))
    (let* ((_type (random 3))
           (power-up '()))
      (cond
        ((equal? _type 0) (set! power-up
                                (create-obj game-board health-boost% 'random)))
        ((equal? _type 1) (set! power-up
                                (create-obj game-board speed-boost% 'random)))
        ((equal? _type 2) (set! power-up
                                (create-obj game-board DMG-boost% 'random))))
      (send game-board add-power-up power-up))))

;; Create power-up object and adds it to game board
(define (spawn-asteroid)
  (unless (> (length (send game-board get-list-of-asteroids)) 
             (send game-board get-num-of-asteroids))
    (let ((asteroid (create-obj game-board asteroid% 'random)))
      (send game-board add-asteroid asteroid))))

;; Create enemy object and adds it to game board
(define (spawn-enemy)
  (unless (> (length (send game-board get-list-of-enemies)) 
             (send game-board get-num-of-enemies))
    (let ((enemy (create-obj game-board enemy% 'random)))
      (send game-board add-enemy enemy))))

;; Creates boss
(define (spawn-boss)
  ;Reset gameboard from projectiles, enemies and stops the spawing of them
  (send game-board set-list-of-projectiles '())
  (send game-board set-list-of-enemies '())
  (send game-board set-list-of-asteroids '())
  (send enemie-shoot-timer stop)
  (send spawn-asteroid-timer stop)
  (send spawn-enemy-timer stop)
  (send game-board add-boss (create-obj game-board boss% 'boss)))

;;check interactions of object 
(define (check-objects)
  ;; Makes sure that player do not walk outside of game-board
  (prevent-walkning-outside player game-board)
      
  (for-each (lambda (power-up)
              (when (out-of-bounce? power-up game-board)
                (send game-board set-list-of-power-ups
                      (send game-board delete-power-up power-up)))
              (when (collision? player power-up)
                (send player collision-action power-up)
                (send game-board set-list-of-power-ups
                      (send game-board delete-power-up power-up))))
            (send game-board get-list-of-power-ups))

  (for-each (lambda (asteroid)
              (when (out-of-bounce? asteroid game-board)
                (send game-board set-list-of-asteroids
                      (send game-board delete-asteroid asteroid)))
              (when (collision? player asteroid)
                (send player collision-action asteroid)
                (send game-board set-list-of-asteroids
                      (send game-board delete-asteroid asteroid))))
            (send game-board get-list-of-asteroids))

  (for-each (lambda (enemy)
              (when (out-of-bounce? enemy game-board)
                (begin
                  (send player set-health
                        (- (send player get-health) (send enemy get-DMG)))
                  (send game-board set-list-of-enemies
                        (send game-board delete-enemy enemy))))
              (when (collision? player enemy)
                (send player collision-action enemy)
                (send game-board set-list-of-enemies
                      (send game-board delete-enemy enemy))))
            (send game-board get-list-of-enemies))

  (for-each (lambda (boss)
              (when (or (out-of-bounce? boss game-board)
                        (collision? player boss))
                (send game-board game-over)))
            (send game-board get-list-of-bosses))

  (for-each (lambda (projectile)
              ;; Delete projectile when off screen
              (when (out-of-bounce? projectile game-board)
                (send game-board set-list-of-projectiles
                      (send game-board delete-projectile projectile)))
              (when (collision? player projectile)
                (send player collision-action projectile)
                (send game-board set-list-of-projectiles
                      (send game-board delete-projectile projectile)))
              ;; Enemy collision
              (for-each (lambda (enemy)
                          (when (and (collision? projectile enemy)
                                     (equal? (send projectile get-facing-direction) -1))
                            (send player set-value (+ (send player get-value)
                                                      (send enemy get-value)))
                            (send game-board set-list-of-enemies
                                  (send game-board delete-enemy enemy))
                            (send game-board set-list-of-projectiles
                                  (send game-board delete-projectile projectile))))
                        (send game-board get-list-of-enemies))
              ;; Boss collision
              (for-each (lambda (boss)
                          (when (collision? projectile boss)
                            (if (> (send boss get-health) 1)
                                (send boss set-health (- (send boss get-health)

                                                         (send projectile get-DMG)))
                                (begin
                                  (send game-board set-list-of-bosses
                                        (send game-board delete-boss boss))
                                  (send game-board boss-killed)))
                            (send game-board set-list-of-projectiles
                                  (send game-board delete-projectile projectile))))
                        (send game-board get-list-of-bosses))
              ;; Asteroid collision
              (for-each (lambda (asteroid)
                          (when (and (collision? projectile asteroid)
                                     (equal? (send projectile get-facing-direction) -1))
                            (send player set-value (+ (send player get-value)
                                                        (send asteroid get-value)))
                            (send game-board set-list-of-asteroids
                                  (send game-board delete-asteroid asteroid))
                            (send game-board set-list-of-projectiles
                                  (send game-board delete-projectile projectile))))
                        (send game-board get-list-of-asteroids)))
            (send game-board get-list-of-projectiles)))

  ;; Random if enemie should shoot
  (define (shoot-enemy)
    (for-each (lambda (enemy)
                (when (equal? (random 5) 1)
                  (send enemy fire game-board))) 
              (send game-board get-list-of-enemies)))

  ;; Boss shoots
  (define (shoot-boss)
    (for-each (lambda (boss)
                (send boss fire game-board))
              (send game-board get-list-of-bosses)))
                

  ;; ------- Initiation of game -------

  (define game-board
    (new gameboard%
         [_width 900]
         [_height 700]
         [_num-of-power-ups 5]
         [_num-of-enemies 7]
         [_num-of-asteroids 15]))


  (define player (create-obj game-board player% 'player))
  (send game-board add-player player)

  (define game-window (new frame%
                           [width 900]
                           [height 700]
                           [label "Space invader"]))
                             
  (send game-window show #t)

  (define pause-window (new dialog%
                            [parent game-window]
                            [label "Pause menu"]))
  
  (define play-button (new button%
                           [parent pause-window]
                           [callback (lambda (button event)
                                       (send game-board pause/play))]
                           [label "Play"]))

  (send play-button show #t)

  (define dead-window (new dialog%
                           [parent game-window]
                           [label "Death menu"]))

  (define dead-button (new button%
                           [parent dead-window]
                           [callback (lambda (button event) (exit))]
                           [label "You and your dogs are dead (loser),
 click here for a surprise!"]))
  (send dead-button show #t)


  (define win-window (new dialog%
                           [parent game-window]
                           [label "Death menu"]))

  (define win-button (new button%
                           [parent win-window]
                           [callback (lambda (button event) (exit))]
                           [label "Congratulations. You won!"]))
  (send win-button show #t)

  ;;canvas
  (define canvas (new game-canvas%
                      [parent game-window]
                      [keyboard-handler keyboard-input]
                      [paint-callback render-function]))

  (send canvas show #t)

  ;;Uppdate canvas
  (define (update)
    (send canvas refresh)
    (check-objects)
    (unless (send player alive?)
      (send game-board game-over))
    (unless (send game-board boss-alive?)
      (send game-board winning)))

  (define (set-fire)
    (send player fireable))

  ;;Update canvas timer
  (define update-timer (new timer% [notify-callback update]))                         
  (send update-timer start 16 #f)

  ;;Enemy spawn timer
  (define spawn-enemy-timer (new timer% [notify-callback spawn-enemy]))
  (send spawn-enemy-timer start 1400 #f)

  ;;Power-up spawn timer
  (define spawn-power-up-timer (new timer% [notify-callback spawn-power-up]))
  (send spawn-power-up-timer start 5000 #f)

  ;;Asteroid spawn timer
  (define spawn-asteroid-timer (new timer% [notify-callback spawn-asteroid]))
  (send spawn-asteroid-timer start 1000 #f)

  ;Make sure that player cannot spam shoots
  (define player-shoot-timer (new timer% [notify-callback set-fire]))

  ;Allows the enemy to shoot
  (define enemie-shoot-timer (new timer% [notify-callback shoot-enemy]))
  (send enemie-shoot-timer start 1000 #f)

  ;;Allows the boss to shoot
  (define boss-shoot-timer (new timer% [notify-callback shoot-boss]))
  (send boss-shoot-timer start 2000 #f)

  ;;Spawn boss two minutes in the game.
  (define boss-spawn (new timer% [notify-callback spawn-boss]))
  ;Two minutes
  (send boss-spawn start 60000 #t)
  