(define-module (thayyil systems wsl)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features system)
  #:use-module (rde packages)

  #:use-module (thayyil common)

  #:use-module (gnu services)
  #:use-module (gnu services base)

  #:use-module (gnu image)

  #:use-module (guix packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages version-control)

  #:use-module (gnu bootloader)

  #:use-module (gnu system)
  #:use-module (gnu system image)
  #:use-module (gnu system shadow)
  
  #:use-module (gnu system images wsl2)

  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:select (fsdg-compatible))
  
  #:use-module (gnu home services)
  
  #:use-module (guix gexp))

;;;
;;; WSL2 system packages
;;;
(define wsl-system-packages
  '())

;;;
;;; Tycho home packages
;;;
(define wsl-home-packages
  '())

(define (wsl-boot-program user)
  "Program that runs the system boot script, then starts a login shell as
USER."
  (program-file
   "wsl-boot-program"
   (with-imported-modules '((guix build syscalls))
			  #~(begin
			      (use-modules (guix build syscalls))
			      (unless (file-exists? "/run/current-system")
				(let ((shepherd-socket "/var/run/shepherd/socket"))
				  ;; Clean up this file so we can wait for it later.
				  (when (file-exists? shepherd-socket)
				    (delete-file shepherd-socket))

				  ;; Child process boots the system and is replaced by shepherd.
				  (when (zero? (primitive-fork))
				    (let* ((system-generation
					    (readlink "/var/guix/profiles/system"))
					   (system (readlink
						    (string-append
						     (if (absolute-file-name? system-generation)
							 ""
							 "/var/guix/profiles/")
						     system-generation))))
				      (setenv "GUIX_NEW_SYSTEM" system)
				      (execl #$(file-append guile-3.0 "/bin/guile")
					     "guile"
					     "--no-auto-compile"
					     (string-append system "/boot"))))

				  ;; Parent process waits for shepherd before continuing.
				  (while (not (file-exists? shepherd-socket))
					 (sleep 1))))

			      (let* ((pw (getpw #$user))
				     (shell (passwd:shell pw))
				     (sudo #+(file-append sudo "/bin/sudo"))
				     (args (cdr (command-line)))
				     (uid (passwd:uid pw))
				     (gid (passwd:gid pw))
				     (runtime-dir (string-append "/run/user/"
								 (number->string uid))))
				;; Save the value of $PATH set by WSL.  Useful for finding
				;; Windows binaries to run with WSL's binfmt interop.
				(setenv "WSLPATH" (getenv "PATH"))

				;; /run is mounted with the nosuid flag by WSL.  This prevents
				;; running the /run/setuid-programs.  Remount it without this flag
				;; as a workaround.  See:
				;; https://github.com/microsoft/WSL/issues/8716.
				(mount #f "/run" #f
				       MS_REMOUNT
				       #:update-mtab? #f)

				;; Create XDG_RUNTIME_DIR for the login user.
				(unless (file-exists? runtime-dir)
				  (mkdir runtime-dir)
				  (chown runtime-dir uid gid))
				(setenv "XDG_RUNTIME_DIR" runtime-dir)

				;; Start login shell as user.
				(apply execl sudo "sudo"
				       "--preserve-env=WSLPATH,XDG_RUNTIME_DIR"
				       "-u" #$user
				       "--"
				       shell "-l" args))))))

(define dummy-package
  (package
   (name "dummy")
   (version "0")
   (source #f)
   (build-system trivial-build-system)
   (arguments
    `(#:modules ((guix build utils))
      #:target #f
      #:builder (begin
                  (use-modules (guix build utils))
                  (let* ((out (assoc-ref %outputs "out"))
                         (dummy (string-append out "/dummy")))
                    (mkdir-p out)
                    (call-with-output-file dummy
                      (const #t))))))
   (home-page #f)
   (synopsis #f)
   (description #f)
   (license (fsdg-compatible "dummy"))))

(define dummy-bootloader
  (bootloader
   (name 'dummy-bootloader)
   (package dummy-package)
   (configuration-file "/dev/null")
   (configuration-file-generator
    (lambda (. _rest)
      (plain-file "dummy-bootloader" "")))
   (installer #~(const #t))))

(define dummy-kernel dummy-package)

(define (dummy-initrd . _rest)
  (plain-file "dummy-initrd" ""))


;;;
;;; Host features
;;;
(define wsl-features
  (list
   ;; Host info
   (feature-host-info
    #:host-name "gnu"
    #:timezone  "Europe/London"
    #:locale "en_GB.utf8")
   
   ;; Bootloader
   (feature-bootloader
    #:bootloader-configuration
	(bootloader-configuration
     (bootloader dummy-bootloader)))

   ;; Full Linux kernel from Nonguix
   (feature-kernel
    #:kernel dummy-kernel
    #:initrd dummy-initrd
    #:firmware '())

   ;; File systems
   (feature-file-systems
    #:base-file-systems '())
   
   ))

;;;
;;; RDE configuration for tycho.
;;;
(define-public wsl-config
  (rde-config
   (features (append
			   %base-features
			   %dev-rust-features
	      wsl-features))))
