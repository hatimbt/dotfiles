(use-modules (gnu))
(use-modules (gnu system nss))
(use-modules (gnu services networking))
(use-modules (gnu services ssh))
(use-modules (gnu services virtualizations))
(use-modules (gnu packages))

(operating-system
  (host-name "moondust")
  (timezone "Europe/London")
  (locale "en_UK.utf8")

  ;; Choose UK English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (keyboard-layout "uk" "altgr-intl" #:model "thinkpad"))

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets '("/boot/efi"))
               (keyboard-layout keyboard-layout)))

  (file-systems (append
                 (list (file-system
                         (device (file-system-label "system-root"))
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device "/dev/sda1")
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))

  ;; This is where user accounts are specified.  The "root"
  ;; account is implicit, and is initially created with the
  ;; empty password.
  (users (cons (user-account
                (name "pleb")
                (group "users")

                ;; Adding the account to the "wheel" group
                ;; makes it a sudoer.  Adding it to "audio"
                ;; and "video" allows the user to play sound
                ;; and access the webcam.
                (supplementary-groups '("wheel" ;; sudo
										"netdev" ;; Network devices
										"realtime" ;; Enable realtime scheduling
										"lp" ;; Control bluetooth devices
                                        "audio" ;; Control audio devices
										"video"))) ;; Control video devices
               %base-user-accounts))

  ;; Add the 'realtime' group
  (groups (cons (user-group (system? #t) (name "realtime"))
                 %base-groups))

  ;; Install bare-minimum system packages
  (packages (append (map specification->package
						 '("git"
						   "ntfs-3g" ;; NTFS file systems
						   "exfat-utils" ;; exFAT file systems
						   "fuse-exfat" ;; Mount exFAT file systems
						   "bluez" ;; Bluetooth protocol stack
						   "bluez-alsa" ;; Bluetooth ALSA backend
						   "tlp" ;; Power management tool
						   "stow"
						   "alacritty"
						   "neovim"
						   "emacs"
						   "nss-certs")) ;; SSL root certificates
					%base-packages))

  ;; Add services to the baseline: a DHCP client and
  ;; an SSH server.
  (services (append (list (service dhcp-client-service-type)
                          (service openssh-service-type
                                   (openssh-configuration
                                    (openssh openssh-sans-x)
                                    (port-number 2222))))
                    %base-services)))
