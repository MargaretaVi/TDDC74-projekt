#lang racket/gui
(provide character%)
(define character%
  (class object%

    ;;Member of class character
    (init-field
     [_height 0] ; y-axis
     [_width 0] ; x-axis
     [_health 10]
     [_x-pos 0] ;; states the upper left corner
     [_y-pos 0] ;; states the upper left corner
     [_speed 3] ;; how many pixels per update
     [_can-fire #t]
     [_cool-down 600]
     [_facing-direction 1];; facing downwards
     [_DMG 5]
     [_DMG-roof 40]
     )

    ;; Functions that returns the class members

    (define/public (get-health)
      _health)
    
    (define/public (get-x-pos)
      _x-pos)
    
    (define/public (get-y-pos)
      _y-pos)

    (define/public (can-fire?)
      _can-fire)

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
    ;; ------------------------------------

    ;; Sets the x-pos to a specific value
    (define (set-x-pos pos)
      (set! _x-pos pos))

    ;; Sets the y-pos to a specific value
    (define (set-y-pos pos)
      (set! _y-pos pos))
      
    ;; Calculates the new health for the character. (decreasing)
    (define/public (decrease-health _value)
     (set! _health (- _health _value)))

    ;; Calculates the new health for the character. (increasing)
    (define/public (increase-health _value)
      (set! _health (+ _health _value)))

    ;; Moves the character in the x-direction
    (define/public (move-x _step)
      (set-x-pos (+ _x-pos _step)))

    ;; Moves the character in the y-direction
    (define/public (move-y _step)
      (set-y-pos (+ _y-pos _step)))

    ;; Sets the variable "can-fire" to true.
    (define/public (reset-can-fire)
      (set! _can-fire #t))

    ;; Set width
    (define/public (set-width value)
      (set! _width value))

    ;;Set height
    (define/public (set-height value)
      (set! _height value))
    ;; Placeholder for returning the specific bitmap
    (define/public (get-bitmap)
      (void))

    ;; Update position, health of character
    (define/public (update)
      (move-x 0)
      (move-y _speed))
    
    (super-new)))
