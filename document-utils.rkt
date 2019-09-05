#lang racket
(provide
 error-document
 text-document)
         
(define (text-document text)
  (hash 'meta (hash 'source "browser"
                    'type "docbrowser/wrapped/text/plain")
        'text text))

(define (error-document message)
  (hash 'meta (hash 'source "browser"
                    'type "docbrowser/error")
        'message message))