(define-module (thayyil common)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features keyboard)
  #:use-module (rde features linux)
  #:use-module (rde features fontutils)
  #:use-module (rde features emacs)
  #:use-module (rde features emacs-xyz)
  #:use-module (contrib features javascript)

  ;; Fonts
  #:use-module (rde packages fonts)

  #:use-module (rde packages)

  #:use-module (thayyil features laptop)
  #:use-module (thayyil features audio)
  #:use-module (thayyil packages vim)
  #:use-module (thayyil features keyboard)
  #:use-module (thayyil features package-management)

  #:use-module (gnu services)
  #:use-module (gnu packages certs)

  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)

  #:use-module (gnu home services)

  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)

  #:use-module (guix gexp))

;;;
;;; Base features
;;;
(define-public %base-features
  (list
   ;; Keyboard layout
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
   (feature-pulseaudio-control)

   (feature-nix)))

;;;
;;; Emacs base features
;;;
(define-public %emacs-base-features
  (list
   ;; UI
   ;;(feature-emacs-circadian)

   ;; Generic
   (feature-emacs-re-builder) ;; Interactive Regex builder
   (feature-emacs-comint)

   ;; Development
   (feature-javascript)
   ))

;;;
;;; Base home packages
;;;
(define %base-packages
  (append
   (strings->packages
    ;; DNS Utils
    "bind"

    ;; Desktop
    "localed" "wl-clipboard" "wl-clipboard-x11" "xcape")))
