#lang racket/gui
(require "graphics.rkt")
(require "classes/key-handler.rkt")
(require "classes/characters.rkt")
(require "classes/items.rkt")
(require "classes/game-board.rkt")
(require "classes/player.rkt")
(require "classes/enemie.rkt")

;; Add player to list
(send game-board add-player player)
