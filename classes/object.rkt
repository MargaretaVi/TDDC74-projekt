#lang racket
(define game-objects%
  (class object%
    ;;Member of class object
    (init-field
     [_height 0] ; y-axis
     [_width 0] ; x-axis
     [_health 3]
     [_health-roof 30]
     [_x-pos 0] ;; states the upper left corners x-pos
     [_y-pos 0] ;; states the upper left corners y-pso 
     [_speed 1] ;; how many pixels per update
     [_speed-roof 30]
     [_facing-direction 1];; facing downwards
     [_DMG 1]
     [_DMG-roof 5]
     [_alive #t]
     ;[_type 0]
     )

     ;; Functions that returns the class members

    (define/public (get-health)
      _health)
    
    (define/public (get-x-pos)
      _x-pos)
    
    (define/public (get-y-pos)
      _y-pos)

    (define/public (get-DMG)
      _DMG)

    (define/public (get-facing-direction)
      _facing-direction)

    (define/public (get-width)
      _width)

    (define/public (get-height)
      _height)
    
    (define/public (get-speed)
      _speed)
    
    (define/public (alive?)
      _alive)

    ))