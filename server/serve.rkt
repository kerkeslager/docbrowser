#lang racket
(require racket/block
         web-server/servlet
         web-server/servlet-env)

(define (index-handler request)
  (response/full
    200
    #"OK"
    (current-seconds)
    #"text/plain"
    (list (make-header #"Content-Encoding" #"identity"))
    (list
      (string->bytes/utf-8 "Hello, world"))))

(define (link-handler request)
  (response/full
    200
    #"OK"
    (current-seconds)
    #"text/plain"
    (list (make-header #"Content-Encoding" #"identity"))
    (list
      #"Goodnight, moon\n")))

(define (not-found-handler request)
  (response/full
    404
    #"OK"
    (current-seconds)
    #"text/plain"
    (list (make-header #"Content-Encoding" #"identity"))
    (list
      #"404 File not found\n")))

(define-values (base-dispatch base-url)
  (dispatch-rules
   (("") index-handler)
   (("link") link-handler)))

(define (request-handler request)
  (base-dispatch request))

(block (display "Serving on port ") (display 8888) (display "...") (newline))

;; Start the server.
(serve/servlet
  request-handler
  #:extra-files-paths (list (simplify-path (build-path(resolved-module-path-name (variable-reference->resolved-module-path (#%variable-reference))) 'up "static/")))
  #:listen-ip "127.0.0.1"
  #:port 8888
  #:servlet-path "/"
  #:servlet-regexp #rx""
  #:command-line? #t)