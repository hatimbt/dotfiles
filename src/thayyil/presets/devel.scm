(define-module (thayyil presets devel)
  #:use-module (thayyil features neovim)
  #:use-module (thayyil features tree-sitter)
  #:use-module (thayyil features rust)
  #:use-module (rde features virtualization)
  #:use-module (rde features containers))

(define-public thayyil-neovim-set
  (list
   (feature-neovim)

   (feature-neovim-neo-tree)
   (feature-neovim-telescope)
   (feature-neovim-cmp)
   (feature-neovim-cmp-luasnip)
   (feature-neovim-friendly-snippets)

   (feature-tree-sitter)))

(define-public thayyil-devel-rust-set
  (list
   (feature-rust)
   (feature-rust-dev)
   (feature-neovim-rust)))

(define-public thayyil-virtualisation-set
  (list
   (feature-podman)
   (feature-qemu)))
