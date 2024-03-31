(define-module (thayyil features keyboard)
  #:use-module (rde features)
  #:use-module (gnu services)
  #:use-module (gnu home services)

  #:use-module (guix gexp)

  #:use-module (gnu packages linux)

  #:export (feature-dual-function-keys))

(define* (feature-dual-function-keys
          #:key
          (dev-node #f))
  "Install and setup Interception Dual Function Keys."
  (ensure-pred string? dev-node)

  (define (get-home-services config)
    "Return a list of home services required for Interception Dual Function
Keys"
    (list
     (simple-service
      'add-interception-dual-function-keys-home-packages-to-profile
      home-profile-service-type
      (list
       interception-tools
       interception-dual-function-keys))
     (simple-service
      'add-dev-node-env-vars-service
      home-environment-variables-service-type
      `(("DEVNODE" . ,(string-append "/dev/input/" dev-node))))
     (simple-service
      'add-interception-xdg-configuration-files-service
      home-xdg-configuration-files-service-type
      `(("interception" ,(local-file "../../files/interception" #:recursive? #t))))))

  (feature
   (name 'double-function-keys)
   (home-services-getter get-home-services)))
