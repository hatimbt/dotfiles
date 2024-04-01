(define-module (thayyil packages vim)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system vim)
  #:use-module (guix build-system copy))

(define-public neovim-lspconfig
  (package
   (name "neovim-lspconfig")
   (version "0.1.6")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/neovim/nvim-lspconfig")
           (commit (string-append "v" version))))
     (sha256
      (base32 "15lgwqwk6c6rkagbjakylfaq4v49ib7ahp4mcw121k3i5akj1hh7"))))
   (build-system vim-build-system)
   (arguments
    (list #:plugin-name "lspconfig"))
   (home-page "https;//github.com/neovim/nvim-lspconfig")
   (synopsis "Default language server configurations for Neovim")
   (description "This Neovim package provides the canonical configurations for the Neovim builtin LSP
client.")
   (license license:asl2.0)))

(define-public neovim-rustaceanvim
  (package
   (name "neovim-rustaceanvim")
   (version "4.12.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/mrcjkb/rustaceanvim")
           (commit version)))
     (sha256
      (base32 "1bixfmwwsx9mhxmdh5kkc361380l2j3nwwacm1pa0vp442vd59qa"))))
   ;; FIXME Using the copy build system as the vim build system has a regex that
   ;; excludes directories einding with either `test/` or `tests/`.
   (build-system copy-build-system)
   (arguments
    `(#:install-plan
      '(("doc" "share/nvim/site/pack/guix/start/rustaceanvim/")
        ("lua" "share/nvim/site/pack/guix/start/rustaceanvim/")
        ("ftplugin" "share/nvim/site/pack/guix/start/rustaceanvim/"))))
   (home-page "https://github.com/mrcjkb/rustaceanvim")
   (synopsis "Supercharge your Rust experience in Neovim! A heavily modified
fork of rust-tools.nvim.")
   (description "This plugin automatically configures the rust-analyzer builtin
LSP client and integrates with other Rust tools.")
   (license license:gpl2)))

(define-public neovim-neotest
  (package
   (name "neovim-neotest")
   (version "4.4.2")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/nvim-neotest/neotest")
           (commit (string-append "v" version))))
     (sha256
      (base32 "1pq9zjcnihah6nlz2zhkb1shv5x0k3dcdxfmc1v4sq13i6yj16c4"))))
   (build-system vim-build-system)
   (arguments
    (list #:plugin-name "neotest"))
   (home-page "https://github.com/nvim-neotest/neotest")
   (synopsis "An extensible framework for interacting with tests within NeoVim.")
   (description "")
   (license license:expat)))

(define-public neovim-lualine
  (package
   (name "neovim-lualine")
   (version "4.4.2")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/nvim-neotest/neotest")
           (commit (string-append "v" version))))
     (sha256
      (base32 "1pq9zjcnihah6nlz2zhkb1shv5x0k3dcdxfmc1v4sq13i6yj16c4"))))
   (build-system vim-build-system)
   (arguments
    (list #:plugin-name "neotest"))
   (home-page "https://github.com/nvim-neotest/neotest")
   (synopsis "An extensible framework for interacting with tests within NeoVim.")
   (description "")
   (license license:expat)))

(define-public neovim-lualine
  (let ((commit "8b56462bfb746760465264de41b4907310f113ec")
        (revision "0"))
    (package
     (name "neovim-lualine")
     (version (git-version "0.0.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nvim-lualine/lualine.nvim")
             (commit commit)))
       (sha256
        (base32 "1jgq8a230skc3k2nrgnxa7ja2wy7sv5kfl0yyaxfggmvsjcyk28v"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "lualine"))
     (home-page "https://github.com/nvim-lualine/lualine.nvim")
     (synopsis "A blazing fast and easy to configure neovim statusline plugin
written in pure lua. ")
     (description "")
     (license license:expat))))

(define-public neovim-lsp-zero
  (let ((commit "14c9164413df4be17a5a0ca9e01a376691cbcaef")
        (revision "0"))
    (package
     (name "neovim-lsp-zero")
     (version (git-version "v3.x" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/VonHeikemen/lsp-zero.nvim")
             (commit commit)))
       (sha256
        (base32 "0j14qznpwi80hildcd0gwmn2qyq3cq2y320g812c0g4lp6w30m83"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "lsp-zero"))
     (home-page "https://github.com/VonHeikemen/lsp-zero.nvim")
     (synopsis "A starting point to setup some lsp related features in neovim.")
     (description "Collection of functions that will help you setup Neovim's LSP
client, so you can get IDE-like features with minimum effort.

Out of the box it will help you integrate @code{neovim-cmp} (an autocompletion
plugin) and @code{neovim-lspconfig} (a collection of configurations for various
language servers).")
     (license license:expat))))

(define-public neovim-luasnip
  (package
   (name "neovim-luasnip")
   (version "2.2.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/L3MON4D3/LuaSnip")
           (commit (string-append "v" version))))
     (sha256
      (base32 "05d5ks3g6a9dl3bmap8m60hnx3hc4acvcp2jzkw85r4anaawl45b"))))
   (build-system vim-build-system)
   (arguments
    (list #:plugin-name "luasnip"))
   (home-page "https://github.com/L3MON4D3/LuaSnip")
   (synopsis "A snippets plugin for Neovim written in Lua")
   (description "This Neovim plugin provides a code snippet engine written in Lua.")
   (license license:asl2.0)))

(define-public neovim-cmp
  (let ((commit "04e0ca376d6abdbfc8b52180f8ea236cbfddf782")
        (revision "0"))
    (package
     (name "neovim-cmp")
     (version (git-version "0.0.1" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hrsh7th/nvim-cmp")
             (commit commit)))
       (sha256
        (base32 "0zzlkla5vgrfa55a3sjb885q0574s67ji5ps2rq53q82hlfwwphl"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "cmp"))
     (home-page "https://github.com/hrsh7th/nvim-cmp")
     (synopsis "Autocompletion for @code{neovim}")
     (description "A completion engine for neovim written in Lua. Completion
sources are installed from external repositories and 'sourced'.")
     (license license:expat))))

(define-public neovim-cmp-lsp
  (let ((commit "5af77f54de1b16c34b23cba810150689a3a90312")
        (revision "0"))
    (package
     (name "neovim-cmp-lsp")
     (version (git-version "0.0.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hrsh7th/cmp-nvim-lsp")
             (commit commit)))
       (sha256
        (base32 "03q0v6wgi1lphcfjjdsc26zhnmj3ab9xxsiyp1adl3s1ybv22jzz"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "cmp-lsp"))
     (home-page "https://github.com/hrsh7th/cmp-nvim-lsp")
     (synopsis "LSP source for @code{neovim-cmp}")
     (description "This plugin provides an LSP backend for the @code{neovim-cmp} plugin.")
     (license license:expat))))

(define-public neovim-cmp-luasnip
  (let ((commit "05a9ab28b53f71d1aece421ef32fee2cb857a843")
        (revision "0"))
    (package
     (name "neovim-cmp-luasnip")
     (version (git-version "0.0.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/saadparwaiz1/cmp_luasnip")
             (commit commit)))
       (sha256
        (base32 "0gw3jz65dnxkc618j26zj37gs1yycf7wql9yqc9glazjdjbljhlx"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "cmp-luasnip"))
     (propagated-inputs (list neovim-cmp neovim-luasnip))
     (home-page "https://github.com/saadparwaiz1/cmp_luasnip")
     (synopsis "Luasnip source for neovim-cmp")
     (description "This Neovim plugin adds a LuaSnip source for the
@code{neovim-cmp} completion engine.")
     (license license:asl2.0))))

(define-public neovim-cmp-buffer
  (let ((commit "3022dbc9166796b644a841a02de8dd1cc1d311fa")
        (revision "0"))
    (package
     (name "neovim-cmp-buffer")
     (version (git-version "0.0.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hrsh7th/cmp-buffer")
             (commit commit)))
       (sha256
        (base32 "1cwx8ky74633y0bmqmvq1lqzmphadnhzmhzkddl3hpb7rgn18vkl"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "cmp-buffer"))
     (propagated-inputs (list neovim-cmp))
     (home-page "https://github.com/hrsh7th/cmp-buffer")
     (synopsis "@code{neovim-cmp} source for buffer words.")
     (description "")
     (license license:asl2.0))))

(define-public neovim-cmp-path
  (let ((commit "91ff86cd9c29299a64f968ebb45846c485725f23")
        (revision "0"))
    (package
     (name "neovim-cmp-path")
     (version (git-version "0.0.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hrsh7th/cmp-path")
             (commit commit)))
       (sha256
        (base32 "18ixx14ibc7qrv32nj0ylxrx8w4ggg49l5vhcqd35hkp4n56j6mn"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "cmp-path"))
     (propagated-inputs (list neovim-cmp))
     (home-page "https://github.com/hrsh7th/cmp-path")
     (synopsis "@code{neovim-cmp} source for path.")
     (description "")
     (license license:asl2.0))))

(define-public neovim-friendly-snippets
  (let ((commit "dcd4a586439a1c81357d5b9d26319ae218cc9479")
        (revision "0"))
    (package
     (name "neovim-friendly-snippets")
     (version (git-version "0.0.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/rafamadriz/friendly-snippets")
             (commit commit)))
       (sha256
        (base32 "10326d83hghpfzjkbjy9zy9f07p2wvhl4ss92zfx2mbfj44xg3qi"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "friendly-snippets"))
     (home-page "https://github.com/rafamadriz/friendly-snippets")
     (synopsis "Set of preconfigured snippets for different languages. ")
     (description "")
     (license license:expat))))

(define-public neovim-treesitter
    (package
     (name "neovim-treesitter")
     (version "0.9.2")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nvim-treesitter/nvim-treesitter/")
             (commit (string-append "v" version))))
       (sha256
        (base32 "0n18i41mgaw54b5y2j7lrqsc9hfhdl1rl0hx9jcy1028sa5a436c"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "nvim-treesitter"))
     (home-page "https://github.com/nvim-treesitter/nvim-treesitter/")
     (synopsis "Nvim Treesitter configurations and abstraction layer ")
     (description "")
     (license license:expat)))

(define-public neovim-nvim-tree
    (package
     (name "neovim-nvim-tree")
     (version "1.0")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nvim-tree/nvim-tree.lua")
             (commit (string-append "v" version))))
       (sha256
        (base32 "099s38w11r9i38338l03ash294a48kq9p9cyjijs6w02drzmnbb2"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "nvim-tree"))
     (home-page "https://github.com/nvim-tree/nvim-tree.lua")
     (synopsis "A file explorer tree for neovim written in lua")
     (description "")
     (license license:gpl3+)))

(define-public neovim-plenary
    (package
     (name "neovim-plenary")
     (version "0.1.4")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nvim-lua/plenary.nvim")
             (commit (string-append "v" version))))
       (sha256
        (base32 "1sn7vpsbwpyndsjyxb4af8fvz4sfhlbavvw6jjsv3h18sdvkh7nd"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "plenary.nvim"))
     (home-page "https://github.com/nvim-lua/plenary.nvim")
     (synopsis "Helpful Lua functions used in Neovim plugins.")
     (description "")
     (license license:expat)))

(define-public neovim-telescope
    (package
     (name "neovim-telescope")
     (version "0.1.5")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nvim-telescope/telescope.nvim")
             (commit version)))
       (sha256
        (base32 "1n28aiq1k12rvk2l1vr0wrdxb5016xz1bw8fqsc4zf15cg4nk50z"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "telescope.nvim"))
     (propagated-inputs (list neovim-plenary))
     (home-page "https://github.com/nvim-telescope/telescope.nvim")
     (synopsis "@code{telescope.nvim} is a highly extendable fuzzy finder for
Neovim.")
     (description "")
     (license license:expat)))

(define-public neovim-modus-themes
    (package
     (name "neovim-modus-themes")
     (version "1.1.1")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/miikanissi/modus-themes.nvim")
             (commit (string-append "v" version))))
       (sha256
        (base32 "187w5p26n034kyfpfakwdvh1ywljs24q0qzakhcdv6k4dfcck1nw"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "modus-themes.nvim"))
     (home-page "https://github.com/miikanissi/modus-themes.nvim")
     (synopsis "Highly accessible themes for Neovim, conforming with the highest
standard for color contrast between background and foreground values (WCAG AAA).
A Neovim port of the original Modus Themes built for GNU Emacs.")
     (description "")
     (license license:gpl3)))

(define-public neovim-registers
    (package
     (name "neovim-registers")
     (version "2.3.0")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/tversteeg/registers.nvim")
             (commit (string-append "v" version))))
       (sha256
        (base32 "08mg2rjbvyrgj5l1j3nzv7iwfsvm0wx5838lgk95zqb151sas4r7"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "registers.nvim"))
     (home-page "https://github.com/tversteeg/registers.nvim")
     (synopsis "Neovim plugin to preview the contents of the registers")
     (description "This Neovim plugin adds an interactive and visually pleasing UI for selecting what register item to paste or use next. ")
     (license license:gpl3)))

(define-public neovim-nui
    (package
     (name "neovim-nui")
     (version "0.3.0")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/MunifTanjim/nui.nvim")
             (commit version)))
       (sha256
        (base32 "0fjrnhfhq7sn3am7283adar0jlf6gcyq303kxkwqvxzvvdg9nirg"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "nui.nvim"))
     (home-page "https://github.com/MunifTanjim/nui.nvim")
     (synopsis "UI Component Library for Neovim")
     (description "")
     (license license:expat)))

(define-public neovim-neo-tree
    (package
     (name "neovim-neo-tree")
     (version "3.23")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nvim-neo-tree/neo-tree.nvim")
             (commit version)))
       (sha256
        (base32 "0imgbzf9k98az077zqscf82iilf5rlkawxci2c1p3djb3nf8h43m"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "neo-tree.nvim"))
     (propagated-inputs (list neovim-nui))
     (home-page "https://github.com/nvim-neo-tree/neo-tree.nvim")
     (synopsis "Neovim plugin to manage the file system and other tree like
structures")
     (description "Neo-tree is a Neovim plugin to browse the file system and
other tree like structures in whatever style suits you, including sidebars,
floating windows, netrw split style, or all of them at once!")
     (license license:expat)))

(define-public neovim-web-devicons
  (let ((commit "3ee60deaa539360518eaab93a6c701fe9f4d82ef")
        (revision "0"))
    (package
     (name "neovim-web-devicons")
     (version (git-version "0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nvim-tree/nvim-web-devicons")
             (commit commit)))
       (sha256
        (base32 "1a0z8canxpr5vlnmkqpys35yar8l296gdznqlvvvf1200wai3i8v"))))
     (build-system vim-build-system)
     (arguments
      (list #:plugin-name "nvim-web-devicons"))
     (home-page "https://github.com/nvim-tree/nvim-web-devicons")
     (synopsis "Adds file type icons to Vim plugins")
     (description "")
     (license license:expat))))
