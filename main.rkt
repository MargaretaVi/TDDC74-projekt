#lang racket/gui
(require "graphics.rkt")
(require "classes/key-handler.rkt")
(require "classes/characters.rkt")
(require "classes/items.rkt")
(require "classes/game-board.rkt")
(require "classes/player.rkt")
(require "classes/enemie.rkt")



(define *character* (new character% [_height 1] [_width 1])) 
;;init game canvas
(define *canvas* (new game-canvas%
                      [parent *game-window*]
                      ;;--- comment out when fixed keyboard handler
                      [keyboard-handler key-fnc]
                      [paint-callback drawing-proc]))



