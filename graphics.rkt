#lang racket/gui
(require "classes/key-handler.rkt")
(require "classes/characters.rkt")
(require "classes/items.rkt")
;(require "classes/AA.png")
(provide *game-window* drawing-proc game-canvas%)

(define *game-window* (new frame%
                           [width 1000]
                           [height 1000]
                           [label "Space invader"]))


(define (drawing-proc canvas *character* dc)
  (let ((our-picture (make-object bitmap% "AA.png")))
    (send dc draw-bitmap our-picture (send *character* get-x-pos) (send *character* get-y-pos))))


;; draw object function
(define (draw-object object dc)
  (send object draw dc))

;; Render function
(define (render-function *canvas* dc)
  ;Draws out the map 
  (draw-object (send *canvas* get-map) dc)

  ;;Draw player  
  (for-each (lambda (player)
              (draw-object player dc))
            (send *canvas* get-list-of-player))

  ;;Draw enemies
  (for-each (lambda (enemie)
              (draw-object enemie dc))
            (send *canvas* get-list-of-enemies))

  ;;Draw projectiles
  (for-each (lambda (object)
              (send object update)
              (draw-object object dc))
            (send *canvas* get-list-of-projectiles))

  ;;Draw power-ups
  (for-each (lambda (object)
              (send object update)
              (draw-object object dc))
            (send *canvas* get-list-of-power-ups))

  (for-each (lambda (asteroid)
              (send asteroid update)
              (draw-object asteroid dc)
              (send *canvas* get-list-of-asteroids))))



  
;; canvas for the game
(define game-canvas%
  (class canvas%
    ;;--- comment out when fixed keyboard handler
    (init-field
     keyboard-handler)
    (define/override (on-char key-event)
      (key-fnc key-event))
    ;; -----
    (super-new)))
      

;;init game canvas
;(define *canvas* (new game-canvas%
;                      [parent *game-window*]
;                      ;;--- comment out when fixed keyboard handler
;                      [keyboard-handler key-fnc]
;                      [paint-callback render-function]))

;;Return the canvas
(define (get-game-canvas *canvas*)
  *canvas*) 
#|

;;Uppdate canvas
(define (refresh-canvas *canvas*)
  (send *canvas* refresh))

;;Timer which says when the canvas should update
(define *update-timer* (new timer%
                            [notify-callback refresh-canvas]))


                            [interval 16]
                            [just-once? #f]))
|#
