(define-module (thayyil packages tmux)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial))

(define-public tmux-catppuccin
  (let ((commit "5ed4e8a6a20c928688da268dfcdf460ac9c3cb49")
        (revision "0"))
    (package
     (name "tmux-catppuccin")
     (version (git-version "0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/catppuccin/tmux")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "15qdd5qx789wzip87zqx3xfiv1aby0175kjb34j3dmh29xz23llk"))))
     (build-system trivial-build-system)
     (arguments
      `(#:modules ((guix build utils))
        #:builder (begin
                    (use-modules (guix build utils))
                    (let ((out (string-append %output
                                              "/share/tmux-plugins/catppuccin/")))
                      (mkdir-p out)
                      (copy-recursively (assoc-ref %build-inputs "source")
                                        out)))))
     (synopsis "Catppuccin for Tmux")
     (description
      "@code{tmux-catppuccin-theme} is a catppuccin theme for Tmux.")
     (home-page "https://github.com/catppuccin/tmux")
     (license license:expat))))
