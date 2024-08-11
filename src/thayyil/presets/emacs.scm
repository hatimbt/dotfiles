(define-module (thayyil presets emacs)
  #:use-module (rde features emacs)
  #:use-module (rde features emacs-xyz)
  #:use-module (contrib features emacs-xyz))

(define-public thayyil-emacs-set
  (list
   (feature-emacs
    #:default-application-launcher? #t)

   ;; General
   (feature-emacs-dired)
   (feature-emacs-all-the-icons)
   (feature-emacs-eshell)
   (feature-emacs-tramp)
   (feature-emacs-help)

   ;; Currently from (contrib features emacs-xyz).
   ;; TODO Implemene my own feature with better interop with rde emacs features
   ;; This version breaks some keybindings for geiser.
   (feature-emacs-evil)

   ;; UI
   (feature-emacs-appearance)
   (feature-emacs-modus-themes)
   (feature-emacs-monocle)
   (feature-emacs-keycast
    #:turn-on? #t)
   (feature-emacs-time)

   ;; Completion
   (feature-emacs-completion
    #:mini-frame? #f)
   (feature-emacs-corfu)
   (feature-emacs-vertico)
   (feature-emacs-which-key)

   ;; Development
   (feature-emacs-project)
   (feature-emacs-eglot)
   (feature-emacs-smartparens
    #:show-smartparens? #t)
   (feature-emacs-git)
   (feature-emacs-geiser)
   (feature-emacs-guix)))

(define-public thayyil-emacs-comms-set
  (list
   (feature-emacs-telega)
   (feature-emacs-ebdb
    #:ebdb-sources (list "~/documents/contacts")
    #:ebdb-popup-size 0.2)))

(define-public thayyil-emacs-research-set
  (list
   ;; General Org
   (feature-emacs-org)
   (feature-emacs-org-agenda)

   ;; Writing
   (feature-emacs-spelling
    #:spelling-program (@ (gnu packages hunspell) hunspell)
    #:spelling-dictionaries
    (list
     (@ (gnu packages hunspell) hunspell-dict-en)
     (@ (rde packages aspell) hunspell-dict-ru)))

   ;; PKM
   (feature-emacs-org-roam
    #:org-roam-directory "~/documents/notes"
    ;; Use Denote's naming scheme for org-roam
    ;; https://baty.net/2023/08/using-both-denote-and-org-roam
    #:org-roam-capture-templates
    '(("d" "default" plain "%?"
       :target
       (file+head "%<%Y%m%dT%H%M%S>--${slug}.org" ":PROPERTIES:\n:ID:          %<%Y%m%dT%H%M%S>\n:END:\n#+title:      ${title}\n#+date:       [%<%Y-%m-%d %a %H:%S>]\n#+filetags: \n#+identifier: %<%Y%m%dT%H%M%S>\n\n")
       :immediate-finish t
       :unnarrowed t)))
   (feature-emacs-denote
    #:denote-directory "~/documents/notes")
   (feature-emacs-citation
    #:global-bibliography (list "~/documents/bib/references.bib"))
   (feature-emacs-elfeed
    #:elfeed-org-files (list "~/documents/rss.org"))

   (feature-emacs-pdf-tools)))
