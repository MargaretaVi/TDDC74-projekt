#lang racket
(provide (all-defined-out))

;; checks if two bounding obxes from two objecs collides 
(define (collision? object1 object2)
  (let ((_x1-pos (send object1 get-x-pos))
        (_y1-pos (send object1 get-y-pos)) 
        (_width1 (send object1 get-width))
        (_height1 (send object1 get-height)) 
        (_x2-pos (send object2 get-x-pos))
        (_y2-pos (send object2 get-y-pos)) 
        (_width2 (send object2 get-width))
        (_height2 (send object2 get-height))
        (_facing-direction1 (send object1 get-facing-direction))
        (_facing-direction2 (send object2 get-facing-direction)))
    
    (and (< _x1-pos (+ _x2-pos _width2)) (> (+ _x1-pos _width1) _x2-pos)
         (< _y1-pos (+ _y2-pos _height2)) (> (+ _height1 _y1-pos) _y2-pos)
         (not (equal? _facing-direction1 _facing-direction2)))))

;; is object outside of the game-board?
(define (out-of-bounce? object game-board)
  (let ((_obj-x-pos (send object get-x-pos))
        (_obj-y-pos (send object get-y-pos))
        (_obj-width (send object get-width))
        (_obj-height (send object get-height))
        (_width (send game-board get-width))
        (_height (send game-board get-height)))
    (or (< _obj-x-pos 0) (< _obj-y-pos 0)
        (> (+ _obj-x-pos _obj-width) _width) (> (+ _obj-y-pos _obj-height) _height))))

;; prevents the player to walk outside of the game board
(define (prevent-walkning-outside player game-board)
  (let ((_obj-x-pos (send player get-x-pos))
        (_obj-y-pos (send player get-y-pos))
        (_obj-width (send player get-width))
        (_obj-height (send player get-height))
        (_width (send game-board get-width))
        (_height (send game-board get-height)))
    (cond
      ((< _obj-x-pos 0) (send player set-x-pos 0))
      ((< _obj-y-pos 0) (send player set-y-pos 0))
      ((> _obj-x-pos _width) (send player set-x-pos _width))
      ((> _obj-y-pos _height) (send player set-y-pos _height)))))
    
    