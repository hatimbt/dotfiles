(define-module (rde-configs users hatim)
  ;; General feature sets
  #:use-module (thayyil presets base)
  #:use-module (thayyil presets cli)
  #:use-module (thayyil presets desktop)
  #:use-module (thayyil presets emacs)
  #:use-module (thayyil presets devel)
  #:use-module (thayyil presets mail)

  ;; Additional user features
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features keyboard)
  #:use-module (rde features gnupg)
  #:use-module (rde features security-token)
  #:use-module (rde features password-utils)
  #:use-module (rde features xdg)
  #:use-module (rde features libreoffice)
  #:use-module (rde features version-control)
  #:use-module (rde features mail)

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
   thayyil-emacs-research-set
   thayyil-email-set

   thayyil-neovim-set
   thayyil-virtualisation-set

   ;; Currently rust toolchain is installed to home-profile. In the future,
   ;; this should be setup per-project.
   thayyil-devel-rust-set

   ;; Has to come after (feature-sway)
   thayyil-nix-set))

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
     ;;"vscodium"

     ;; EPUB
     "calibre"

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

     "beancount"

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

       ;; Disable automatically enabling geiser-mode. For easier use of arei
       (with-eval-after-load 'geiser-mode
         (setq geiser-mode-auto-p nil)
         (defun abcdw-geiser-connect ()
           (interactive)
           (geiser-connect 'guile "localhost" "37146"))

         (define-key geiser-mode-map (kbd "C-c M-j") 'abcdw-geiser-connect))

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

       "emacs-beancount"

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

(define xdg-config-files-service
  (simple-service
   'custom-xdg-dotfiles
   home-xdg-configuration-files-service-type
   `(("tmux", (local-file "../../files/tmux" #:recursive? #t))
     ("nvim", (local-file "../../files/nvim" #:recursive? #t)))))

;; This needs to before where it is used.
(define (feature-additional-services)
  (feature-custom-services
   #:feature-name-prefix 'hatim
   #:home-services
   (list
    emacs-extra-packages-service
    home-extra-packages-service
    xdg-config-files-service
    sway-extra-config-service)))

(define git-extra-config
  (list
   `(init ((default-branch . "main")))
   ;;`(merge ((tool . "vimdiff")))
   `(fetch ((prune . #t)))
   `(push ((default . "current")))
   ;; Use --no-autostash to disable this
   `(rebase ((autoStash . #t)))
   `(filter "lfs"
            ((required . #t)
             (clean . "git-lfs clean -- %f")
             (smudge . "git-lfs smudge -- %f")
             (process . "git-lfs filter-process")))
   `(alias
     ( ;; Logs
      (l . "log --decorate --graph --oneline -20")
      (ll . "log --decorate --graph --oneline")
      (lr . "log --reverse --decorate --oneline")
      (rl . "reflog -20")
      (rll . "reflog")
      (la . "log --all --decorate --graph --oneline")
      (in . "log --all --decorate --graph --oneline origin/master ^master")
      (out . "log --all --decorate --graph --oneline master ^origin/master")

      ;; Diffs
      (d . "diff")
      (dc . "diff --word-diff --color-words")

      ;; Staging/Unstaging files
      ;; Staging/Unstaging files
      (a . "add")
      (aa . "add --all")
      (ap . "add -p")
      (r . "reset")
      (rp . "reset -p")
      (rh . "reset --hard")
      (s . "status -sb")
      (unstage . "reset")
      (undo . "revert")

      ;; Commit
      (c . "commit --verbose")
      (ca . "commit --amend --verbose")
      (amend . "commit --amend --verbose")

      ;; Branches
      (b . "branch")
      (co . "checkout")
      (cob . "checkout -b")
      (cp . "checkout -p") ;; choose hunks from diff between index and working copy

      ;; Commit Merges
      (m . "merge")
      (mf . "merge --ff-only")
      (mn . "merge --no-ff")

      ;; Commit Rebase
      (rb . "rebase")
      (rba . "rebase --abort")
      (rbc . "rebase --continue")
      (rbi . "rebase -i")

      ;; Remote management
      (ps . "push")
      (pl . "pull")))))

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

    (feature-gnupg
     #:gpg-primary-key "FC1E295A31A0525CC7EE64C05878E5FE49C010EA")

    (feature-security-token)
    (feature-password-store)

    (feature-mail-settings
     #:mail-directory-fn (const "/home/hatim/mail")
     #:mail-accounts (list
                      (mail-account
                       (id 'gmail)
                       (type 'gmail)
                       (fqda "hatimbt@gmail.com")
                       (pass-cmd "pass show mail/gmail"))
                      (mail-account
                       (id 'personal)
                       (type 'outlook)
                       (fqda "hatim@thayyil.net")
                       (pass-cmd "pass show mail/thayyil"))))

    (feature-notmuch)

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

    (feature-git
     #:sign-commits? #f
     #:extra-config git-extra-config)

    (feature-libreoffice))))
