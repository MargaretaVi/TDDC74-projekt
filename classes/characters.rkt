#lang racket
(define character%
  (class object%
    (init-field
     [_health 10]
     [_x-pos 0]
     [_y-pos 0]
     [_speed 2] ;; how many pixels per update
     ;; _radius ?? 
     
     )
    (define/public (get-health)
      _health)
    
    (define/public (get-x-pos)
      _x-pos)
    
    (define/public (get-y-pos)
      _y-pos)
    
    (define/public (decrease-health value)
     (set! _health (- _health value)))

    (define/public (increase-health value)
      (set! _health (+ _health value)))

    (define/public (move-x value)
      (if (= value 0)
          (void)
          (set! _x-pos (+ _x-pos value))))
    ;; check if position is moveable, if it is
    ;; then set _x-pos to (+ _x-pos value)
    ;; else move-x (- value (/ value (abs value)))
          
    

    (super-new)))
         
       
         

    
    