(define-module (thayyil features dwl-guile)
  #:use-module (rde features)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (dwl-guile utils)
  #:use-module (dwl-guile patches)
  #:use-module (dwl-guile home-service)
  #:export (
            feature-dwl-guile
            feature-dwl-guile-custom-config

            has-dwl-patch?
            %thayyil-dwl-guile-patches))

;; Checks if SYMBOL corresponds to a patch that is/will
;; be applied to dwl-guile, based on the feature values in CONFIG.
;; SYMBOL should be the name of the patch, not including the ".patch" extension.
;; I.e. @code{(has-dwl-patch? 'xwayland config)}.
(define (has-dwl-patch? symbol config)
  (let ((patch-name (string-append (symbol->string symbol) ".patch")))
    (find (lambda (p) (equal? patch-name (local-file-name p)))
          (get-value 'dwl-guile-patches config))))

(define %thayyil-dwl-guile-patches
  (list %patch-xwayland
        %patch-swallow
        %patch-movestack
        %patch-attachabove
        %patch-focusmonpointer
        %patch-monitor-config))

(define* (feature-dwl-guile
          #:key
          (repl? #t)
          (repl-key "s-S-C-i"))
  "Setup dwl-guile."

  (ensure-pred boolean? repl?)
  (ensure-pred string? repl-key)

    (define (get-home-services config)
      "Return a list of home services required by dwl-guile."
      (list
       (service home-dwl-guile-service-type
                (home-dwl-guile-configuration
                 (package
                  (patch-dwl-guile-package dwl-guile
                                           #:patches %thayyil-dwl-guile-patches))
                 (config
                  (list
                   '((set-xkb-rules '((model . "thinkpad")
					      (layout . "gb"))))))))))

    (feature
     (name 'wayland-dwl-guile)
     (values `((wayland . #t)
               (dwl-guile . #t)
               (dwl-guile-patches . ,%thayyil-dwl-guile-patches)))
     (home-services-getter get-home-services)))

(define* (feature-dwl-guile-custom-config
          #:key
          (name 'dwl-guile-custom-config)
          (config '()))
  "Personal customization overrides to your dwl-guile configuration."

  (ensure-pred symbol? name)
  (ensure-pred list? config)

  (define (get-home-services _)
    (list
     (simple-service
      name
      home-dwl-guile-service-type
      config)))

  (feature
   (name name)
   (home-services-getter get-home-services)))
