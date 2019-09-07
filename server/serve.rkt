#lang racket
(require racket/block
         web-server/servlet
         web-server/servlet-env)

;; Returns a HTTP response given a HTTP request.
(define (request-handler request)
  (response/full
    200                  ; HTTP response code.
    #"OK"                ; HTTP response message.
    (current-seconds)    ; Timestamp.
    #"text/plain"        ; MIME type for content.
    '()                  ; Additional HTTP headers.
    (list                ; Content (in bytes) to send to the browser.
      #"Hello, world\n"
      #"Goodnight, moon\n")))

(block (display "Serving on port ") (display 8888) (display "...") (newline))

;; Start the server.
(serve/servlet
  request-handler
  #:listen-ip "127.0.0.1"
  #:port 8888
  #:servlet-path "/"
  #:command-line? #t)