(define-module (thayyil features neovim)
  #:use-module (rde features)
  #:use-module (rde features predicates)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (thayyil utils)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages rust-apps)
  #:use-module (thayyil packages vim)

  #:export (feature-neovim)
  #:export (feature-neovim-telescope)
  #:export (feature-neovim-rust))

(define* (feature-neovim)
  "Install and setup Neovim."

  (define (get-home-services config)
    "Return a list of home services required for Neovim"
    (list
     (simple-service
      'add-neovim-home-packages-to-profile
      home-profile-service-type
      (list
       neovim
       neovim-modus-themes

       neovim-lualine

       neovim-lsp-zero
       neovim-lspconfig

       neovim-treesitter
       neovim-tree

       neovim-cmp
       neovim-cmp-buffer
       neovim-cmp-path
       neovim-cmp-lsp

       neovim-luasnip
       neovim-cmp-luasnip
       neovim-friendly-snippets
       ))))

  (feature
   (name 'neovim)
   (home-services-getter get-home-services)))

(define* (feature-neovim-telescope
          #:key
          (fd fd))
  "Install telescope with ripgrep and fd."

  (define (get-home-services config)
    "Return a list of home services required for telescope.nvim"
    (list
     (simple-service
      'add-neovim-telescope-packages-to-profile
      home-profile-service-type
      (list
       neovim-telescope ripgrep fd))))
  (feature
   (name 'neovim-telescope)
   (home-services-getter get-home-services)))

(define* (feature-neovim-rust)
  (define (get-home-services config)
    (list
     (simple-service
      'rust-dev-add-packages
      home-profile-service-type
      (list
       neovim-rustaceanvim
       ))
     ))
  (feature
   (name 'neovim-rust)
   (values `((neovim-rust . #t)))
   (home-services-getter get-home-services)))
