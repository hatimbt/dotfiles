;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home))
(use-modules (gnu packages))
(use-modules (gnu services))

;; 'home-bash-service-type'
(use-modules (gnu home services shells))

;; To use 'local-file'
(use-modules (guix gexp))

;; 'htop'
(use-modules (gnu packages admin))

;; 'st'
(use-modules (gnu packages suckless))

;; 'alacritty'
(use-modules (gnu packages terminals))

;; 'exa'
(use-modules (gnu packages rust-apps))

;; 'tmux'
(use-modules (gnu packages tmux))

;; 'ungoogled-chromium'
(use-modules (gnu packages chromium))

;; 'vscodium'
(use-modules (nongnu packages editors))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (list
	      htop
	      tmux
	      st
	      alacritty
	      exa
	      ungoogled-chromium
	      vscodium))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
                              ("ls" . "ls -p --color=auto")))
                   (bashrc (list (local-file
                                  "../files/rc.bash"
                                  "bashrc")))
                   (bash-profile (list (local-file
                                        "../files/profile.bash"
                                        "bash_profile"))))))))
