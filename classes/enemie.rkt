#lang racket
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
      fire)
    
    (init-field
     [_scorevalue 0])
     
    ;; This is the opposite direction from how the player moves.
    ;;Reasonable since enemies moves down and player moves up
    (set! _facing-direction 0)
    
    ;; enemies has a longer cool down that player
    (set! _cool-down 600)
    
    ;; Creates a random spawn point for the enemie, 
    (define/public (random-spawn-pos *game-board*)
      (set! _x-pos (random-from-to 0 (send *game-board* get-width)))
      (set! _y-pos (random-from-to 0 (exact-round (* (send *game-board* get-height) 0.01)))))

    ;; Randomizer that gives a value between an intervall
    (define/public (random-from-to start stop)
      (+ (random (- stop (- start 1))) start))

    (super-new)))