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
(use-modules (nongnu system linux-initrd))
(use-service-modules desktop networking ssh xorg)
(use-modules (gnu packages certs))
(use-modules (gnu packages version-control))
(use-modules (gnu packages package-management))
(use-modules (gnu packages suckless))
(use-modules (gnu packages vim))

(operating-system

  (kernel linux)
  (firmware (list linux-firmware))
  (initrd microcode-initrd) 

  (locale "en_GB.utf8")
  (timezone "Europe/London")
  (keyboard-layout (keyboard-layout "gb"))
  (host-name "tycho")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "hatim")
                  (comment "Hatim")
                  (group "users")
                  (home-directory "/home/hatim")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list
                      nss-certs
                      git
                      stow
                      dwm
                      dmenu
                      neovim)
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append

           ;; This is the default list of services we
           ;; are appending to.
           %desktop-services))
  
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "53c31fd3-6a02-429d-bf90-b540bcb53ec9"))
                          (target "cryptroot")
                          (type luks-device-mapping))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device "/dev/mapper/cryptroot")
                         (type "btrfs")
                         (dependencies mapped-devices))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "4454-633B"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
