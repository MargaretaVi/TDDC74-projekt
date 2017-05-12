#lang racket/gui
(provide enemie%)
(require "characters.rkt")

(define enemie%
  (class character%
    (inherit-field
     _x-pos
     _y-pos
     _cool-down
     _facing-direction)
    (inherit
      fire
      move-y)
    (init-field
     [_scorevalue 0])
     
    ;; This is the opposite direction from how the player moves.
    ;;Reasonable since enemies moves down and player moves up
    (set! _facing-direction 0)
    
    ;; enemies has a longer cool down that player
    (set! _cool-down 600)
    
    ;; Creates a random spawn point for the enemie, 
    (define/public (random-spawn-pos game-board)
      (set! _x-pos (random-from-to 0 (send game-board get-width)))
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
    (define *enemie-bitmap*
      (make-object bitmap% "../images/player-bit.png"))
   
    (super-new)))

