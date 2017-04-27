#lang racket
(provide keyboard-handler%)


(define keyboard-handler%
  (class object%
    ;;Members of class
    (init-field
     
     [*list-of-keys-pressed* (make-hash)])

    ;; Functions that returns the class members.
    (define/public (get-list-of-keys-pressed)
      (hash-keys *list-of-keys-pressed*))

    ;; ------------------------------------

    ;;Adds a key to the hash-table *list-of-key-pressed*.
    (define/public (add-key key)
      (if (hash-has-key? *list-of-keys-pressed* (string key))
          #f
          (begin
            (hash-set! *list-of-keys-pressed* (string key) key)
            #t)))
    
    ;;Removes a key from the hash-table *list-of-key-pressed*.
    (define/public (delete-key key)
      (if (hash-has-key? *list-of-keys-pressed*  (string key))
          (hash-remove! *list-of-keys-pressed* (string key))
          #f))

    ;;Checks if key exist in hash-table
    (define/public (key-pressed? key)
      (hash-has-key? *list-of-keys-pressed* (string key)))
    
    (super-new)))