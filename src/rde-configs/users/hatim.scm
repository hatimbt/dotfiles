(define-module (rde-configs users hatim)
  ;; General feature sets
  #:use-module (thayyil presets base)
  #:use-module (thayyil presets cli)
  #:use-module (thayyil presets desktop)
  #:use-module (thayyil presets emacs)
  #:use-module (thayyil presets devel)

  ;; Additional user features
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features keyboard)
  #:use-module (rde features security-token)
  #:use-module (rde features password-utils)
  #:use-module (rde features xdg)
  #:use-module (rde features libreoffice)

  #:use-module (rde features predicates)

  ;;strings->packages
  #:use-module (rde packages)

  #:use-module (rde features system)

  ;; For the service extensions
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (rde home services emacs)
  #:use-module (rde home services wm)

  #:use-module (guix gexp))

;; General features
(define general-features
  (append
   thayyil-base-set
   thayyil-cli-set
   thayyil-desktop-set

   thayyil-emacs-set
   thayyil-emacs-comms-set
   thayyil-emacs-research-set))

;; Include substitutes for Guix and Non-Guix
(define general-features-with-substitutes
  (append
   general-features
   (list
    (feature-base-services
     #:guix-substitute-urls (list "https://bordeaux.guix.gnu.org"
                                  "https://substitutes.nonguix.org")
     #:guix-authorized-keys (list (local-file
                                   "../../files/nonguix-signing-key.pub"))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Additional services
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define home-extra-packages-service
  (simple-service
   'home-profile-extra-packages
   home-profile-service-type
   (append
    ;; TODO Move away from strings->packages
    (strings->packages
     "curl" "make" "vim"

     ;; Utils
     "htop" "bat" "st" "wl-clipboard"

     ;; Dev Utils
     "binutils" "gdb" "just" "flatpak"
     "vscodium"

     ;; EPUB
     "calibre"

     ;; Audiobook
     "cozy"

     ;; Audiocontrol
     "pavucontrol"

     ;; Wayland Event Viewer
     "wev"

     ;; Multimedia
     "imagemagick"
     "obs" "obs-wlrobs"

     "hicolor-icon-theme" "adwaita-icon-theme" "gnome-themes-extra"
     ;; "papirus-icon-theme" ; 85k files
     "arc-theme"
     "thunar" "fd"
     ;; "glib:bin"

     "ffmpeg"))))

(define emacs-extra-packages-service
  (simple-service
   'emacs-extra-packages
   home-emacs-service-type
   (home-emacs-extension
    (init-el
     `((with-eval-after-load 'piem
         (setq piem-inboxes
               '(
                 ;;("guix-devel"
                 ;; :url "https://yhetil.org/guile-devel/"
                 ;; :address "guile-devel@gnu.org"
                 ;; :coderepo "~/work/gnu/guile/")
                 ("guix-patches"
                  :url "https://yhetil.org/guix-patches/"
                  :address "guix-patches@gnu.org"
                  :coderepo "~/src/guile/guix/")
                 ("rde-devel"
                  :url "https://lists.sr.ht/~abcdw/rde-devel"
                  :address "~abcdw/rde-devel@lists.sr.ht"
                  :coderepo "~/src/guile/rde/"))))
       (with-eval-after-load 'org
         (setq org-use-speed-commands t)
         (setq org-log-reschedule 'time)
         (define-key org-mode-map (kbd "M-o")
           (lambda ()
             (interactive)
             (org-end-of-meta-data t))))
       (with-eval-after-load 'simple
         (setq-default display-fill-column-indicator-column 80)
         (add-hook 'prog-mode-hook 'display-fill-column-indicator-mode))
       (setq copyright-names-regexp
             (format "%s <%s>" user-full-name user-mail-address))
       (add-hook 'after-save-hook (lambda () (copyright-update nil nil)))))
    (elisp-packages
     (append
      (list
       ;; (@ (rde packages emacs-xyz) emacs-corfu-candidate-overlay)
       )
      (strings->packages
       ;; "emacs-dirvish"
       "emacs-company-posframe"
       "emacs-eat"
       "emacs-wgrep"
       "emacs-piem"
       "emacs-ox-haunt"
       "emacs-org-wild-notifier"

       "emacs-haskell-mode"
       "emacs-rainbow-mode"

       "emacs-hl-todo"
       "emacs-yasnippet"
       ;; "emacs-consult-dir"
       "emacs-kind-icon"
       "emacs-nginx-mode" "emacs-yaml-mode"

       "emacs-arei"
       "emacs-multitran"
       "emacs-minimap"
       "emacs-ement"
       "emacs-restart-emacs"
       "emacs-org-present"))))))

(define sway-extra-config-service
  (simple-service
   'sway-extra-config
   home-sway-service-type
   `((bindsym $mod+Shift+o move workspace to output left)
     (bindsym $mod+Ctrl+o focus output left)
     (input type:touchpad
            ;; TODO: Move it to feature-sway or feature-mouse?
            (;; (natural_scroll enabled)
             (tap enabled)))

     ;; (xwayland disable)
     (bindsym $mod+Shift+Return exec emacs))))

;; This needs to before where it is used.
(define (feature-additional-services)
  (feature-custom-services
   #:feature-name-prefix 'hatim
   #:home-services
   (list
    emacs-extra-packages-service
    home-extra-packages-service
    sway-extra-config-service)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Features for hatim
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-public %hatim-features
  (append
   general-features-with-substitutes
   (list
    ;; Defined below
    (feature-additional-services)

    ;; User Info
    (feature-user-info
     #:user-name "hatim"
     #:full-name "Hatim Thayyil"
     #:email "hatim@thayyil.net"
     #:user-groups (list "wheel" "audio" "video"
                         "input" "lp"))

    (feature-security-token)
    ;;(feature-password-store)

    ;; Keyboard layout
    (feature-keyboard
     #:keyboard-layout
     (keyboard-layout
      "gb"
      #:options '("grp:shift_toggle" "ctrl:nocaps")))

    (feature-xdg
     #:xdg-user-directories-configuration
     (home-xdg-user-directories-configuration
      (music "$HOME")
      (videos "$HOME/vids")
      (pictures "$HOME/pics")
      ;; TODO needs to be coherent with org notes location
      (documents "$HOME/docs")
      (download "$HOME/dl")
      (desktop "$HOME")
      (publicshare "$HOME")
      (templates "$HOME")))

    (feature-libreoffice))))
