#lang racket/gui
(provide player% enemy% boss%)
(require "object.rkt")
(require "item.rkt")
(require "miscellaneous.rkt")

(define player%
  (class game-object%
    (super-new)
    (inherit-field
     _DMG _DMG-roof
     _x-pos _y-pos
     _width _height
     _health  _health-roof
     _facing-direction
     _speed _speed-roof
     _alive _value)
    (inherit set-height set-width set-speed set-health
             set-cool-down set-facing-direction set-DMG
             fireable get-height set-value) 
    
    ; --- starting values
    (set-facing-direction -1)
    (set-speed 30)
    (set-health _health-roof)
    (set-cool-down 500)
    (set-DMG 1)
    (fireable)

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
                 [_x-pos (+ _x-pos (exact-round (/ _width 2)))]
                 [_y-pos (- _y-pos (- _height 5))]
                 [_facing-direction _facing-direction]
                 [_speed (* _facing-direction (exact-round (* _speed 0.1)))]
                 [_DMG _DMG])))

     ;; Decides what happens when collided with an object
    (define/public (collision-action object)
      (cond
        [(or (is-a? object enemy%)
             (is-a? object boss%)
             (is-a? object asteroid%)
             (is-a? object boss-projectile%)
             (is-a? object enemy-projectile%))
         (begin
           (set! _health (- _health (send object get-DMG)))
           (set-value (+ _value (send object get-value)))
           (when (< _health 1)
             (set! _alive #f)))]    
        [(is-a? object DMG-boost%)
         (begin
           (set-value (+ _value (send object get-value)))
           (if (> (send this get-DMG) _DMG-roof)
                                       (set-DMG _DMG-roof)
                                       (set-DMG (+ (send this get-DMG)
                                                   (send object get-value)))))]
        [(is-a? object speed-boost%)
         (begin
           (set-value (+ _value (send object get-value)))
           (if (> _speed _speed-roof)
               (set-speed _speed-roof)
               (set-speed (+ _speed (send object get-value)))))]
        [(is-a? object health-boost%)
         (begin
           (set-value (+ _value (send object get-value)))
           (if (> _health _health-roof)
               (set-health _health-roof)
               (set-health (+ (send this get-health)
                         (send object get-value)))))]))))

;; ---- enemie class ----
(define enemy%
  (class game-object%
    (super-new)
    (inherit-field
     _DMG-roof _health-roof
     _x-pos _y-pos
     _width _height
     _facing-direction _speed _DMG)
    (inherit move-x move-y set-height set-width set-DMG)


    (set-DMG 1)
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
                 [_x-pos (+ _x-pos (exact-round (/ _width 2)))]
                 [_y-pos (+ _y-pos _height 3)]
                 [_facing-direction  _facing-direction]
                 [_speed (+ _speed 1)]
                 [_DMG _DMG])))))


;; ---- boss class ----
(define boss%
  (class game-object%
    (super-new)
    (inherit-field
     _DMG-roof _health-roof
     _x-pos _y-pos
     _width _height
     _facing-direction _speed _DMG)

    (inherit move-x move-y set-height set-width
             set-health set-DMG set-speed)

    (set-health 10)
    (set-DMG 5)
    (set-speed 1)
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
            (new boss-projectile%
                 [_x-pos (+ _x-pos (exact-round (/ _width 2)))]
                 [_y-pos (+ _y-pos _height 3)]
                 [_facing-direction _facing-direction]
                 [_speed (+ _speed 1)]
                 [_DMG _DMG])))))