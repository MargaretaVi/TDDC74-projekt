#lang racket/gui
(provide player%)
(require "object.rkt")
(require "item.rkt")

(define player%
  (class game-object%
    (super-new)
    (inherit-field
     _DMG-roof _health-roof
     _x-pos _y-pos
     _width _height
     _facing-direction _speed _DMG)
    (inherit set-height set-width set-speed set-health
             set-cool-down set-facing-direction)
    
    ; --- starting values
    (set-facing-direction -1)
    (set-speed 20)
    (set-health _health-roof)
    (set-cool-down 1000)

    ;; player bitmap
    (define player-bitmap
      (read-bitmap "../images/player.png"))

    (define/override (get-bitmap)
      player-bitmap)

    (set-height (send player-bitmap get-height))
    (set-width (send player-bitmap get-width))


    (define/override (fire game-board)
      ;; creates a projectile each and adds to list of projectiles
      (send game-board add-projectile
            (new player-projectile%
                 [_height 3] [_width 7]
                 [_x-pos (+ _x-pos (exact-round (/ _width 2)))]
                 [_y-pos (+ _y-pos _height 3)]
                 [_facing-direction _facing-direction]
                 [_speed (+ _speed 1)]
                 [_DMG _DMG])))

    ))



(define enemy%
  (class game-object%
    (super-new)
    (inherit-field
     _DMG-roof _health-roof
     _x-pos _y-pos
     _width _height
     _facing-direction _speed _DMG)
    (inherit move-x move-y random-spawn-pos set-height set-width)
    
    ;; Enemie bitmap
    (define enemie-bitmap
      (read-bitmap "../images/enemie.png"))

    ;Returns bitmap of enemy
    (define/override (get-bitmap)
      enemie-bitmap)

    (set-height (send enemie-bitmap get-height))
    (set-width (send enemie-bitmap get-width))
    
    (define/override (fire game-board)
      ;; creates a projectile each and adds to list of projectiles
      (send game-board add-projectile
            (new enemy-projectile%
                 [_height 3]
                 [_width 7]
                 [_x-pos (+ _x-pos (exact-round (/ _width 2)))]
                 [_y-pos (+ _y-pos _height 3)]
                 [_facing-direction _facing-direction]
                 [_speed (+ _speed 1)]
                 [_type 7]
                 [_DMG _DMG])))

    ))
    

(define boss%
  (class game-object%
    (super-new)
    (inherit-field
     _DMG-roof _health-roof
     _x-pos _y-pos
     _width _height
     _facing-direction _speed _DMG)

    (inherit move-x move-y random-spawn-pos set-height set-width)
    ;; boss bitmap
    (define boss-bitmap
      (read-bitmap  "../images/boss.png"))
    
    ;Returns bitmap of enemy
    (define/override (get-bitmap)
      boss-bitmap)
    
    (set-height (send boss-bitmap get-height))
    (set-width (send boss-bitmap get-width))
    
    (define/override (fire game-board)
      ;; creates a projectile each and adds to list of projectiles
      (send game-board add-projectile
            (new enemy-projectile%
                 [_height 3]
                 [_width 7]
                 [_x-pos (+ _x-pos (exact-round (/ _width 2)))]
                 [_y-pos (+ _y-pos _height 3)]
                 [_facing-direction _facing-direction]
                 [_speed (+ _speed 1)]
                 [_type 7]
                 [_DMG _DMG])))
    ))