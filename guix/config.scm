;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu))
(use-modules (nongnu packages linux))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (locale "en_GB.utf8")
  (timezone "Europe/London")
  (keyboard-layout (keyboard-layout "gb" "altgr-intl" #:model "thinkpad"))
  (host-name "moondust")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "pleb")
                  (comment "Pleb")
                  (group "users")
                  (home-directory "/home/pleb")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "nss-certs"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service network-manager-service-type)
                 (service wpa-supplicant-service-type)
                 (service ntp-service-type)
                 (service gpm-service-type))

           ;; This is the default list of services we
           ;; are appending to.
           %base-services))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "cd108cc8-6779-45d1-89b8-ebeed6c8b79d"))
                          (target "system-home")
                          (type luks-device-mapping))
                        (mapped-device
                          (source (uuid
                                   "fb4dfa22-42a5-4279-9417-45c3d5dc9859"))
                          (target "system-root")
                          (type luks-device-mapping))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/home")
                         (device "/dev/mapper/system-home")
                         (type "btrfs")
                         (dependencies mapped-devices))
                       (file-system
                         (mount-point "/")
                         (device "/dev/mapper/system-root")
                         (type "btrfs")
                         (dependencies mapped-devices))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "5FDA-C9EA"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
