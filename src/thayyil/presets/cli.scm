(define-module (thayyil presets cli)
  #:use-module (rde features documentation)
  #:use-module (rde features terminals)
  #:use-module (rde features shells)
  #:use-module (rde features shellutils)
  #:use-module (rde features version-control)
  #:use-module (rde features ssh)
  #:use-module (rde features tmux)
  #:use-module (thayyil features tmux)
  #:use-module (rde features guile))

(define-public thayyil-cli-set
  (list
   (feature-manpages)

   ;; emacs-vterm and shell
   (feature-vterm)
   ;; From (thayyil features terminals) to have modus-vivendi as default.
   ((@ (thayyil features terminals) feature-foot))

   (feature-zsh)
   (feature-bash)

   (feature-direnv)
   ;; TODO Provide a correct `git-sign-key` or a `gpg-primary-key`
   (feature-git
    #:sign-commits? #f)
   (feature-ssh)

   (feature-tmux)
   (feature-tmux-catppuccin)

   (feature-guile)))
