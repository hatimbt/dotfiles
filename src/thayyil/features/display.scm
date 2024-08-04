(define-module (thayyil features display)
  #:use-module (ice-9 format)
  #:use-module (guix gexp)
  #:use-module (srfi srfi-1)
  #:use-module (rde features)
  #:use-module (rde features predicates)
  #:use-module (rde system services accounts)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages hardware)
  #:use-module (gnu packages linux)
  #:use-module (thayyil utils)
  #:export (feature-display-control
            feature-kanshi-autorandr))

;; TODO Need to add keybindings for sway.
(define* (feature-display-control
          #:key
          (step-brightness 10)
          (increase-brightness-key "<XF86MonBrightnessUp>")
          (decrease-brightness-key "<XF86MonBrightnessDown>")
          (add-keybindings? #t))

  (define (get-system-services _)
    (list
     (simple-service
      'ddcutil-add-i2c-group-to-user
      rde-account-service-type
      (list "i2c"))
     (udev-rules-service
      'ddcutil-add-udev-rules-group
      ddcutil
      #:groups '("i2c"))))

  (define command (file-append ddcutil "/bin/ddcutil"))

  (define (get-home-services config)
    "Return a list of home services required by ddcutil."
    (let ((has-dwl-guile? (get-value 'dwl-guile config)))
      (list
       (simple-service
        'add-ddcutil-home-package-to-profile
        home-profile-service-type
        (list ddcutil)))))

  (feature
   (name 'display-control)
   (home-services-getter get-home-services)
   (system-services-getter get-system-services)))
