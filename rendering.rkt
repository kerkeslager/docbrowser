#lang racket/gui
(provide main-renderer%)

(define main-renderer%
  (class vertical-panel%
    (init)
    (super-new)
    (define root (new message%
                      [parent this]
                      [label "No events so far..."]))
    
    (define (render document)
      (new message%
       [parent this]
       [label document]))

    (define/public (set-document document)
      (send this delete-child root)
      (set! root (render document)))))
