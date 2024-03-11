(define-module (thayyil features rust)
  #:use-module (rde features)
  #:use-module (rde features predicates)

  #:use-module (gnu services)
  #:use-module (gnu home services)

  #:use-module (gnu packages llvm)
  #:use-module (gnu packages rust)

  #:use-module (gnu packages tree-sitter)

  #:use-module (guix gexp)

  #:export (feature-rust)
  #:export (feature-rust-dev)
  )

(define* (feature-rust
          #:key
          (rust rust)
          (cargo `(,rust "cargo"))
          (rust-tools `(,rust "tools"))
          (tree-sitter-rust tree-sitter-rust))
  (define (get-home-services config)
    (list
     (simple-service
      'rust-add-packages
      home-profile-service-type
      (list
       rust
       cargo))
     (simple-service
      'add-cargo-to-path
       home-environment-variables-service-type
       `(("PATH"  . "$HOME/.cargo/bin${PATH:+:}$PATH")))))
  (feature
   (name 'rust)
   (values `((rust . #t)))
   (home-services-getter get-home-services)))

(define* (feature-rust-dev
          #:key
          (tree-sitter-rust tree-sitter-rust))
  (define (get-home-services config)
    (list
     (simple-service
      'rust-dev-add-packages
      home-profile-service-type
      (list
       rust-analyzer
       tree-sitter-rust
       clang-toolchain))
     ))
  (feature
   (name 'rust-dev)
   (values `((rust-dev . #t)))
   (home-services-getter get-home-services)))
