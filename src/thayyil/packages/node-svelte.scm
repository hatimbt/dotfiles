(define-module (thayyil packages node-svelte)
  #:use-module (gnu packages node-xyz)
  #:use-module (guix build-system node)
  #:use-module (guix download)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix packages))
(define-public node-jridgewell-set-array-1.2.1
  (package
    (name "node-jridgewell-set-array")
    (version "1.2.1")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@jridgewell/set-array/-/set-array-1.2.1.tgz")
       (sha256
        (base32 "0j06py03ffln44c31vcpgzdik0s7lln2fliix6rpyw5cw5yj78kg"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (home-page "https://github.com/jridgewell/set-array#readme")
    (synopsis
     "Like a Set, but provides the index of the `key` in the backing array")
    (description
     "Like a Set, but provides the index of the `key` in the backing array")
    (license license:expat)))

(define-public node-jridgewell-gen-mapping-0.3.5
  (package
    (name "node-jridgewell-gen-mapping")
    (version "0.3.5")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@jridgewell/gen-mapping/-/gen-mapping-0.3.5.tgz")
       (sha256
        (base32 "0sqci882wwbchpx06dv21lxd3q7s9sxc8qip9c64iy1mxs46mi15"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-jridgewell-trace-mapping" ,node-jridgewell-trace-mapping-0.3.25)
              ("node-jridgewell-sourcemap-codec" ,node-jridgewell-sourcemap-codec-1.4.15)
              ("node-jridgewell-set-array" ,node-jridgewell-set-array-1.2.1)))
    (home-page "https://github.com/jridgewell/gen-mapping#readme")
    (synopsis "Generate source maps")
    (description "Generate source maps")
    (license license:expat)))

(define-public node-ampproject-remapping-2.3.0
  (package
    (name "node-ampproject-remapping")
    (version "2.3.0")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@ampproject/remapping/-/remapping-2.3.0.tgz")
       (sha256
        (base32 "0s6kpwcaxxrp6snyh7ydyiv3q6d3rdir91fxhfy5lv3510h73gzq"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-jridgewell-trace-mapping" ,node-jridgewell-trace-mapping-0.3.25)
              ("node-jridgewell-gen-mapping" ,node-jridgewell-gen-mapping-0.3.5)))
    (home-page "https://github.com/ampproject/remapping#readme")
    (synopsis
     "Remap sequential sourcemaps through transformations to point at the original source code")
    (description
     "Remap sequential sourcemaps through transformations to point at the original source code")
    (license license:asl2.0)))

(define-public node-jridgewell-resolve-uri-3.1.2
  (package
    (name "node-jridgewell-resolve-uri")
    (version "3.1.2")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@jridgewell/resolve-uri/-/resolve-uri-3.1.2.tgz")
       (sha256
        (base32 "0c72fqvljvr28rdmg6hjd8zc63vm00r9xlrx6l9spfjq4pvgjlnv"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (home-page "https://github.com/jridgewell/resolve-uri#readme")
    (synopsis "Resolve a URI relative to an optional base URI")
    (description "Resolve a URI relative to an optional base URI")
    (license license:expat)))

(define-public node-jridgewell-trace-mapping-0.3.25
  (package
    (name "node-jridgewell-trace-mapping")
    (version "0.3.25")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@jridgewell/trace-mapping/-/trace-mapping-0.3.25.tgz")
       (sha256
        (base32 "1va189bi3as5qpm6xk2l1yw5fyw9rb1bgmjqyqka5zqc98lrvw7z"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-jridgewell-sourcemap-codec" ,node-jridgewell-sourcemap-codec-1.4.15)
              ("node-jridgewell-resolve-uri" ,node-jridgewell-resolve-uri-3.1.2)))
    (home-page "https://github.com/jridgewell/trace-mapping#readme")
    (synopsis "Trace the original position through a source map")
    (description "Trace the original position through a source map")
    (license license:expat)))

(define-public node-aria-query-5.3.0
  (package
    (name "node-aria-query")
    (version "5.3.0")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/aria-query/-/aria-query-5.3.0.tgz")
       (sha256
        (base32 "14jw4f6mbcz16yxbxypvm5133vlz0qkjvcxwvqp41a3819rnsc6a"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-dequal" ,node-dequal-2.0.3)))
    (home-page "https://github.com/A11yance/aria-query#readme")
    (synopsis "Programmatic access to the ARIA specification")
    (description "Programmatic access to the ARIA specification")
    (license license:asl2.0)))

(define-public node-dequal-2.0.3
  (package
    (name "node-dequal")
    (version "2.0.3")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/dequal/-/dequal-2.0.3.tgz")
       (sha256
        (base32 "0dawdan67ns9pdm629n8mh9zmy7qdn65v86j21yicy4qcbb907cl"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (home-page "https://github.com/lukeed/dequal#readme")
    (synopsis "A tiny (304B to 489B) utility for check for deep equality")
    (description "A tiny (304B to 489B) utility for check for deep equality")
    (license license:expat)))

(define-public node-axobject-query-4.0.0
  (package
    (name "node-axobject-query")
    (version "4.0.0")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/axobject-query/-/axobject-query-4.0.0.tgz")
       (sha256
        (base32 "1xkccmriz0pypbx6jqz2rvygaj7pag6nbplfybqssm809ac8fs42"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-dequal" ,node-dequal-2.0.3)))
    (home-page "https://github.com/A11yance/axobject-query#readme")
    (synopsis "Programmatic access to information about the AXObject Model")
    (description "Programmatic access to information about the AXObject Model")
    (license license:asl2.0)))

(define-public node-acorn-8.11.3
  (package
    (name "node-acorn")
    (version "8.11.3")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/acorn/-/acorn-8.11.3.tgz")
       (sha256
        (base32 "0hllmwvv5qla5rck0ljfrlvspw63xjagh1mgg290vain7hzfksyj"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (home-page "https://github.com/acornjs/acorn")
    (synopsis "ECMAScript parser")
    (description "ECMAScript parser")
    (license license:expat)))

(define-public node-code-red-1.0.4
  (package
    (name "node-code-red")
    (version "1.0.4")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/code-red/-/code-red-1.0.4.tgz")
       (sha256
        (base32 "0b0y1fzfdbw16spda77s83fyk8cghr3r3lqa57jprw6d80p3gjgc"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-periscopic" ,node-periscopic-3.1.0)
              ("node-estree-walker" ,node-estree-walker-3.0.3)
              ("node-acorn" ,node-acorn-8.11.3)
              ("node-types-estree" ,node-types-estree-1.0.5)
              ("node-jridgewell-sourcemap-codec" ,node-jridgewell-sourcemap-codec-1.4.15)))
    (home-page "https://github.com/Rich-Harris/code-red#readme")
    (synopsis "code-red")
    (description "code-red")
    (license license:expat)))

(define-public node-mdn-data-2.0.30
  (package
    (name "node-mdn-data")
    (version "2.0.30")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/mdn-data/-/mdn-data-2.0.30.tgz")
       (sha256
        (base32 "065iqf246waa6sviskria25w6fs6ccrwdibinj8q3b9a540zbqr7"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (home-page "https://developer.mozilla.org")
    (synopsis "Open Web data by the Mozilla Developer Network")
    (description "Open Web data by the Mozilla Developer Network")
    (license license:cc0)))

(define-public node-source-map-js-1.2.0
  (package
    (name "node-source-map-js")
    (version "1.2.0")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/source-map-js/-/source-map-js-1.2.0.tgz")
       (sha256
        (base32 "1h63h9ijwfbz5k44nmnh7dwj8yn9irgny20krx7yff5pm29x41nr"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (home-page "https://github.com/7rulnik/source-map-js")
    (synopsis "Generates and consumes source maps")
    (description "Generates and consumes source maps")
    (license license:bsd-3)))

(define-public node-css-tree-2.3.1
  (package
    (name "node-css-tree")
    (version "2.3.1")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/css-tree/-/css-tree-2.3.1.tgz")
       (sha256
        (base32 "1b6yi5vrds7ynfp2zv7k6jzjgfiykq5rnl2n0san379w387h2z89"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-source-map-js" ,node-source-map-js-1.2.0)
              ("node-mdn-data" ,node-mdn-data-2.0.30)))
    (home-page "https://github.com/csstree/csstree#readme")
    (synopsis
     "A tool set for CSS: fast detailed parser (CSS â AST), walker (AST traversal), generator (AST â CSS) and lexer (validation and matching) based on specs and browser implementations")
    (description
     "A tool set for CSS: fast detailed parser (CSS â AST), walker (AST traversal), generator (AST â CSS) and lexer (validation and matching) based on specs and browser implementations")
    (license license:expat)))

(define-public node-locate-character-3.0.0
  (package
    (name "node-locate-character")
    (version "3.0.0")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/locate-character/-/locate-character-3.0.0.tgz")
       (sha256
        (base32 "1195n4fvmk641za0b8mw6sxsjqvvz2y3yf7hsjjicclqsyb5d4m7"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (home-page "https://gitlab.com/Rich-Harris/locate-character#README")
    (synopsis
     "Get the line and column number of a specific character in a string")
    (description
     "Get the line and column number of a specific character in a string")
    (license license:expat)))

(define-public node-jridgewell-sourcemap-codec-1.4.15
  (package
    (name "node-jridgewell-sourcemap-codec")
    (version "1.4.15")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@jridgewell/sourcemap-codec/-/sourcemap-codec-1.4.15.tgz")
       (sha256
        (base32 "1ada9hszqx7aiv2l0sb1lxpkf860czjplxpnc0ybfs934b74jndg"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (home-page "https://github.com/jridgewell/sourcemap-codec#readme")
    (synopsis "Encode/decode sourcemap mappings")
    (description "Encode/decode sourcemap mappings")
    (license license:expat)))

(define-public node-magic-string-0.30.10
  (package
    (name "node-magic-string")
    (version "0.30.10")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/magic-string/-/magic-string-0.30.10.tgz")
       (sha256
        (base32 "1xgcf56wkn05w7aryhzjm1z45cbs0vggw9hds6hfiaaaf0qf1wx8"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-jridgewell-sourcemap-codec" ,node-jridgewell-sourcemap-codec-1.4.15)))
    (home-page "https://github.com/rich-harris/magic-string#readme")
    (synopsis "Modify strings, generate sourcemaps")
    (description "Modify strings, generate sourcemaps")
    (license license:expat)))

(define-public node-estree-walker-3.0.3
  (package
    (name "node-estree-walker")
    (version "3.0.3")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/estree-walker/-/estree-walker-3.0.3.tgz")
       (sha256
        (base32 "1cvj3jfzlrg1dskkcwbjaccc00s16jma8mag8yg0kvyrdk0zvgdv"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-types-estree" ,node-types-estree-1.0.5)))
    (home-page "https://github.com/Rich-Harris/estree-walker#readme")
    (synopsis "Traverse an ESTree-compliant AST")
    (description "Traverse an ESTree-compliant AST")
    (license license:expat)))

(define-public node-types-estree-1.0.5
  (package
    (name "node-types-estree")
    (version "1.0.5")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/@types/estree/-/estree-1.0.5.tgz")
       (sha256
        (base32 "12h40j3xzrx0z4b4pwjbr23ffb1qjyymadbwc8psz4awm8wkvmqq"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (home-page
     "https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/estree")
    (synopsis "TypeScript definitions for estree")
    (description "TypeScript definitions for estree")
    (license license:expat)))

(define-public node-is-reference-3.0.2
  (package
    (name "node-is-reference")
    (version "3.0.2")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/is-reference/-/is-reference-3.0.2.tgz")
       (sha256
        (base32 "1l42qd9hnsanh3wcxavmy869k9w5qjv4qv9y2ddp3n9z8wklv9r7"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-types-estree" ,node-types-estree-1.0.5)))
    (home-page "https://github.com/Rich-Harris/is-reference#readme")
    (synopsis "Determine whether an AST node is a reference")
    (description "Determine whether an AST node is a reference")
    (license license:expat)))

(define-public node-periscopic-3.1.0
  (package
    (name "node-periscopic")
    (version "3.1.0")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/periscopic/-/periscopic-3.1.0.tgz")
       (sha256
        (base32 "0x3li12h1460syg2dssgaf2mq4bs06q0djb95wn13l6xs24py2iw"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-is-reference" ,node-is-reference-3.0.2)
              ("node-estree-walker" ,node-estree-walker-3.0.3)
              ("node-types-estree" ,node-types-estree-1.0.5)))
    (home-page "https://github.com/Rich-Harris/periscopic#readme")
    (synopsis "periscopic")
    (description "periscopic")
    (license license:expat)))

(define-public node-svelte-4.2.15
  (package
    (name "node-svelte")
    (version "4.2.15")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/svelte/-/svelte-4.2.15.tgz")
       (sha256
        (base32 "1dxz7x22lzk16ldn73310r0apnl0kmfq76icyr3cys2rl3g53ls6"))))
    (build-system node-build-system)
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build))))
    (inputs `(("node-periscopic" ,node-periscopic-3.1.0)
              ("node-magic-string" ,node-magic-string-0.30.10)
              ("node-locate-character" ,node-locate-character-3.0.0)
              ("node-is-reference" ,node-is-reference-3.0.2)
              ("node-estree-walker" ,node-estree-walker-3.0.3)
              ("node-css-tree" ,node-css-tree-2.3.1)
              ("node-code-red" ,node-code-red-1.0.4)
              ("node-axobject-query" ,node-axobject-query-4.0.0)
              ("node-aria-query" ,node-aria-query-5.3.0)
              ("node-acorn" ,node-acorn-8.11.3)
              ("node-types-estree" ,node-types-estree-1.0.5)
              ("node-jridgewell-trace-mapping" ,node-jridgewell-trace-mapping-0.3.25)
              ("node-jridgewell-sourcemap-codec" ,node-jridgewell-sourcemap-codec-1.4.15)
              ("node-ampproject-remapping" ,node-ampproject-remapping-2.3.0)))
    (home-page "https://svelte.dev")
    (synopsis "Cybernetically enhanced web apps")
    (description "Cybernetically enhanced web apps")
    (license license:expat)))

