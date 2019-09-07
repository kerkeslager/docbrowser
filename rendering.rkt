#lang racket/gui
(provide main-renderer%)

(require
  racket/block
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
      (let* ([text-string (hash-ref document 'wrapped)]
             [canvas (new editor-canvas% [parent this])]
             [text (new text%)])
        (block (send text change-style (make-object style-delta% 'change-size 14))
               (send text change-style (make-object style-delta% 'change-family 'modern))
               (send text insert text-string)
               (send text lock #t)
               (send canvas set-editor text)
               canvas)))

    (define (render-error document)
      (new message%
           [parent this]
           [label (hash-ref document 'wrapped)]))
    
    (define (render document)
      (case (hash-ref document 'type)
        [("doc/error") (render-error document)]
        [("text/plain") (render-text document)]
        [else (render-error (error-document "Unsupported mime type"))]))

    (define/public (set-document document)
      (send this delete-child root)
      (set! root (render document)))))
