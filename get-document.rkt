#lang racket
(provide get-document)

(require net/url
         racket/string
         "document-utils.rkt")

; TODO Make this Windows-compatible
(define (path-join path-params)
  (string-join (map path/param-path path-params)
               "/"
               #:before-first "/"))

(define (read-file->string path)
  (call-with-input-file path
      port->string
      #:mode 'text))

(define (get-file-from-disk path)
  (text-document (read-file->string path)))

(define (get-directory-from-disk path-string)
  (text-document "directory"))

(define (get-document-from-disk u)
  (if (url-path-absolute? u)
      (let ([path-string (path-join (url-path u))])
        (cond [(file-exists? path-string) (get-file-from-disk path-string)]
              [(directory-exists? path-string) (get-directory-from-disk path-string)]
              [else (error-document "file not fount")]))
      (error-document "file:// paths must be absolute")))

(define (get-document-over-http u)
  (text-document "http or https"))

(define (get-document address)
  (let ([u (string->url address)])
    (cond [(equal? "file" (url-scheme u)) (get-document-from-disk u)]
          [(or (equal? "http" (url-scheme u)) (equal? "https" (url-scheme u))) (get-document-over-http u)]
          [else (error-document "failure")])))