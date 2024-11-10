(define-module (rde-configs users hatim)
  ;; Additional user features
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features containers)
  #:use-module (rde features documentation)
  #:use-module (rde features emacs)
  #:use-module (rde features emacs-xyz)
  #:use-module (rde features finance)
  #:use-module (rde features fontutils)
  #:use-module (rde features gnupg)
  #:use-module (rde features gtk)
  #:use-module (rde features guile)
  #:use-module (rde features keyboard)
  #:use-module (rde features libreoffice)
  #:use-module (rde features linux)
  #:use-module (rde features mail)
  #:use-module (rde features networking)
  #:use-module (rde features password-utils)
  #:use-module (rde features predicates)
  #:use-module (rde features security-token)
  #:use-module (rde features shells)
  #:use-module (rde features shellutils)
  #:use-module (rde features ssh)
  #:use-module (rde features system)
  #:use-module (rde features terminals)
  #:use-module (rde features tmux)
  #:use-module (rde features version-control)
  #:use-module (rde features virtualization)
  #:use-module (rde features web-browsers)
  #:use-module (rde features wm)
  #:use-module (rde features xdg)
  #:use-module (thayyil features neovim)
  #:use-module (thayyil features package-management)
  #:use-module (thayyil features rust)
  #:use-module (thayyil features tmux)
  #:use-module (thayyil features tree-sitter)

  ;;strings->packages
  #:use-module (rde packages)

  ;; For the service extensions
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (rde home services emacs)
  #:use-module (rde home services wm)

  #:use-module (guix gexp))

;;; Basic set of features
(define thayyil-base-set
  (list
   (feature-base-packages)
   (feature-desktop-services)

   ;; iwd + NetworkManager
   (feature-networking)
   (feature-backlight)
   (feature-pipewire)))

(define thayyil-cli-set
  (list
   (feature-manpages)

   ;; emacs-vterm and shell
   (feature-vterm)
   ;; From (thayyil features terminals) to have modus-vivendi as default.
   ((@ (thayyil features terminals) feature-foot))

   (feature-zsh)
   (feature-bash)

   (feature-direnv)
   (feature-ssh)

   (feature-tmux)
   (feature-tmux-catppuccin)

   (feature-guile)))

(define-public thayyil-desktop-set
  (list
   (feature-fonts)
   (feature-gtk3)

   (feature-sway
    #:xwayland? #t)
   (feature-emacs-power-menu)
   (feature-sway-run-on-tty
    #:sway-tty-number 2)
   (feature-sway-screenshot)
   (feature-swaynotificationcenter)
   (feature-waybar)
   (feature-swayidle)
   (feature-swaylock
    #:swaylock (@ (gnu packages wm) swaylock-effects)
    ;; The blur on lock screen is not privacy-friendly.
    #:extra-config '((screenshots)
                     (effect-blur . 7x5)
                     (clock)))
   (feature-batsignal)

   (feature-librewolf)
   (feature-ungoogled-chromium)
   (feature-ledger)))

(define-public thayyil-emacs-set
  (list
   (feature-emacs
    #:default-application-launcher? #t)

   ;; General
   (feature-emacs-dired)
   (feature-emacs-all-the-icons)
   (feature-emacs-eshell)
   (feature-emacs-tramp)
   (feature-emacs-help)

   ;; UI
   (feature-emacs-appearance)
   (feature-emacs-modus-themes)
   (feature-emacs-monocle)
   (feature-emacs-keycast
    #:turn-on? #t)
   (feature-emacs-time)

   ;; Completion
   (feature-emacs-completion
    #:mini-frame? #f)
   (feature-emacs-corfu)
   (feature-emacs-vertico)
   (feature-emacs-which-key)

   ;; Development
   (feature-emacs-project)
   (feature-emacs-eglot)
   (feature-emacs-smartparens
    #:show-smartparens? #t)
   (feature-emacs-git)
   (feature-emacs-geiser)
   (feature-emacs-guix)))

(define-public thayyil-emacs-comms-set
  (list
   (feature-emacs-telega)
   (feature-emacs-ebdb
    #:ebdb-sources (list "~/documents/contacts")
    #:ebdb-popup-size 0.2)))

(define-public thayyil-emacs-research-set
  (list
   ;; General Org
   (feature-emacs-org
    #:org-directory "~/org"
    #:org-capture-templates
    `(("t" "Todo" entry (file+headline "todo.org" "Tasks")
           "* TODO %?\n")))
   (feature-emacs-org-agenda
    #:org-agenda-files (list "~/org/todo.org"))

   ;; Writing
   (feature-emacs-spelling
    #:spelling-program (@ (gnu packages hunspell) hunspell)
    #:spelling-dictionaries
    (list
     (@ (gnu packages hunspell) hunspell-dict-en)
     (@ (rde packages aspell) hunspell-dict-ru)))

   ;; PKM
   (feature-emacs-denote
    #:denote-directory "~/notes")
   (feature-emacs-citation
    #:global-bibliography (list "~/library/general.bib"))

   (feature-emacs-elfeed
    #:elfeed-org-files (list "~/feeds/rss.org"))

   (feature-emacs-pdf-tools)))

(define-public thayyil-neovim-set
  (list
   (feature-neovim)

   (feature-neovim-neo-tree)
   (feature-neovim-telescope)
   (feature-neovim-cmp)
   (feature-neovim-cmp-luasnip)
   (feature-neovim-friendly-snippets)

   (feature-tree-sitter)))

(define-public thayyil-devel-rust-set
  (list
   (feature-rust)
   (feature-rust-dev)
   (feature-neovim-rust)))

(define-public thayyil-virtualisation-set
  (list
   (feature-podman)
   (feature-qemu)))

(define-public thayyil-nix-set
  (list
   (feature-nix)))

;;; EMAIL
(define msmtp-provider-settings
  (append
   `((outlook . ((host . "smtp-mail.outlook.com")
                 (port . 587))))
   %default-msmtp-provider-settings))

(define outlook-folder-mapping
  '(("inbox"   . "INBOX")
    ("sent"    . "[Outlook]/Sent Items")
    ("drafts"  . "[Outlook]/Drafts")
    ("archive" . "[Outlook]/All Mail")
    ("trash"   . "[Outlook]/Trash")
    ("spam"    . "[Outlook]/Spam")))

(define outlook-isync-settings
  (generate-isync-serializer "outlook.office365.com" outlook-folder-mapping))

(define isync-serializers
  (append
   `((outlook . ,outlook-isync-settings))
   %default-isync-serializers))

(define-public thayyil-email-set
  (list
   (feature-isync
    #:isync-serializers isync-serializers)
   (feature-l2md)
   (feature-msmtp
    #:msmtp-provider-settings msmtp-provider-settings)))

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

     ;; Going to maintain a local copy of beancount.
     ;;"beancount"

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
       "emacs-racket-mode"
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
