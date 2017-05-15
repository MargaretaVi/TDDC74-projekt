#lang racket/gui
(require "classes/key-handler.rkt")
(require "classes/player.rkt")
(require "classes/items.rkt")
;(provide game-window game-canvas% update-timer canvas)
#|
(define game-window (new frame%
                         [width 1300]
                         [height 1300]
                         [label "Space invader"]))
(send game-window show #t)

#|(define (drawing-proc canvas  character  dc)
  (let ((our-picture (make-object bitmap% "AA.png")))
    (send dc draw-bitmap our-picture (send  character  get-x-pos) (send  character get-y-pos))))
|#

;; draw object function
(define (draw-object object dc)
  (send dc draw-bitmap (send object get-bitmap) (send object get-x-pos) (send object get-y-pos)))

;; Render function
(define (render-function canvas dc)

  ;;Draw player  
  (for-each (lambda (player)
              (draw-object player dc))
            (send game-board get-list-of-player))

  ;;Draw enemies
  (for-each (lambda (enemie)
              (draw-object enemie dc))
            (send game-board get-list-of-enemies))

  ;;Draw projectiles
  (for-each (lambda (object)
              (draw-object object dc))
            (send game-board get-list-of-projectiles))

  ;;Draw power-ups
  (for-each (lambda (object)
              (draw-object object dc))
            (send  game-board  get-list-of-power-ups))

  (for-each (lambda (asteroid)
              (send asteroid update)
              (draw-object asteroid dc)
              (send game-board get-list-of-asteroids))))


;; canvas-class for the game
(define game-canvas%
  (class canvas%
    (init-field
     keyboard-input)
    (define/override (on-char key-event)
      (keyboard-input key-event))
    (super-new)))

;; Actions depending on pressed key
(define (keyboard-input keyboard-list )
  (cond
    ((send keyboard-list pressed? #\d)
     (send player move-x (send player get-speed))))
  (cond
    ((send keyboard-list pressed? #\a)
     (send player move-x (- 0 (send player get-speed)))))
  (cond
    ((send keyboard-list pressed? #\w)
     (send player move-y (- 0 (send player get-_speed)))))
  (cond
    ((send input-list pressed? #\s)
     (send player move-y (send player get-speed))))
  (cond
    ((send input-list pressed? #\space)
     (unless (not (send player can-fire?))   
       (send player fire)))))
   
;;init game canvas
(define canvas (new game-canvas%
                    [parent game-window]
                    [keyboard-input keyboard-input]
                    [paint-callback render-function]))

(send canvas show #t)
;;Return the canvas
(define (get-game-canvas)
  canvas) 

;;Uppdate canvas
(define (refresh-canvas)
  (send canvas refresh))

;;Timer which says when the canvas should update
(define update-timer (new timer%
                          [notify-callback refresh-canvas]))
                           
(send update-timer start 16 #f)
|#
