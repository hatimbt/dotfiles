(define-module (thayyil common)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features ssh)
  #:use-module (rde features keyboard)
  #:use-module (rde features linux)
  #:use-module (rde features shellutils)
  #:use-module (rde features wm)
  #:use-module (rde features emacs)
  #:use-module (rde features emacs-xyz)
  #:use-module (contrib features emacs-xyz)
  #:use-module (rde features tmux)

  #:use-module (rde packages)

  #:use-module (thayyil features networking)

  #:use-module (thayyil features dwl-guile)
  #:use-module (thayyil features dtao-guile)
  #:use-module (thayyil features laptop)
  #:use-module (thayyil features audio)
  #:use-module (thayyil packages vim)
  #:use-module (thayyil features neovim)
  #:use-module (thayyil features rust)

  #:use-module (gnu services)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages version-control)

  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)

  #:use-module (gnu home services)

  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)

  #:use-module (guix gexp))

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
    (keyboard-layout "gb"))

   ;; Networking
   (feature-networking)

   ;; Services
   (feature-base-services
    #:guix-substitute-urls (list "https://bordeaux.guix.gnu.org"
                                 "https://substitutes.nonguix.org")
    #:guix-authorized-keys (list (local-file "../files/nonguix-signing-key.pub")))
   (feature-desktop-services)

   (feature-dwl-guile)
   (feature-statusbar-dtao-guile)

   (feature-swaylock)

   ;; SSH
   (feature-ssh)

   ;; Shell
   (feature-tmux)
   (feature-direnv)

   ;; Audio
   (feature-pipewire)
   (feature-pulseaudio-control)

   ;; Emacs
   (feature-emacs)
   (feature-emacs-git)
   (feature-emacs-keycast)
   (feature-emacs-appearance)
   (feature-emacs-modus-themes)
   (feature-emacs-completion)
   (feature-emacs-evil)
   (feature-emacs-which-key)
   (feature-emacs-vertico)
   (feature-emacs-corfu)
   (feature-emacs-help)
   (feature-emacs-pdf-tools)

   (feature-emacs-org)

   (feature-emacs-denote
    #:denote-directory "~/org")

   ;; Services
   (feature-custom-services
    #:home-services
    (list
     (service home-xdg-configuration-files-service-type
	      `(("git/config", (local-file "../files/git/config"))
		("tmux/tmux.conf", (local-file "../files/tmux.conf"))
		("nvim", (local-file "../files/nvim" #:recursive? #t))))))))

;;;
;;; Development features
;;;
(define-public %dev-features
  (list
   ;; Neovim
   (feature-neovim)
   (feature-neovim-rust)

   (feature-rust)
   (feature-rust-dev)))


;;;
;;; Default packages
;;;
(define-public %base-home-packages
  (append
   (strings->packages
    "git" "curl" "vim" "make"

    ;; Utils
    "htop" "bat"

    ;; DNS Utils
    "bind"

    ;; Desktop
    "bemenu" "localed" "wl-clipboard" "wl-clipboard-x11"

    ;; Terminals
    "st" "foot"

    ;; Dev Utils
    "just"
    "flatpak"

    "pavucontrol"

    ;; Web
    "firefox" "ungoogled-chromium-wayland"


    ;; Editors
    "vscodium")))

(define-public %base-system-packages
  '())
