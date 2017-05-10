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
    (send dc translate (send *character* get-x-pos) (send *character* get-y-pos))
    (send dc draw-bitmap our-picture 100 100)))

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
     (send *character* move-x -1))
    ((eq? key-tag #\d)
     (send *character* move-x 1))
    ((eq? key-tag #\w)
     (send *character* move-y -1))
    ((eq? key-tag #\s)
     (send *character* move-y 1))))
  (send a-window refresh))

(define our-canvas (new a-canvas%
                         [parent a-window]
                         [paint-callback drawing-proc]
                         [keyboard-handler key-fnc]))
;(send our-canvas focus)
