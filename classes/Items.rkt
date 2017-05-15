#lang racket/gui
(provide item% projectile%)

(define item%
  (class object%
    (init-field
     _height
     _width
     _type ; Which type of item (rnd number)
     [_x-pos 0]
     [_y-pos 0] 
     [_value 0] ; Value for the booster, how much to increase
     [_scorevalue 0];placeholder for requirement 2
     [_sound 0]) ;placeholder for requirement 2

    #|
_type:
Type == 1 , DMG
Type == 2 , SPEED
Type == 3 ; HEALTH
4-5 projectile (4 default, 5 better)

|#
        
    ;Get current x- and y-coordinates
    (define/public (get-x-pos)
      _x-pos)
    
    (define/public (get-y-pos)
      _y-pos)
    
    ;; Sets the x-pos to a specific value
    (define/public (set-x-pos pos)
      (set! _x-pos pos))

    ;; Sets the y-pos to a specific value
    (define/public (set-y-pos pos)
      (set! _y-pos pos))

    ;; Moves the item in the x-direction
    (define/public (move-x _step)
      (set-x-pos (+ _x-pos _step)))

    ;; Moves the item in the y-direction
    (define/public (move-y _step)
      (set-y-pos (+ _y-pos _step)))

    ;Get width of item
    (define/public (get-width)
      _width)
    
    ; set width
    (define/public (set-width value)
      (set! _width value))
    
    ;get height of item
    (define/public (get-height)
      _height)

    ; set width
    (define/public (set-height num)
      (set! _height num))
    
    ; set type
    (define/public (set-type num)
      (set! _type num))

    ; set value
    (define/public (set-value num)
      (set! _value num))
    
    ;Random number between 1 and 3 to decide type      
    (define/public (random-from-to start stop)
      (+ (random (- stop (- start 1))) start))

    ;Which type were randomed? Which value does this give?
    (define/public (booster)
      (set-type (random-from-to 1 3))
      (cond [(equal? _type 1) (set-value 1)]
            [(equal? _type 2) (set-value 2)]
            [(equal? _type 3) (set-value 3)]
            [else (void)]))

    ;; health-power-up bitmap
    (define health-bitmap (make-object bitmap% "../images/health-img.png"))
    
    ;; DMG-power-up bitmap
    (define DMG-bitmap (make-object bitmap% "../images/dmg.png"))
    
    ;; speed-power-up bitmap
    (define speed-bitmap (make-object bitmap% "../images/speed.png"))

    (define/public (get-bitmap)
      (cond
        ((equal? (send this get-type) 1)
         DMG-bitmap)
        ((equal? (send this get-type) 2)
         speed-bitmap)
        ((equal? (send this get-type) 3)
         health-bitmap)))
    
    (super-new)))

;Class projectile, subclass to item
(define projectile%
  (class item%
    (super-new)
    (inherit-field
     _height)  
    (inherit
      ;move-y
             set-x-pos
             set-y-pos
             set-width
             set-height
             set-value)
    (set-height 25)
    (set-width 15)
    (set-value 1)
    (init-field _facing-direction
                _DMG)

    ;; projectile bitmap
    (define projectile-bitmap
      (make-object bitmap% "../images/normal-proj.png"))

    (define/override (get-bitmap)
      projectile-bitmap))) 
      
      