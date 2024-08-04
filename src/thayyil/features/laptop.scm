(define-module (thayyil features laptop)
  #:use-module (rde features)
  #:use-module (rde features bluetooth)
  #:use-module (rde features predicates)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu services pm)
  #:use-module (gnu packages linux)
  #:use-module (thayyil utils)
  #:export (feature-laptop
            feature-laptop-tlp
            feature-laptop-natural-scrolling
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

(define %thayyil-laptop-base-features
  (list
   (feature-laptop)
   (feature-laptop-tlp)))
