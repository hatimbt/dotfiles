(define-module (rde-configs minimal)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features shells))


;;; Code:

(define minimal-rde-config
  (rde-config
   (features
    (list
     (feature-user-info
      #:user-name "hatim"
      #:full-name "Hatim Thayyil"
      #:email "hatim@thayyil.net")
     (feature-zsh)))))

(rde-config-home-environment minimal-rde-config)
