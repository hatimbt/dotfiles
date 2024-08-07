(define-module (rde-configs users hatim)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features system)

  #:use-module (thayyil common))

;;;
;;; RDE configuration for tycho.
;;;
(define-public %hatim-features
  (append
   %dev-rust-features
   %emacs-base-features
   %desktop-base-features
   %base-features))
