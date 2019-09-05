#lang racket
(provide get-document)

(require net/url
         "document-utils.rkt")

(define (get-document-from-file url)
  (text-document "file"))

(define (get-document-over-http url)
  (text-document "http or https"))

(define (get-document address)
  (let ([url (string->url address)])
    (cond [(equal? "file" (url-scheme url)) (get-document-from-file url)]
          [(or (equal? "http" (url-scheme url)) (equal? "https" (url-scheme url))) (get-document-over-http url)]
          [else (error-document "failure")])))