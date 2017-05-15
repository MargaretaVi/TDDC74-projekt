#lang racket/gui
(provide keyboard-handler% keyboard-list)

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