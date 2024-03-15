# Emacs Configuration

This `emacs` configuration uses literate programming to generate the config files.

`init.org` contains codeblocks that can be exported to `init.el` by running the following:

```emacs
M-x ^org-babel-tangle
```

## Windows Setup
To use Emacs on windows, `cd` into the home directory, and create a soft symbolic link with `.config\emacs` as the `<linked-location>` and `dotfiles\emacs\.config\emacs` as the target <directory-location>.

## Useful commands
To add codeblocks to an `org` file, use: 
```<s TAB```

To add an `emacs-lisp` codeblock, use:
```<el TAB```
