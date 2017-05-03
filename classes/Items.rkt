#lang racket
(provide item%)

(define item%
  (class object%
    (init-field _x-pos
                _y-pos
                _height
                _width
                _type ; Which type of item (rnd number)
                _scorevalue ;placeholder for requirement 2
                _sound ;placeholder for requirement 2
                _value) ; Value for the booster, how much to increase
    
    ;; Sets the x-pos to a specific value
    (define (set-x-pos pos)
      (set! _x-pos pos))

    ;; Sets the y-pos to a specific value
    (define (set-y-pos pos)
      (set! _y-pos pos))

    ;; Moves the item in the x-direction
    (define/public (move-x _step)
      (set-x-pos (+ _x-pos _step)))

    ;; Moves the item in the y-direction
    (define/public (move-y _step)
      (set-y-pos (+ _y-pos _step)))
    
    ;Get current x- and y-coordinates
    (define/public (get-x-pos)
      _x-pos)
    
    (define/public (get-y-pos)
      _y-pos)
    
    ;Get width of item
    (define/public (get-width)
      _width)
    
    ;get height of item
    (define/public (get-height)
      _height)
    ;Random number between 1 and 3 to decide type      
    (define/public (random-from-to start stop)
      (+ (random (- stop (- start 1))) start))

    ;Which type were randomed? Which value does this give?
    (define/public (booster)
      (set! _type (random-from-to 1 3))
      (cond [(equal? _type 1) (equal? _value 1)]
            [(equal? _type 2) (equal? _value 2)]
            [(equal? _type 3) (equal? _value 3)]
            [else (void)]))
    (super-new)))

;Class astroid, subclass to item%
(define astroid%
  (class item%
    (inherit move-y)
    ;Astroid moves twice as fast as item (given step above is 1)
    (define/public (faster-move)
      (move-y 2))
    (inherit get-x-pos)
    (inherit get-y-pos)
    (super-new)))

;Class projectile, subclass to item
(define projectile%
  (class item%
    (init-field _facing-direction
                damage)
    (inherit move-y)))

; GLÖM FÖR FAN INTE REQUIRE/PROVIDE OM DU BEHÖVER DET !!!

(define test (new astroid%
     [_x-pos 0]
     [_y-pos 0]
     [_type 0]
     [_scorevalue 0]
     [_sound 0]
     [_height 20]
     [_width 20]
     [_value 0]))
