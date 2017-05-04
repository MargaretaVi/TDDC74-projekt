#lang racket/gui
(provide character%)
(require "Items.rkt")

(define character%
  (class object%

    ;;Member of class character
    (init-field
     _height ; y-axis
     _width ; x-axis
     [_health 10]
     [_x-pos 0] ;; states the upper left corner
     [_y-pos 0] ;; states the upper left corner
     [_speed 2] ;; how many pixels per update
     [_can-fire #t]
     [_cool-down 300]
     [_facing-direction 1];; facing upwards
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

    (define/public (fire)      
      ;; Creates a projectile object
      (let ((type_tmp 0))
        (if (> _DMG 5)
            (set! type_tmp 5)
            (set! type_tmp 4))
        (new projectile%
             [_x-pos (+ (send this get-x-pos) (send this get-width) 2)]
             [_y-pos (+ (send this get-y-pos) (send this get-height) 2)]
             [_type type_tmp]))

      ;; To make sure that the player do not spam, a timer is used
      (set! _can-fire #f)
      (new timer%
           [notify-callback (reset-can-fire)]
           [interval _cool-down]
           [just-once? #t]))
  
    
    (super-new)))
         
       
         

    
    