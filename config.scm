(define-module (config)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features system)
  #:use-module (rde features ssh)
  #:use-module (rde features keyboard)
  #:use-module (rde features shellutils)
  #:use-module (rde features wm)
  #:use-module (rde features emacs)
  #:use-module (rde features emacs-xyz)
  #:use-module (contrib features emacs-xyz)
  #:use-module (rde features tmux)

  #:use-module (rde packages)

  #:use-module (luna features networking)

  #:use-module (thayyil features dwl-guile)
  #:use-module (thayyil features dtao-guile)
  #:use-module (thayyil features laptop)
  #:use-module (thayyil features emacs)

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

  #:use-module (guix gexp)
  
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match))

(define %base-features
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
    #:guix-authorized-keys (list (local-file "./guix/files/nonguix-signing-key.pub")))
   (feature-desktop-services)

   (feature-dwl-guile)
   (feature-statusbar-dtao-guile)

   (feature-swaylock)
   
   ;; SSH
   (feature-ssh)

   ;; Shell
   (feature-tmux)
   (feature-direnv)

   ;; Emacs
   (feature-emacs)
   (feature-emacs-git)
   (feature-emacs-keycast)
   (feature-emacs-thayyil-appearance)
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
	      `(("git/config", (local-file "./guix/files/git/config"))
		("tmux/tmux.conf", (local-file "./guix/files/tmux.conf"))
		("nvim", (local-file "./guix/files/nvim" #:recursive? #t))))))))
   
;;;
;;; Default packages
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
    "bemenu" "localed" "wl-clipboard" "wl-clipboard-x11"

    ;; Terminals
    "st" "foot"

    "flatpak"

    "pavucontrol"

    ;; Web
    "firefox" "ungoogled-chromium-wayland"

    ;; Editors
    "vscodium" "neovim" "neovim-packer"
    )))

(define %base-system-packages
  '())

(define tycho-mapped-devices
  (list
   (mapped-device
    (source (uuid "53c31fd3-6a02-429d-bf90-b540bcb53ec9"))
    (target "cryptroot")
    (type luks-device-mapping))))

(define tycho-filesystems
  (list
   (file-system (mount-point "/")
		(device "/dev/mapper/cryptroot")
		(type "btrfs")
		(dependencies tycho-mapped-devices))
   (file-system (mount-point "/boot/efi")
		(device (uuid "4454-633B" 'fat32))
		(type "vfat"))))

(define tycho-packages
  (list git))

(define tycho-features
  (list
   ;; Laptop
   (feature-laptop)
   (feature-laptop-tlp)
   (feature-laptop-monitor-brightness)
   ;; Host info
   (feature-host-info
    #:host-name "tycho"
    #:timezone  "Europe/London"
    #:locale "en_GB.utf8")

   ;; Bootloader
   (feature-bootloader
    #:bootloader-configuration
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets (list "/boot/efi"))
     (keyboard-layout "gb")))

   ;; Kernel
   (feature-kernel
    #:kernel linux
    #:initrd microcode-initrd
    #:firmware (list linux-firmware))
   
   ;; File systems
   (feature-file-systems
    #:mapped-devices tycho-mapped-devices
    #:file-systems tycho-filesystems)

   ;; Packages
   (feature-base-packages
    #:system-packages
    (append %base-system-packages)
    #:home-packages
    (append %base-home-packages
            tycho-packages))))

(define tycho-config
  (rde-config
   (features (append
	      %base-features
	      tycho-features))))

(define tycho-he
  (rde-config-home-environment tycho-config))

(define tycho-os
  (rde-config-operating-system tycho-config))

(define (dispatcher)
  (let ((target (getenv "TARGET")))
    (match target
      ("tycho-home" tycho-he)
      ("tycho-system" tycho-os)
      (_ tycho-he))))

(dispatcher)
