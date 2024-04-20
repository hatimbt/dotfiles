(list (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch "master")
        (commit
          "0797fff8b8b3feb1e421aad170b4c12a87091663")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
      (channel
        (name 'nonguix)
        (url "file:///home/hatim/src/guile/nonguix")
        (branch "master")
        (commit
          "a4356defe7d4ee9b0ac6789d67f94d00714a9409"))
      (channel
        (name 'rde)
        (url "file:///home/hatim/src/guile/rde")
        (branch "master")
        (commit
          "3344ce422f1c3d6f3e43815bbca76992a0aa8e0a"))
      (channel
        (name 'home-service-dwl-guile)
        (url "file:///home/hatim/src/guile/home-service-dwl-guile")
        (branch "local")
        (commit
          "b242680651aff4a9c3b7f1e0ec8364d599b931c6"))
      (channel
        (name 'home-service-dtao-guile)
        (url "file:///home/hatim/src/guile/home-service-dtao-guile")
        (branch "local")
        (commit
          "dd0928d2012311f65b323e521a1e8b582ffdaec1"))
      (channel
        (name 'farg)
        (url "https://github.com/engstrand-config/farg")
        (branch "main")
        (commit
          "f84ffd7d65554a0c4b851ee80547fa8aa7142378")
        (introduction
          (make-channel-introduction
            "f94df02065d8691880dd5414e5c5ad27388d450f"
            (openpgp-fingerprint
              "C9BE B8A0 4458 FDDF 1268  1B39 029D 8EB7 7E18 D68C")))))
