(define-module (thayyil presets desktop)
  #:use-module (rde features fontutils)
  #:use-module (rde features gtk)
  #:use-module (rde features wm)
  #:use-module (rde features emacs-xyz)
  #:use-module (rde features web-browsers))

(define-public thayyil-desktop-set
  (list
   (feature-fonts)
   (feature-gtk3)

   (feature-sway
    #:xwayland? #t)
   (feature-emacs-power-menu)
   (feature-sway-run-on-tty
    #:sway-tty-number 2)
   (feature-sway-screenshot)
   (feature-swaynotificationcenter)
   (feature-waybar)
   (feature-swayidle)
   (feature-swaylock
    #:swaylock (@ (gnu packages wm) swaylock-effects)
    ;; The blur on lock screen is not privacy-friendly.
    #:extra-config '((screenshots)
                     (effect-blur . 7x5)
                     (clock)))
   (feature-batsignal)

   (feature-librewolf)
   (feature-ungoogled-chromium)))
