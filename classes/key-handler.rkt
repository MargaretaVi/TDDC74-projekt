#lang racket/gui
(require "characters.rkt")
(require "player.rkt")

(define *character* (new character% [_height 1] [_width 1])) 
(define a-window (new frame%
                          [label "Canvas"]
                          [width 500]
                          [height 500]))
(send a-window show #t)


(define (drawing-proc canvas dc)
  (let ((our-picture (make-object bitmap% "AA.png")))
    (send dc draw-bitmap our-picture (send *character* get-x-pos) (send *character* get-y-pos))))
    

(define a-canvas%
  (class canvas%
    (init-field keyboard-handler)

    (define/override (on-char key-fnc)
      (keyboard-handler key-fnc))
    (super-new)))

(define (key-fnc key-event)
  (let
      ((key-tag (send key-event get-key-code)))
  (cond
    ((eq? key-tag #\space)
     (send *character* fire))
    ((eq? key-tag #\a)
     (send *character* move-x -15))
    ((eq? key-tag #\d)
     (send *character* move-x 15))
    ((eq? key-tag #\w)
     (send *character* move-y -15))
    ((eq? key-tag #\s)
     (send *character* move-y 15))))
  (send a-window refresh))
;(send *character* get-y-pos)
(define our-canvas (new a-canvas%
                         [parent a-window]
                         [paint-callback drawing-proc]
                         [keyboard-handler key-fnc]))
(provide key-fnc)


;(send our-canvas focus)
