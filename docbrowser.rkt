#lang racket/gui

(require
  racket/gui/base
  racket/block
  "rendering.rkt")

(define (get-document url)
  url)

(define url-manager%
  (class object%
    (init home on-url-change-callback)
    (define past '())
    (define present home)
    (define future '())
    (define on-url-change on-url-change-callback)
    (super-new)

    (define/public (go-back)
      (if (empty? past)
          #f
          (block
           (set! future (cons present future))
           (set! present (car past))
           (set! past (cdr past))
           (on-url-change present))))

    (define/public (go-forward)
      (if (empty? future)
          #f
          (block
           (set! past (cons present past))
           (set! present (car future))
           (set! future (cdr future))
           (on-url-change present))))

    (define/public (set-url url)
      (set! past (cons present past))
      (set! present url)
      (set! future '())
      (on-url-change present))))

(define control-panel%
  (class horizontal-panel%
    (init on-back on-forward on-set-url)
    (super-new)
    (new button%
     [parent this]
     [label "Back"]
     [callback (lambda (button event) (on-back))])
    (new button%
     [parent this]
     [label "Forward"]
     [callback (lambda (button event) (on-forward))])

    (define url-text-field (new text-field%
     [parent this]
     [label ""]
     [callback (lambda (text-field event)
                 (if (eq? (send event get-event-type) 'text-field-enter)
                     (on-set-url (send text-field get-value))
                     #f))]))

    (define/public (set-url url)
      (send url-text-field set-value url))))



(define main-frame%
  (class frame%
    (init)
    (super-new
     [label "Doc Browser"]
     [min-width 600]
     [alignment (list 'center 'top)])

    (define url-manager (new url-manager%
       [home "Home"]
       [on-url-change-callback (lambda (url)
                                 (send control-panel set-url url)
                                 (send renderer set-document (get-document url)))]))

    (define control-panel (new control-panel%
       [parent this]
       [on-back (lambda ()
                 (send url-manager go-back))]
       [on-forward (lambda ()
                 (send url-manager go-forward))]
       [on-set-url (lambda (url)
                     (send url-manager set-url url))]))
    
    (define renderer (new main-renderer%
                          [parent this]))))

(define main-frame (new main-frame%))

; Show the frame by calling its show method
(send main-frame maximize #t)
(send main-frame show #t)