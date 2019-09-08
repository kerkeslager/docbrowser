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
      #"Hello, world\n")))

(define (link-handler request)
  (response/full
    200
    #"OK"
    (current-seconds)
    #"text/plain"
    (list (make-header #"Content-Encoding" #"identity"))
    (list
      #"Goodnight, moon\n")))

(define-values (base-dispatch base-url)
  (dispatch-rules
   (("") index-handler)
   (("link") link-handler)
   (else index-handler)))

(define (request-handler request)
  (base-dispatch request))

(block (display "Serving on port ") (display 8888) (display "...") (newline))

;; Start the server.
(serve/servlet
  request-handler
  #:listen-ip "127.0.0.1"
  #:port 8888
  #:servlet-path "/"
  #:servlet-regexp #rx""
  #:command-line? #t)