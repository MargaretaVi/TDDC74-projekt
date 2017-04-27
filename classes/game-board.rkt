#lang racket
(define game-board%
  (class object%
    (init-field
     [_width 1000]
     [_height 1000]
     [*list-of-characters* (make-hash)])

    (define/public (get-width)
      _width)

    (define/public (get-height)
      _height)
    
    (define/public (get-list-of-charcters)
      (hash-keys *list-of-characters*))

    (define/public (add-character-to-list character)
      (if (hash-has-key? *list-of-characters* (send character get-name))
          #f
          (begin
            (hash-set! *list-of-characters* (send character get-name) character)
            #t)))

    (define/public (delete-characters-from-list-of-characters character)
      (if (hash-has-key? *list-of-characters*  (send character get-name))
          (hash-remove! *list-of-characters* (send character get-name))
          #f))


    (super-new)))