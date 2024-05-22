(define-module (thayyil systems debes)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features system)

  #:use-module (rde packages)

  #:use-module (thayyil common))

;;;
;;; Debse home packages
;;;
(define debes-home-packages
  '())

;;;
;;; Base home packages
;;;
(define-public %debes-base-home-packages
  (append
   (strings->packages
    "git" "curl" "vim" "make"

    ;; Utils
    "htop" "bat")))

;;;
;;; Host features
;;;
(define debes-features
  (list
   ;; Host info
   (feature-host-info
    #:host-name "SSL440M"
    #:timezone  "Europe/London"
    #:locale "en_GB.utf8")

   ;; Packages
   (feature-base-packages
    #:home-packages
    (append debes-home-packages
            %debes-base-home-packages))))

;;;
;;; RDE configuration for debes.
;;;
(define-public debes-config
  (rde-config
   (features (append
	      debes-features
	      %base-features
          %emacs-base-features
          %dev-rust-features))))
