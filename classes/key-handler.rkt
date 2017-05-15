#lang racket/gui
(provide keyboard-handler% keyboard-list)
#|
(define (key-fnc player key-event)
  (let
      ((key-tag (send key-event get-key-code)))
  (cond
    ((eq? key-tag #\space)
     (send player fire))
    ((eq? key-tag #\a)
     (send player move-x -15))
    ((eq? key-tag #\d)
     (send player move-x 15))
    ((eq? key-tag #\w)
     (send player move-y -15))
    ((eq? key-tag #\s)
     (send player move-y 15))))
  (send a-window refresh))
|#
(define keyboard-handler%
  (class object%
    (super-new) 
    (init-field
     [_list-of-pressed-keys '()])

    ;; Returns list
    (define/public (get-list-of-pressed-keys) 
      _list-of-pressed-keys)

    ;; Add pressed key to list
    (define/public (add-key key)
      (unless (pressed? key)
        (set! _list-of-pressed-keys (append _list-of-pressed-keys (list key)))))

    ;; Remove pressed key from list
      (define/public (remove-key key)
        (set! _list-of-pressed-keys (remove key _list-of-pressed-keys equal?)))
    
    ;; Predicate, is key pressed?
      (define/public (pressed? key)
        (let ((pressed #f))
          (for-each (lambda (element)
                      (if (eq? element key)
                          (set! pressed #t)
                          (void)))
                    _list-of-pressed-keys)
          pressed))))

(define keyboard-list (new keyboard-handler%))