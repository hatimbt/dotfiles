# My GNU/Linux configuration based on Guix

[Guide to install Nonguix](https://dthompson.us/installing-guix-on-a-10th-gen-thinkpad-x1.html)

To use pre-built binaries,

```sh
wget https://substitutes.nonguix.org/signing-key.pub
mv signing-key.pub nonguix-signing-key.pub
sudo guix archive --authorize < nonguix-signing-key.pub
```

```sh
sudo -E guix system reconfigure config.scm --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org'
```
