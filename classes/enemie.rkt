#lang racket/gui
(provide enemie% create-enemy)
(require "characters.rkt")
(require "Items.rkt")

(define enemie%
  (class character%
    (inherit-field
     _x-pos
     _y-pos
     _speed
     _type
     _width
     _height
     _DMG
     _facing-direction)
    (inherit
      move-y
      move-x
      get-type)
    (init-field
     [_scorevalue 0])

    
    ;; Creates a random spawn point for the enemie, 
    (define/public (random-spawn-pos game-board)
      (set! _x-pos (random-from-to 0 (- (send game-board get-width) (send this get-width))))
      (set! _y-pos (random-from-to 0 (exact-round (* (send game-board get-height) 0.01)))))

    ;; Randomizer that gives a value between an intervall
    (define/public (random-from-to start stop)
      (+ (random (- stop (- start 1))) start))

    ;;Move function for enemies that is "automatic" enemies moves "step"-step in the vertical direction
    ;;after interval-time
    (define/public (move step inverval)
      (new timer%
           [notify-callback (move-y step)]
           [interval 1000]
           [just-once? #f]))
 
    ;; Enemie bitmap
    (define enemie-bitmap
      (read-bitmap "../images/enemie.png"))

    ;; boss bitmap
    (define boss-bitmap
      (read-bitmap  "../images/boss.png"))

    ;Returns bitmap of enemy
    (define/override (get-bitmap)
      (if (equal? _type 0)
          enemie-bitmap
          boss-bitmap))

    (define/override (fire game-board)
      ;; creates a projectile each and adds to list of projectiles
      (send game-board add-projectile
            (new projectile%
                 [_height 3]
                 [_width 7]
                 [_x-pos (+ _x-pos (exact-round (/ _width 2)))]
                 [_y-pos (+ _y-pos _height 3)]
                 [_facing-direction _facing-direction]
                 [_speed (+ _speed 1)]
                 [_type 7]
                 [_DMG _DMG])))

    (super-new)))

;;Enemie-spawner
(define (create-enemy)
  (new enemie%))

