(define-module (thayyil features laptop)
  #:use-module (rde features)
  #:use-module (rde features bluetooth)
  #:use-module (rde features predicates)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu services pm)
  #:use-module (gnu packages linux)
  #:use-module (dwl-guile utils)
  #:use-module (dwl-guile patches)
  #:use-module (dwl-guile home-service)
  #:use-module (dtao-guile home-service)
  #:use-module (thayyil utils)
  #:export (
            feature-laptop
            feature-laptop-tlp
            feature-laptop-monitor-brightness
            %thayyil-laptop-base-features))

(define* (feature-laptop)
  "Base laptop feature."

  (feature
   (name 'laptop)
   (values `((laptop . #t)))))

(define* (feature-laptop-tlp
          #:key
          (tlp-config (tlp-configuration
                       (cpu-scaling-governor-on-ac (list "performance"))
                       (sched-powersave-on-bat? #t))))
  "Setup TLP for power management on laptops."

  (define (get-system-services config)
    "Return a list of system services required by TLP"
    (list
     (simple-service
      'add-tlp-system-packages-to-profile
      profile-service-type
      (list tlp))
     (service tlp-service-type
              tlp-config)))

  (feature
   (name 'laptop-tlp)
   (system-services-getter get-system-services)))

(define* (feature-laptop-monitor-brightness
          #:key
          (step 10)
          (decrease-brightness-key "<XF86MonBrightnessDown>")
          (increase-brightness-key "<XF86MonBrightnessUp>")
          (add-keybindings? #t))
  "Install and configure brightnessctl for laptops"

  (ensure-pred number? step)
  (ensure-pred string? decrease-brightness-key)
  (ensure-pred string? increase-brightness-key)
  (ensure-pred boolean? add-keybindings?)

  (define (get-home-services config)
    (make-service-list
     (simple-service
      'add-brightnessctl-home-packages-to-profile
      home-profile-service-type
      (list brightnessctl))
     (when (and add-keybindings?
                (get-value 'dwl-guile config))
       (let ((bin (file-append brightnessctl "/bin/brightnessctl"))
             (change (string-append (number->string step) "%")))
         (simple-service
          'add-dwl-guile-brightness-keys
          home-dwl-guile-service-type
          `((set-keys ,decrease-brightness-key
                      (lambda () (dwl:shcmd ,bin "s" ,(string-append change "-")))
                      ,increase-brightness-key
                      (lambda () (dwl:shcmd ,bin "s" ,(string-append "+" change))))))))))

  (feature
   (name 'laptop-monitor-brightness)
   (home-services-getter get-home-services)))

(define %thayyil-laptop-base-features
  (list
   (feature-laptop)
   (feature-laptop-tlp)
   (feature-laptop-monitor-brightness)))
