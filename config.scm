(define-module (config)
  #:use-module (rde features)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match)

  #:use-module (thayyil systems tycho)
  #:use-module (thayyil systems debes)
  #:use-module (thayyil systems wsl))

(define tycho-he
  (rde-config-home-environment tycho-config))

(define tycho-os
  (rde-config-operating-system tycho-config))

(define wsl-he
  (rde-config-home-environment wsl-config))

(define debes-he
  (rde-config-home-environment debes-config))

(define (dispatcher)
  (let ((target (getenv "TARGET")))
    (match target
      ("tycho-home" tycho-he)
      ("tycho-system" tycho-os)
      ("gnu-home" wsl-he)
      ("SSL440M-home" debes-he)
      (_ tycho-he))))

(dispatcher)
