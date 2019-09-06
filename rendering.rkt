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
              (let* ([text (hash-ref document 'text)]
                     [lines (string-split text "\n")]
                     [canvas (new canvas%
                                  [parent this]
                                  [style (list 'vscroll)]
                                  [paint-callback
                                   (lambda (canvas dc)
                                     (block
                                      (send dc set-font (make-object font% 14 'modern))
                                      (for ([i (in-naturals 0)]
                                            [line lines])
                                        (send dc draw-text line 5 (* 20 i)))))])])
                (block (send canvas init-auto-scrollbars
                             #f
                             (+ 20 (* 20 (length lines)))
                             0.0
                             0.0)
                       canvas)))

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
