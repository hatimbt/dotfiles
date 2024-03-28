(define-module (thayyil features terminals)
  #:use-module (rde features)
  #:use-module (rde features predicates)
  #:use-module (rde features fontutils)
  #:use-module (gnu home services)
  #:use-module (gnu home-services base)
  #:use-module (gnu home-services terminals)
  #:use-module (gnu home-services shells)
  #:use-module (gnu home-services wm)
  #:use-module (gnu services)
  #:use-module (rde packages)
  #:use-module (gnu packages terminals)
  #:use-module (guix gexp)

  #:export (feature-foot))

(define* (feature-foot
          #:key
          (foot foot)
          (default-terminal? #f)
          (backup-terminal? #t))
  "Configure foot terminal."
  (ensure-pred file-like? foot)

  (define (get-home-services config)
    (define font-mono (get-value 'font-monospace config))
    (list
     (simple-service
      'foot-package
      home-profile-service-type
      (list foot))
     ;; TODO: Migrate to home service to make it extandable
     (simple-service
      'foot-package
      home-xdg-configuration-files-service-type
      `(("foot/foot.ini"
         ,(mixed-text-file
           "foot.ini"
           "pad = 10x5\n"
           (if font-mono
               (string-append "font=monospace:size="
                              (number->string (font-size font-mono)) "\n")
               "")
           ;; "dpi-aware = yes\n" ; use dpi instead of output scaling factor
           "[main]
include = " (file-append foot "/share/foot/themes/modus-vivendi") "\n"))))))

  (feature
   (name 'foot)
   (values
    `((foot . ,foot)
      ,@(if default-terminal?
            `((default-terminal . ,(file-append foot "/bin/foot")))
            '())
      ,@(if backup-terminal?
            `((backup-terminal . ,(file-append foot "/bin/foot")))
            '())))
   (home-services-getter get-home-services)))
