;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home))
(use-modules (gnu packages))
(use-modules (gnu services))

(use-modules (gnu home services))
(use-modules (gnu home services shells))
(use-modules (gnu home services ssh))

;; To use 'local-file'
(use-modules (guix gexp))

;; Wayland compositor
(use-modules (dwl-guile home-service)
	     (dwl-guile patches))
;; Status bar
(use-modules (dtao-guile home-service))

(define (dtao-guile-left-blocks)
  (append
    (map
      (lambda (tag)
	(let ((str (string-append "^p(8)" (number->string tag) "^p(8)"))
	      (index (- tag 1)))
	  (dtao-block
	    (interval 0)
	    (events? #t)
	    (click `(match button
			   (0 (dtao:view ,index))))
	    (render `(cond
		       ((dtao:selected-tag? ,index)
			,(format #f "^bg(~a)^fg(~a)~a^fg()^bg()"
				 "#ffcc00"
				 "#191919"
				 str))
		       ((dtao:urgent-tag? ,index)
			,(format #f "^bg(~a)^fg(~a)~a^fg()^bg()"
				 "#ff0000"
				 "#ffffff"
				 str))
		       ((dtao:active-tag? ,index)
			,(format #f "^bg(~a)^fg(~a)~a^fg()^bg()"
				 "#323232"
				 "#ffffff"
				 str))
		       (else ,str))))))
      (iota 9 1))
    (list
      (dtao-block
	(events? #t)
	(click `(dtao:next-layout))
	(render `(string-append "^p(4)" (dtao:get-layout)))))))

(define (dtao-guile-center-blocks)
  (list
    (dtao-block
      (events? #t)
      (render `(dtao:title)))))

(define (dtao-guile-right-blocks)
  (list
    (dtao-block
      (interval 1)
      (render `(strftime "%A, %d %b (w.%V) %T" (localtime (current-time)))))
    (dtao-block
      (position "right")
      (interval 10)
      (render
	`(let* ((port (open-input-file ,"/sys/class/power_supply/BAT0/capacity"))
		(result (read-line port))
		(percent (string->number result)))
	   (close-port port)
	   (string-append "^fg("
			  (cond
			    ((<= percent 20) ,"#ff0000")
			    ((<= percent 50) ,"#ffffff")
			    (else ,"#00ff00"))
			  ")" result "%^fg()"))))))


(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (map specification->package
		 '("git"
		   "openssh"

		   "htop"
		   "tmux"

		   "bemenu"

		   "st"
		   "foot"

		   "firefox"
		   "ungoogled-chromium-wayland"

		   "vscodium"
		   "neovim")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
    (list (service home-bash-service-type
		   (home-bash-configuration
		     (aliases '(("grep" . "grep --color=auto")
				("ll" . "ls -l")
				("ls" . "ls -p --color=auto")))
		     (bashrc (list (local-file
				     "../files/rc.bash"
				     "bashrc")))
		     (bash-profile (list (local-file
					   "../files/profile.bash"
					   "bash_profile")))))

	  ;; Requires the `openssh` package
	  (service home-openssh-service-type
		   (home-openssh-configuration
		     (add-keys-to-agent "ask")))
	  (service home-ssh-agent-service-type)

	  (service home-xdg-configuration-files-service-type
		   `(("git/config", (local-file "../files/git/config"))
		     ("tmux/tmux.conf", (local-file "../files/tmux.conf"))))

	  ;; Install and configure dwl-guile wayland compositor
	  ;; by engstrand.
	  (service home-dwl-guile-service-type
		   (home-dwl-guile-configuration
		     (package
		       (patch-dwl-guile-package dwl-guile
						#:patches (list %patch-xwayland)))
		     (auto-start? #t)))

	  (service home-dtao-guile-service-type
		   (home-dtao-guile-configuration
		     (auto-start? #t)
		     (config
		       (dtao-config
			 (block-spacing 0)
			 (modules '((ice-9 match)
				    (ice-9 popen)
				    (ice-9 rdelim)
				    (srfi srfi-1)))
			 (padding-left 0)
			 (padding-top 0)
			 (padding-bottom 0)
			 (height 25)
			 ;; Ensure that blocks have spacing between them
			 (delimiter-right " ")
			 (left-blocks (dtao-guile-left-blocks))
			 (right-blocks (dtao-guile-right-blocks))
			 (center-blocks (dtao-guile-center-blocks)))))))))

