#lang racket/gui
(require "miscellaneous.rkt")

(provide game-object%)
(define game-object%
  (class object%
    (super-new)
    ;;Member of class object
    (init-field 
     [_height 0] [_width 0] 
     [_health 1]
     [_x-pos 0] [_y-pos 0]
     [_speed 1]
     [_facing-direction 1] ;; facing downwards
     [_DMG 0]
     [_alive #t]
     [_can-fire #f]
     [_cool-down 0]
     [_health-roof 20]
     [_speed-roof 20]
     [_DMG-roof 10] ; Check so that the same value is in item.rkt player projectile
     [_value 0])
     ;; ----- Getters --------   
    (define/public (get-height)
      _height)
    
    (define/public (get-width)
      _width)

    (define/public (get-health)
      _health)
    
    (define/public (get-x-pos)
      _x-pos)
    
    (define/public (get-y-pos)
      _y-pos)

    (define/public (get-speed)
      _speed)
    
    (define/public (get-facing-direction)
      _facing-direction)
    
    (define/public (get-DMG)
      _DMG)

    (define/public (alive?)
      _alive)

    (define/public (can-fire?)
      _can-fire)

    (define/public (get-cool-down)
      _cool-down)

    (define/public (get-health-roof)
      _health-roof)

    (define/public (get-speed-roof)
      _speed-roof)

    (define/public (get-DMG-roof)
      _DMG-roof)

    (define/public (get-value)
      _value)

    ;; ------ setters ---------------

    (define/public (set-height _val)
      (set! _height _val))
    
    (define/public (set-width _val)
      (set! _width _val))

    (define/public (set-health _val)
      (set! _health _val))

    (define/public (not-alive)
      (set! _alive #f))
    
    (define/public (set-x-pos _pos)
      (set! _x-pos _pos))

    (define/public (set-y-pos _pos)
      (set! _y-pos _pos))

    (define/public (set-speed _val)
      (set! _speed _val))

    (define/public (set-facing-direction _val)
      (set! _facing-direction _val))
    
    (define/public (set-DMG _value)
      (set! _DMG _value))

    (define/public (set-alive _val)
      (set! _alive _val))

  (define/public (fireable)
    (set! _can-fire #t))

    (define/public (not-fireable)
      (set! _can-fire #f))

    (define/public (set-cool-down _val)
      (set! _cool-down _val))

    (define/public (set-health-roof _val)
      (set! _health-roof _val))

    (define/public (set-speed-roof _val)
      (set! _speed-roof _val))

    (define/public (set-DMG-roof _val)
      (set! _DMG-roof _val))

    (define/public (set-value _val)
      (set! _value _val))

    ;; ------ Functions --------------
    ;; Moves the object in the x-direction
    (define/public (move-x _step)
      (set-x-pos (+ _x-pos _step)))

    ;; Moves the object in the y-direction
    (define/public (move-y _step)
      (set-y-pos (+ _y-pos _step)))

    ;; Update position
    (define/public (update)
      (move-x 0)
      (move-y _speed))
    
    ;; Placeholder for functions
    (define/public (get-bitmap)
      (void))

    (define/public (fire game-board)
      (void))))

