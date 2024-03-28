(define-module (thayyil systems tycho)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features system)
  #:use-module (rde features wm)
  #:use-module (rde packages)

  #:use-module (thayyil common)
  #:use-module (thayyil features laptop)
  #:use-module (thayyil features display)


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
(define tycho-filesystems
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
;;; Tycho system packages
;;;
(define tycho-system-packages
  '())

;;;
;;; Tycho home packages
;;;
(define tycho-home-packages
  '())

;;;
;;; Host features
;;;
(define tycho-features
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
    #:file-systems tycho-filesystems)

   ;; Packages
   (feature-base-packages
    #:system-packages
    (append tycho-system-packages
            %base-system-packages)
    #:home-packages
    (append tycho-home-packages
            %base-home-packages))

   ;; HiDPI
   (feature-hidpi)

   ;; Kanshi for monitor profiles
   (feature-kanshi)))

;;;
;;; RDE configuration for tycho.
;;;
(define-public tycho-config
  (rde-config
   (features (append
	      tycho-features
	      %dev-rust-features
              %thayyil-laptop-base-features
              %emacs-base-features
              %desktop-base-features
	      %base-features))))
