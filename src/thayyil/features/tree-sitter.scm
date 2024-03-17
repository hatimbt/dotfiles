(define-module (thayyil features tree-sitter)
  #:use-module (rde features)
  #:use-module (rde features predicates)

  #:use-module (gnu services)
  #:use-module (gnu home services)

  #:use-module (gnu packages tree-sitter)

  #:use-module (guix gexp)

  #:export (feature-tree-sitter))

(define* (feature-tree-sitter)
  "Install tree-sitter."

  (define (get-home-services config)
    (list
     (simple-service
      'add-tree-sitter-package-to-profile
      home-profile-service-type
      (list
       tree-sitter
       tree-sitter-cli))))

  (feature
   (name 'tree-sitter)
   (home-services-getter get-home-services)))
