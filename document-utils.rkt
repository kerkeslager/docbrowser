#lang racket
(provide
 error-document
 text-document)
         
(define (text-document text)
  (hash 'meta (hash 'source "browser"
                    'type "docbrowser/wrapped")
        'type "text/plain"
        'wrapped text))

(define (error-document message)
  (hash 'meta (hash 'source "browser"
                    'type "docbrowser/wrapped")
        'type "doc/error"
        'wrapped message))