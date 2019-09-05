#lang racket
(provide get-document)

(require net/url)

(define (get-document-from-file url)
  "file")

(define (get-document-over-http url)
  "http or https")

(define (get-document address)
  (let ([url (string->url address)])
    (cond [(equal? "file" (url-scheme url)) (get-document-from-file url)]
          [(or (equal? "http" (url-scheme url)) (equal? "https" (url-scheme url))) (get-document-over-http url)]
          [else "failure"])))