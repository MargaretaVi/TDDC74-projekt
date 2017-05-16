#lang racket/gui
(provide enemie% create-enemy)
(require "characters.rkt")

(define enemie%
  (class character%
    (inherit-field
     _x-pos
     _y-pos
     _speed)
    (inherit
      move-y
      move-x)
    (init-field
     [_scorevalue 0]
     [_type 0])
    ;; type here is either 0 or 1, indicating if it is a normal enemy or a boss 

    (define/public (get-type)
      _type)
    
    ;; Creates a random spawn point for the enemie, 
    (define/public (random-spawn-pos game-board)
      (set! _x-pos (random-from-to 0 (- (send game-board get-width) (send this get-width))))
      (set! _y-pos (random-from-to 0 (exact-round (* (send game-board get-height) 0.01)))))

    ;; Randomizer that gives a value between an intervall
    (define/public (random-from-to start stop)
      (+ (random (- stop (- start 1))) start))

    ;;Move function for enemies that is "automatic" enemies moves "step"-step in the vertical direction
    ;;after interval-time
    (define/public (move step inverval)
      (new timer%
           [notify-callback (move-y step)]
           [interval 1000]
           [just-once? #f]))
 
    ;; Enemie bitmap
    (define enemie-bitmap
      (read-bitmap "../images/enemie.png"))

    ;; boss bitmap
    (define boss-bitmap
      (read-bitmap  "../images/boss.png"))

    ;Returns bitmap of enemy
    (define/override (get-bitmap)
      (if (equal? _type 0)
          enemie-bitmap
          boss-bitmap))
    
    (super-new)))

;;Enemie-spawner
(define (create-enemy)
  (new enemie%))