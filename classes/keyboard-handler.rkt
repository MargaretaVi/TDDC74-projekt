#lang racket
(provide keyboard-handler%)

(define keyboard-handler%
  (class object%

    (init-field
     
     [*list-of-keys-pressed* (make-hash)])


    (define/public (get-list-of-keys-pressed)
      (hash-keys *list-of-keys-pressed*))

    (define/public (add-key key)
      (if (hash-has-key? *list-of-keys-pressed* (string key))
          #f
          (begin
            (hash-set! *list-of-keys-pressed* (string key) key)
            #t)))

    (define/public (delete-key key)
      (if (hash-has-key? *list-of-keys-pressed*  (string key))
          (hash-remove! *list-of-keys-pressed* (string key))
          #f))

    (define/public (key-pressed? key)
      (hash-has-key? *list-of-keys-pressed* key))
    
    (super-new)))