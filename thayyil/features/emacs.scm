(define-module (thayyil features emacs)
  #:use-module (guix gexp)
  #:use-module (dwl-guile home-service)
  #:use-module (dwl-guile utils)
  #:use-module (farg colors)
  #:use-module (farg home-service)
  #:use-module (thayyil utils)
  #:use-module (gnu home services)
  #:use-module (rde home services emacs)
  #:use-module (gnu services)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (rde gexp)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features emacs)
  #:use-module (rde features emacs-xyz)
  #:use-module (contrib features emacs-xyz)
  #:use-module (rde packages emacs)
  #:export (
            feature-emacs-thayyil-appearance))

(define* (make-emacs-feature base-name
                        #:key
                        (home-services (const '()))
                        (system-services (const '())))
  "Creates a basic emacs feature configuration."
  (let ((f-name (symbol-append 'emacs- base-name)))
    (feature
     (name f-name)
     (values `((,f-name . #t)))
     (home-services-getter home-services)
     (system-services-getter system-services))))

(define* (feature-emacs-thayyil-appearance)
  "Override default rde Emacs appearance."
  (define emacs-f-name 'engstrand-test-appearance)

  (lambda (_ palette)
    (define (get-home-services config)
      (list
       (rde-elisp-configuration-service
        emacs-f-name
        config
        `((require 'modus-themes)
          (window-divider-mode 0)
          (setq modus-themes-italic-constructs t
                modus-themes-bold-constructs t
                modus-themes-mixed-fonts t
                modus-themes-subtle-line-numbers t
                modus-themes-intense-markup t
                modus-themes-lang-checkers nil
                modus-themes-mode-line '(borderless)
                modus-themes-syntax nil
                modus-themes-hl-line '(underline intense)
                modus-themes-paren-match nil
                modus-themes-links nil
                modus-themes-prompts nil
                modus-themes-mail-citations 'faint
                modus-themes-region '(bg-only accented)
                modus-themes-diffs 'nil
                modus-themes-org-blocks 'gray-background
                modus-themes-org-agenda
                '((header-block . (variable-pitch 1.3))
                  (header-date . (grayscale workaholic bold-today 1.1))
                  (event . (accented varied))
                  (scheduled . uniform)
                  (habit . traffic-light))
                modus-themes-headings
                '((1 . (background variable-pitch 1.3))
                  (2 . (rainbow overline 1.1))
                  (t . (semibold))))

          (setq modus-themes-common-palette-overrides
                `((fg-line-number-inactive "gray50")
                  (fg-line-number-active fg-main)
                  (bg-line-number-inactive bg-main)
                  (bg-line-number-active bg-main)
                  (border-mode-line-active unspecified)
                  (border-mode-line-inactive unspecified)
                  (fringe unspecified)))
          (load-theme 'modus-operandi t t)
          (load-theme 'modus-vivendi t t)
          (enable-theme ',(if (palette 'light?) 'modus-operandi 'modus-vivendi)))
          #:elisp-packages (list emacs-modus-themes))))

    (make-emacs-feature emacs-f-name
                        #:home-services get-home-services)))
