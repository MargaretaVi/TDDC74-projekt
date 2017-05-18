#lang racket/gui
(provide character%)
(require "Items.rkt")

(define character%
  (class object%

    ;;Member of class character
    (init-field
     [_height 0] ; y-axis
     [_width 0] ; x-axis
     [_health 3]
     [_x-pos 0] ;; states the upper left corner
     [_y-pos 0] ;; states the upper left corner
     [_speed 1] ;; how many pixels per update
     [_can-fire #t]
     [_cool-down 100]
     [_facing-direction 1];; facing downwards
     [_DMG 1]
     [_DMG-roof 5]
     [_speed-roof 30]
     [_health-roof 30]
     [_alive #t]
     [_type 0]
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
    (define/public (alive?)
      _alive)

    (define/public (get-cool-down)
      _cool-down)

    ;; type here is either 0-player ,1-normal enemie, 2-boss
    (define/public (get-type)
      _type)
    ;; ------------------------------------

    ;; Sets the x-pos to a specific value
    (define/public (set-x-pos pos)
      (set! _x-pos pos))

    ;; Sets the y-pos to a specific value
    (define/public (set-y-pos pos)
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
    (define/public (fireable)
      (set! _can-fire #t))

    ;; Sets the variable "can-fire" to false.
    (define/public (not-fireable)
      (set! _can-fire #f))
    
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

    ;; Set speed
    (define/public (set-speed val)
      (set! _speed val))
    
    ;; Set DMG
    (define/public (set-DMG val)
      (set! _DMG val))

    ;; Set health
    (define/public (set-health val)
      (set! _health val))

    ;; Set cool down
    (define/public (set-cool-down val)
      (set! _cool-down val))

    (define/public (set-facing-direction val)
      (set! _facing-direction val))

    ;; Decides what happens when collided with an object
    (define/public (collision-action object)
      (cond
        ((or (equal? (send object get-type) 1)
             (equal? (send object get-type) 2)
             (equal? (send object get-type) 6))
         (begin
           (set! _health (- _health 1))
           (unless (not (< _health 0))
             (set! _alive #f))))       
        ((equal? (send object get-type) 3)
         (if (> (send this get-DMG) _DMG-roof)
             (set-DMG _DMG-roof)
             (set-DMG (+ (send this get-DMG)
                         (send object get-value)))))
        ((equal? (send object get-type) 4)
         (set-speed (+ _speed (send object get-value)))) 
        ((equal? (send object get-type) 5)
         (set-health (+ _health (send object get-value))))))
    
     ;; Fire-function
    (define/public (fire game-board)
      (let ((type_tmp 0))
        (if (> _DMG 5)
            (set! type_tmp 8)
            (set! type_tmp 7))
        ;; creates a projectile each and adds to list of projectiles
        (send game-board add-projectile
              (new projectile%
                   [_height 3]
                   [_width 7]
                   [_x-pos (+ _x-pos (exact-round (/ _width 2)))]
                   [_y-pos (+ _y-pos (* _facing-direction (/ _height 2)))]
                   [_type type_tmp]
                   [_facing-direction _facing-direction]
                   [_DMG _DMG]))))

    
    (super-new)))
