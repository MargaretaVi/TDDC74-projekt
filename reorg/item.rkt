#lang racket/gui
(require "object.rkt")
(provide health-boost% speed-boost% player-projectile%  enemy-projectile% boss-projectile% DMG-boost%)


;; ----- power ups ------
(define health-boost% 
  (class game-object%
    (super-new)
    (inherit set-height set-width set-value)

    ;; health-power-up bitmap
    (define health-bitmap (read-bitmap "../images/health-img.png"))

    
    (set-height (send health-bitmap get-height))
    (set-width (send health-bitmap get-width))
    (set-value 5)))

; -------

(define speed-boost%
  (class game-object%
    (super-new)
    (inherit set-height set-width set-value)

    ;; speed-power-up bitmap
    (define speed-bitmap (read-bitmap "../images/speed.png"))
    (set-height (send speed-bitmap get-height))
    (set-width (send speed-bitmap get-width))
    (set-value 5)))

; -------

(define DMG-boost%
  (class game-object%
    (super-new)
    (inherit set-height set-width set-value)

    ;; DMG-power-up bitmap
    (define DMG-bitmap (read-bitmap "../images/dmg.png"))
    (set-height (send DMG-bitmap get-height))
    (set-width (send DMG-bitmap get-width))
    (set-value 5)))


;; --- Projectiles -------
(define player-projectile%
  (class game-object%
    (super-new)
    (inherit set-height set-width set-value)

    ;; projectile bitmap
    (define normal-projectile-bitmap
      (read-bitmap "../images/normal-proj.bmp"))

        
    (define better-projectile-bitmap
      (read-bitmap "../images/better-proj.png"))
    
    (set-height (send normal-projectile-bitmap get-height))
    (set-width (send normal-projectile-bitmap get-width))
    (set-value 5)))

; -------

(define enemy-projectile%
  (class game-object%
    (super-new)
    (inherit set-height set-width set-value)

        
    (define enemie-projectile-bitmap
      (read-bitmap "../images/enemie-proj.png"))

    (set-height (send enemie-projectile-bitmap get-height))
    (set-width (send enemie-projectile-bitmap get-width))
    (set-value 5)))

; -------

(define boss-projectile%
  (class game-object%
    (super-new)
    (inherit set-height set-width set-value)

        
    (define boss-projectile-bitmap
      (read-bitmap "../images/boss-proj.png"))

    (set-height (send boss-projectile-bitmap get-height))
    (set-width (send boss-projectile-bitmap get-width))
    (set-value 5)))

; -------

;; Miscellanous

(define asteroid%
  (class game-object%
    (super-new)
    (inherit set-height set-width set-value)

    ;; asteroid bitmap
    (define asteroid-bitmap (read-bitmap "../images/asteroid.bmp"))
    (set-height (send asteroid-bitmap get-height))
    (set-width (send asteroid-bitmap get-width))
    (set-value 5)))
    




