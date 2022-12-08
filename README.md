# dotfiles
These dotfiles are setup to be used with [GNU Stow](https://www.gnu.org/software/stow/).

Clone the repo to your home directory, and run `stow` from within the `~/dotfiles` directory.

To setup the config files for a given package, run the following:
```sh
stow <package-name>
```

To setup the config files for all packages, run:
```sh
stow *
```

To remove a package, run:
```sh
stow -D <package-name>
```
