(use-modules (guix channels))

(list (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch "master")
        (commit
          "4e9c5c601905eb281f2304d0a0d35992c51054cd")
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
          "1b0594dc534d834be6f3facec98dee13db2a2299"))
      (channel
        (name 'rde)
        (url "file:///home/hatim/src/guile/rde")
        (branch "master")
        (commit
          "8780ccdc185fb8eb971cb19920dad25c61190518")))
