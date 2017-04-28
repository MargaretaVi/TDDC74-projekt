#lang racket

(define item%
  (class object%
    (init-field _x-pos
                _y-pos
                _type ; Which type of item (rnd number)
                _scorevalue ;placeholder for requirement 2
                _sound ;placeholder for requirement 2
                _value) ; Value for the booster 
    
    ;Item moves only in y-direction. X-position presented for consistency. 
    (define/public (move-y step)
      (set! _y-pos (+ _y-pos step)))
    (define/public (move-x step)
      (set! _x-pos _x-pos))
                   
    ;Get current x- and y-coordinates
    (define/public (get-x-pos)
      _x-pos)
    (define/public (get-y-pos)
      _y-pos)

    ;Random number between 1 and 3 to decide type      
    (define/public (random-from-to start stop)
      (+ (random (- stop (- start 1))) start))

    ;Which type where randomed? Which value does this give?
    (define/public (booster _type _value)
      (set! _type (random-from-to))
      (cond [(= _type 1) (= _value 1)]
            [(= _type 2) (= _value 2)]
            [(= _type 3) (= _value 3)]
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
     [type 0]
     [scorevalue 0]
     [sound 0]
     [_type 0]))
