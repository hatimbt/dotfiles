(define-module (thayyil features tmux)
  #:use-module (rde features)
  #:use-module (rde features predicates)

  #:use-module (gnu services)
  #:use-module (gnu home services)

  #:use-module (thayyil utils)
  #:use-module (thayyil packages tmux)

  #:export (feature-tmux-catppuccin))

(define* (feature-tmux-catppuccin)
  "Install and setup Neovim."

  (define (get-home-services config)
    "Return a list of home services needed for the Tmux Catppuccin theme."
    (list
     (simple-service
      'add-tmux-catppuccing-home-packages-to-profile
      home-profile-service-type
      (list tmux-catppuccin))))

  (feature
   (name 'tmux-catppuccin)
   (home-services-getter get-home-services)))
