#lang racket
(provide collision?)
(define (collision? object1 object2)
  (let ((x1-pos (send object1 get-x-pos)) (y1-pos (send object1 get-y-pos))
        (width1 (send object1 get-width)) (height1 (send object1 get-height))
        (x2-pos (send object2 get-x-pos)) (y2-pos (send object2 get-y-pos))
        (width2 (send object2 get-width)) (height2 (send object2 get-height)))
                                          
    (equal? (and (< x1-pos (+ x2-pos width2)) (> (+ x1-pos width1) x2-pos)
             (< y1-pos (+ y2-pos height2)) (> (+ height1 y1-pos) y2-pos))
            #t)))
      
#|

if (rect1.x < rect2.x + rect2.width &&
   rect1.x + rect1.width > rect2.x &&
   rect1.y < rect2.y + rect2.height &&
   rect1.height + rect1.y > rect2.y) {
    // collision detected!
}
|#