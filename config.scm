(define-module (config)
  #:use-module (rde features)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match)

  #:use-module (thayyil systems tycho))

(define tycho-he
  (rde-config-home-environment tycho-config))

(define tycho-os
  (rde-config-operating-system tycho-config))

(define (dispatcher)
  (let ((target (getenv "TARGET")))
    (match target
      ("tycho-home" tycho-he)
      ("tycho-system" tycho-os)
      (_ tycho-he))))

(dispatcher)
