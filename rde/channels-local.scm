(list (channel
       (name 'guix)
       (url "https://git.savannah.gnu.org/git/guix.git")
       (branch "master")
       (introduction
        (make-channel-introduction
         "9edb3f66fd807b096b48283debdcddccfea34bad"
         (openpgp-fingerprint
          "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
      (channel
       (name 'nonguix)
       (url (string-append "file://" (getenv "HOME") "/src/guile/nonguix"))
       (branch "master"))
      (channel
       (name 'rde)
       (url (string-append "file://" (getenv "HOME") "/src/guile/rde"))
       (branch "master"))
      (channel
       (name 'home-service-dwl-guile)
       (url (string-append "file://" (getenv "HOME") "/src/guile/home-service-dwl-guile"))
       (branch "local"))
      (channel
       (name 'home-service-dtao-guile)
       (url (string-append "file://" (getenv "HOME") "/src/guile/home-service-dtao-guile"))
       (branch "local"))
      (channel
       (name 'farg)
       (url "https://github.com/engstrand-config/farg")
       (branch "main")
       (introduction
        (make-channel-introduction
         "f94df02065d8691880dd5414e5c5ad27388d450f"
         (openpgp-fingerprint "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C")))))
