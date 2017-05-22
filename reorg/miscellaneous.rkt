#lang racket/gui
(provide (all-defined-out))

;; Randomizer that gives a value between an intervall
(define (random-from-to start stop)
  (+ (random (- stop (- start 1))) start))


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

;; Creates a random spawn point for object (x and y)
(define (random-x-pos game-board object)
  (random-from-to 0 (- (send game-board get-width) (send object get-width))))

(define (random-y-pos game-board)
  (random-from-to 0 (exact-round (* (send game-board get-height) 0.01))))


;; Creates a new object from input class
(define (create-obj game-board class specification)
  (let ((new-obj (new class)))
    (cond
      ((equal? specification 'player)
       (begin
         (send new-obj set-x-pos
               (- (exact-round (/ (send game-board get-width) 2)) 30))
         (send new-obj set-y-pos (- (send game-board get-height) 80))))
      ((equal? specification 'random)
        (begin
          (send new-obj set-x-pos (random-x-pos game-board new-obj))
          (send new-obj set-y-pos (random-y-pos game-board))))
      ((equal? specification 'boss)
       (begin
        (send new-obj set-x-pos
               (- (exact-round (/ (send game-board get-width) 2)) 30))
         (send new-obj set-y-pos 0))))
    (send new-obj set-width (send (send new-obj get-bitmap) get-width))
    (send new-obj set-height (send (send new-obj get-bitmap) get-height))
    new-obj))

