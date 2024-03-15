(define-module (thayyil features audio)
  #:use-module (rde features)
  #:use-module (rde features predicates)
  #:use-module (guix gexp)
  #:use-module (srfi srfi-1)
  #:use-module (gnu services)
  #:use-module (gnu packages pulseaudio)
  #:use-module (thayyil utils)
  #:use-module (gnu home services)
  #:use-module (dwl-guile home-service)
  #:export (feature-pulseaudio-control))


(define* (feature-pulseaudio-control
          #:key
          (step 5)
          (increase-volume-key "<XF86AudioRaiseVolume>")
          (decrease-volume-key "<XF86AudioLowerVolume>")
          (mute-volume-key "<XF86AudioMute>")
          (add-keybindings? #t))
  "Install and configure pamixer and add wm keybindings for Pulseaudio control."

  (ensure-pred number? step)
  (ensure-pred string? increase-volume-key)
  (ensure-pred string? decrease-volume-key)
  (ensure-pred string? mute-volume-key)
  (ensure-pred boolean? add-keybindings?)

  (define command (file-append pamixer "/bin/pamixer"))

  (define (get-home-services config)
    (make-service-list
     (simple-service
      'add-pulseaudio-control-home-packages-to-profile
      home-profile-service-type
      (list pamixer))
     (when (and add-keybindings? (get-value 'dwl-guile config))
       (simple-service
        'add-pamixer-dwl-keybindingspulseaudio
        home-dwl-guile-service-type
        `((set-keys ,increase-volume-key
                    (lambda ()
                      (dwl:shcmd ,command
                                 "--unmute"
                                 "--increase" ,(number->string step)))
                    ,decrease-volume-key
                    (lambda ()
                      (dwl:shcmd ,command
                                 "--unmute"
                                 "--decrease" ,(number->string step)))
                    ,mute-volume-key
                    (lambda () (dwl:shcmd ,command "--toggle-mute"))))))))

  (feature
   (name 'pulseaudio-control)
   (home-services-getter get-home-services)))
