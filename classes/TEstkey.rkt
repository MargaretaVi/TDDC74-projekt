#lang racket/gui

(define a-window (new frame%
                          [label "Prutt"]
                          [width 800]
                          [height 600]))
(send a-window show #t)

(define xpos 0)
(define ypos 0)

(define (drawing-proc canvas dc)
  (let ((our-picture (make-object bitmap% "AA.png")))
    (send dc translate xpos ypos)
    (send dc draw-bitmap our-picture 100 100)
    (send dc translate (- xpos) (- ypos))))

(define a-canvas%
  (class canvas%
    (init-field keyboard-handler)

    (define/override (on-char key-event)
      (keyboard-handler key-event))
    (super-new)))

(define (key-proc key-event)
  (let
      ((key-tag (send key-event get-key-code)))
  (cond
    ((eq? key-tag #\space)
     (set! shootybooty (shooty true)))
    ((eq? key-tag #\a)
     (set! xpos (- xpos 15)))
    ((eq? key-tag #\d)
     (set! xpos (+ xpos 15)))
    ((eq? key-tag #\w)
     (set! ypos (- ypos 15)))
    ((eq? key-tag #\s)
     (set! ypos (+ ypos 15)))))
  (send a-window refresh))

(define our-canvas (new a-canvas%
                         [parent a-window]
                         [paint-callback drawing-proc]
                         [keyboard-handler key-proc]))
(send our-canvas focus)
