(define-module (config)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features system)
  #:use-module (rde features ssh)
  #:use-module (rde features keyboard)
  #:use-module (rde features wm)
  
  #:use-module (rde packages)

  #:use-module (luna features networking)
  
  #:use-module (gnu services)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages version-control)

  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)

  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)

  #:use-module (guix gexp)
  
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match))

(define %base-features
  (list
   ;;; User info
   (feature-user-info
    #:user-name "hatim"
    #:full-name "Hatim Thayyil"
    #:email "hatim@thayyil.net"
    #:user-groups (list "wheel" "audio" "video"
                        "input" "lp"))

   ;;; Keyboard layout
   (feature-keyboard
    #:keyboard-layout
    (keyboard-layout "gb"))

   ;; Networking
   (feature-networking)

   ;;; Services
   (feature-base-services
    #:guix-substitute-urls (list "https://bordeaux.guix.gnu.org"
                                 "https://substitutes.nonguix.org")
    #:guix-authorized-keys (list (local-file "./guix/files/nonguix-signing-key.pub")))
   (feature-desktop-services)

   (feature-swaylock)
   
   ;;; SSH
   (feature-ssh)))
   
;;;
;;; Default packages
;;;
(define %base-home-packages
  (append
   (strings->packages
    "git" "curl" "vim" "make"

    "flatpak"

    "pavucontrol"

    "firefox"
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
   ;;; Host info
   (feature-host-info
    #:host-name "tycho"
    #:timezone  "Europe/London"
    #:locale "en_GB.utf8")

   (feature-bootloader
    #:bootloader-configuration
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets (list "/boot/efi"))
     (keyboard-layout "gb")))

   ;;; Kernel
   (feature-kernel
    #:kernel linux
    #:initrd microcode-initrd
    #:firmware (list linux-firmware))
   
   ;;; File systems
   (feature-file-systems
    #:mapped-devices tycho-mapped-devices
    #:file-systems tycho-filesystems)

   ;;; Packages
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
