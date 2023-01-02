# dotfiles
These dotfiles are setup to be used with [GNU Stow](https://www.gnu.org/software/stow/).

Clone the repo to your home directory, and run `stow` from within the `~/dotfiles` directory.

To setup config files for a given package, run the following:
```sh
stow <package-name>
```

To setup config files for all packages, run:
```sh
stow *
```

To remove config files for a package, run:
```sh
stow -D <package-name>
```

To remove config files for all packages, run:
```sh
stow -D *
```

## Setup on Windows

Currently the setup is manual on Windows, and is only supported for my work laptop. Clone this repository to the home directory in `C:\Users\<username>\`.

To make a symbolic link on Windows for a file, run Command Prompt as an Administrator, and run the below command:
```sh
mklink <linked-location> <file-location>
```

To create a soft link for a directory, run the following command:
```sh
mklink /D <linked-location> <directory-location>
```