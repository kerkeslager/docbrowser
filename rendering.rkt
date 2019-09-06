#lang racket/gui
(provide main-renderer%)

(require
  "document-utils.rkt")

(define main-renderer%
  (class vertical-panel%
    (init)
    (super-new
     [style (list 'auto-vscroll)])
    (define root (new message%
                      [parent this]
                      [label "No events so far..."]))

    (define (render-text document)
      (new canvas%
           [parent this]
           [paint-callback
            (lambda (canvas dc)
              (send dc draw-text (hash-ref document 'text) 0 0))]))

    (define (render-error document)
      (new message%
           [parent this]
           [label (hash-ref document 'message)]))
    
    (define (render document)
      (case (hash-ref (hash-ref document 'meta) 'type)
        [("docbrowser/wrapped/text/plain") (render-text document)]
        [("docbrowser/error") (render-error document)]
        [else (render-error (error-document "Unsupported mime type"))]))

    (define/public (set-document document)
      (send this delete-child root)
      (set! root (render document)))))
