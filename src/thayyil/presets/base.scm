(define-module (thayyil presets base)
  #:use-module (rde features base)
  #:use-module (rde features networking)
  #:use-module (rde features linux))

(define-public thayyil-base-set
  (list
   (feature-base-packages)
   (feature-desktop-services)

   ;; iwd + NetworkManager
   (feature-networking)
   (feature-backlight)
   (feature-pipewire)))
