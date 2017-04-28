#lang racket/gui
(provide character%)

(define character%
  (class object%

    ;;Member of class character
    (init-field
     _name
     [_health 10]
     [_x-pos 0]
     [_y-pos 0]
     [_speed 2] ;; how many pixels per update
     [_can-fire #t]
     [_cool-down 300]
     [_facing-direction 1] ;; facing upwards
     ;; _radius ?? 
     )

    ;; Functions that returns the class members
    (define/public (get-name)
      _name)
    
    (define/public (get-health)
      _health)
    
    (define/public (get-x-pos)
      _x-pos)
    
    (define/public (get-y-pos)
      _y-pos)

    (define/public (can-fire?)
      _can-fire)

    ;; ------------------------------------

    ;; Function takes a parameter "value"
    ;; calculates the new health for the character.
    (define/public (decrease-health _value)
     (set! _health (- _health _value)))


    ;; Function takes a parameter "value"
    ;; calculates the new health for the character.
    (define/public (increase-health _value)
      (set! _health (+ _health _value)))

    ;; Function takes a parameter "value"
    ;; and calculates a new x-pos for the character.
    (define/public (move-x _value)
      (if (= _value 0)
          (void)
          (set! _x-pos (+ _x-pos _value))))

    ;; Function takes a parameter "value"
    ;; and calculates a new x-pos for the character.
    (define/public (move-y _value)
      (if (= _value 0)
          (void)
          (set! _y-pos (+ _y-pos _value))))

    ;; Function sets the variable "can-fire" to true.
    (define/public (reset-can-fire)
      (set! _can-fire #t))

    (define/public (fire)      
      ;; Creates a projectile object
      #|
      (new projectile% ...
|#

      ;; To make sure that the player do not spam, a timer is used
      (set! _can-fire #f)
      (new timer%
           [notify-callback (reset-can-fire)]
           [interval _cool-down]
           [just-once? #t]))
    
    (super-new)))
         
       
         

    
    