(define-module (rde-configs hosts tycho)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features system)
  #:use-module (rde features wm)
  #:use-module (rde packages)

  #:use-module (thayyil features laptop)

  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)

  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)

  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)

  #:use-module (ice-9 match)
  #:use-module (rde-configs users hatim))

;;;
;;; LUKS Encryption mapped storage devices
;;;
(define tycho-mapped-devices
  (list
   (mapped-device
    (source (uuid "53c31fd3-6a02-429d-bf90-b540bcb53ec9"))
    (target "cryptroot")
    (type luks-device-mapping))))

;;;
;;; Mount points
;;;
(define tycho-file-systems
  (list
   ;; Partition for the root filesystem
   (file-system (mount-point "/")
		(device "/dev/mapper/cryptroot")
		(type "btrfs")
		(dependencies tycho-mapped-devices))
   ;; EFI Boot parition
   (file-system (mount-point "/boot/efi")
		(device (uuid "4454-633B" 'fat32))
		(type "vfat"))))

;;;
;;; Host features
;;;
(define-public %tycho-features
  (list
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

   ;; Full Linux kernel from Nonguix
   (feature-kernel
    #:kernel linux
    #:initrd microcode-initrd
    #:firmware (list linux-firmware))

   ;; File systems
   (feature-file-systems
    #:mapped-devices tycho-mapped-devices
    #:file-systems tycho-file-systems)

   ;; Kanshi for monitor profiles
   (feature-kanshi)

   ;; HiDPI
   (feature-hidpi)

   ;; Laptop
   (feature-laptop)
   (feature-laptop-tlp)))

(define-public tycho-config
  (rde-config
   (features
    (append
     %tycho-features
     %hatim-features))))

(define-public tycho-os
  (rde-config-operating-system tycho-config))

(define-public tycho-he
  (rde-config-home-environment tycho-config))

(define (dispatcher)
  (let ((rde-target (getenv "RDE")))
    (match rde-target
      ("home" tycho-he)
      ("system" tycho-os))))

(dispatcher)
