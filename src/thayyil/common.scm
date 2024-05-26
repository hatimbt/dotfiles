(define-module (thayyil common)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features ssh)
  #:use-module (rde features keyboard)
  #:use-module (rde features shells)
  #:use-module (rde features linux)
  #:use-module (rde features shellutils)
  #:use-module (rde features wm)
  #:use-module (rde features emacs)
  #:use-module (rde features emacs-xyz)
  #:use-module (contrib features emacs-xyz)
  #:use-module (rde features tmux)

  ;; Fonts
  #:use-module (rde features fontutils)
  #:use-module (rde packages fonts)

  #:use-module (rde packages)

  #:use-module (thayyil features networking)

  #:use-module (thayyil features shells)
  #:use-module (thayyil features terminals)
  #:use-module (thayyil features dwl-guile)
  #:use-module (thayyil features dtao-guile)
  #:use-module (thayyil features laptop)
  #:use-module (thayyil features audio)
  #:use-module (thayyil packages vim)
  #:use-module (thayyil features neovim)
  #:use-module (thayyil features rust)
  #:use-module (thayyil features tree-sitter)
  #:use-module (thayyil features keyboard)
  #:use-module (thayyil features tmux)

  #:use-module (gnu services)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages version-control)

  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)

  #:use-module (gnu home services)
  #:use-module (gnu home services shells)

  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)

  #:use-module (guix gexp)
  #:export(%base-home-packages))

;;;
;;; Base features
;;;
(define-public %base-features
  (list
   ;; User info
   (feature-user-info
    #:user-name "hatim"
    #:full-name "Hatim Thayyil"
    #:email "hatim@thayyil.net"
    #:user-groups (list "wheel" "audio" "video"
                        "input" "lp"))

   ;; Keyboard layout
   (feature-keyboard
    #:keyboard-layout
    (keyboard-layout
     "gb"
     #:options '("ctrl:nocaps")))
   (feature-dual-function-keys
    #:dev-node "by-path/platform-i8042-serio-0-event-kbd")

   ;; Networking
   (feature-networking)

   ;; Services
   (feature-base-services
    #:guix-substitute-urls (list "https://bordeaux.guix.gnu.org"
                                 "https://substitutes.nonguix.org")
    #:guix-authorized-keys (list (local-file "../files/nonguix-signing-key.pub")))

   ;; SSH
   (feature-ssh)

   ;; Shell
   (feature-bash)
   (feature-zsh)
   (feature-direnv)

   ;; Tmux
   (feature-tmux)
   (feature-tmux-catppuccin)

   ;; Editor
   (feature-neovim)

   ;; Services
   (feature-custom-services
    #:home-services
    (list
     (service home-xdg-configuration-files-service-type
	      `(("git/config", (local-file "../files/git/config"))
		("tmux", (local-file "../files/tmux" #:recursive? #t))
		("nvim", (local-file "../files/nvim" #:recursive? #t))))))))

;;;
;;; Desktop features
;;;
(define-public %desktop-base-features
  (list
   (feature-desktop-services)
   (feature-dwl-guile)
   (feature-statusbar-dtao-guile)
   (feature-swayidle)
   (feature-swaylock)
   (feature-batsignal)

   ;; Terminals
   (feature-foot)

   ;; Audio
   (feature-pipewire)
   (feature-pulseaudio-control)))

;;;
;;; Emacs base features
;;;
(define-public %emacs-base-features
  (list
   (feature-emacs)
   (feature-emacs-evil)
   (feature-emacs-which-key)
   (feature-emacs-keycast)

   ;; UI
   (feature-emacs-appearance)
   (feature-emacs-modus-themes)
   (feature-emacs-circadian)
   (feature-emacs-all-the-icons)

   ;; Generic
   (feature-emacs-eshell)
   (feature-emacs-re-builder) ;; Interactive Regex builder
   (feature-emacs-comint)
   (feature-emacs-help)

   ;; Completion
   (feature-emacs-completion)
   (feature-emacs-vertico)
   (feature-emacs-corfu)

   ;; Focus
   (feature-emacs-monocle) ;; Sets up olivetti for distraction free reading/writing
   (feature-emacs-project)

   ;; Development
   (feature-emacs-eglot)
   (feature-emacs-git)
   (feature-emacs-geiser)
   (feature-emacs-guix)

   ;; Research
   (feature-emacs-org)
   (feature-emacs-org-agenda)
   (feature-emacs-org-roam
    #:org-roam-directory "~/documents/notes"
    ;; Use Denote's naming scheme for org-roam
    ;; https://baty.net/2023/08/using-both-denote-and-org-roam
    #:org-roam-capture-templates
    '(("d" "default" plain "%?"
       :target
       (file+head "%<%Y%m%dT%H%M%S>--${slug}.org" ":PROPERTIES:\n:ID:          %<%Y%m%dT%H%M%S>\n:END:\n#+title:      ${title}\n#+date:       [%<%Y-%m-%d %a %H:%S>]\n#+filetags: \n#+identifier: %<%Y%m%dT%H%M%S>\n\n")
       :immediate-finish t
       :unnarrowed t)))
   (feature-emacs-denote
    #:denote-directory "~/documents/notes")
   (feature-emacs-citation
    #:global-bibliography (list "~/documents/bib/references.bib"))
   (feature-emacs-pdf-tools)
   (feature-emacs-elfeed
    #:elfeed-org-files (list "~/documents/rss.org"))

   ;; Communication
   (feature-emacs-telega)
   (feature-emacs-ebdb
    #:ebdb-sources (list "~/documents/contacts")
    #:ebdb-popup-size 0.2)))

;;;
;;; Rust development features
;;;
(define-public %dev-rust-features
  (list
   ;; Neovim
   (feature-neovim-neo-tree)
   (feature-neovim-telescope)
   (feature-neovim-cmp)
   (feature-neovim-cmp-luasnip)
   (feature-neovim-friendly-snippets)

   ;; Tree-sitter
   (feature-tree-sitter)

   ;; Rust
   (feature-rust)
   (feature-rust-dev)
   (feature-neovim-rust)))


;;;
;;; Base home packages
;;;
(define %base-home-packages
  (append
   (strings->packages
    "git" "curl" "vim" "make"

    ;; Utils
    "htop" "bat"

    ;; DNS Utils
    "bind"

    ;; Desktop
    "bemenu" "localed" "wl-clipboard" "wl-clipboard-x11" "xcape"

    ;; Terminals
    "st"

    ;; Font
    "font-iosevka-nerd"

    ;; Dev Utils
    "just"
    "flatpak"

    "pavucontrol"

    ;; Web
    "firefox" "ungoogled-chromium-wayland"


    ;; Editors
    "vscodium")))
